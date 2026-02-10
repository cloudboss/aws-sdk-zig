//! HTTP utilities for AWS requests
//!
//! Wrapper around std.http.Client with retry support and connection pooling.

const std = @import("std");
const Allocator = std.mem.Allocator;

/// HTTP methods
pub const Method = enum {
    GET,
    POST,
    PUT,
    DELETE,
    HEAD,
    PATCH,

    fn toStd(self: Method) std.http.Method {
        return switch (self) {
            .GET => .GET,
            .POST => .POST,
            .PUT => .PUT,
            .DELETE => .DELETE,
            .HEAD => .HEAD,
            .PATCH => .PATCH,
        };
    }
};

/// HTTP request options
pub const RequestOptions = struct {
    /// Maximum retry attempts (default: 3)
    max_attempts: u32 = 3,
    /// Base delay for exponential backoff in milliseconds (default: 100ms)
    base_delay_ms: u32 = 100,
    /// Maximum delay cap in milliseconds (default: 20 seconds)
    max_delay_ms: u32 = 20_000,
    /// Maximum response body size (default: 10MB)
    max_response_size: usize = 10 * 1024 * 1024,
};

/// HTTP request
pub const Request = struct {
    method: Method = .POST,
    host: []const u8,
    port: ?u16 = null,
    path: []const u8 = "/",
    query: ?[]const u8 = null,
    headers: std.StringHashMapUnmanaged([]const u8),
    body: ?[]const u8 = null,
    tls: bool = true,

    const Self = @This();

    pub fn init(host: []const u8) Self {
        return .{
            .host = host,
            .headers = std.StringHashMapUnmanaged([]const u8){},
        };
    }

    pub fn deinit(self: *Self, allocator: Allocator) void {
        self.headers.deinit(allocator);
    }

    /// Get full URI
    pub fn getUri(self: *const Self) std.Uri {
        return .{
            .scheme = if (self.tls) "https" else "http",
            .host = .{ .raw = self.host },
            .port = self.port,
            .path = .{ .raw = if (self.path.len > 0) self.path else "/" },
            .query = if (self.query) |q| .{ .raw = q } else null,
        };
    }
};

/// HTTP response
pub const Response = struct {
    status: u16,
    body: []const u8,
    allocator: Allocator,

    const Self = @This();

    pub fn deinit(self: *Self) void {
        self.allocator.free(self.body);
    }

    pub fn isSuccess(self: Self) bool {
        return self.status >= 200 and self.status < 300;
    }

    pub fn isServerError(self: Self) bool {
        return self.status >= 500;
    }

    pub fn isRetryable(self: Self) bool {
        // Retry on 5xx server errors and specific 4xx errors
        return self.status >= 500 or self.status == 429 or self.status == 408;
    }
};

/// Request error types
pub const RequestError = error{
    ConnectionFailed,
    RequestFailed,
    ResponseTooLarge,
    MaxRetriesExceeded,
    OutOfMemory,
};

/// Persistent HTTP client wrapper for connection pooling and retries
pub const HttpClient = struct {
    inner: std.http.Client,
    allocator: Allocator,
    default_options: RequestOptions,

    const Self = @This();

    pub fn init(allocator: Allocator) Self {
        return .{
            .inner = std.http.Client{ .allocator = allocator },
            .allocator = allocator,
            .default_options = .{},
        };
    }

    pub fn initWithOptions(allocator: Allocator, options: RequestOptions) Self {
        return .{
            .inner = std.http.Client{ .allocator = allocator },
            .allocator = allocator,
            .default_options = options,
        };
    }

    pub fn deinit(self: *Self) void {
        self.inner.deinit();
    }

    /// Send request with default options
    pub fn sendRequest(self: *Self, request: *const Request) RequestError!Response {
        return self.sendRequestWithOptions(request, self.default_options);
    }

    /// Send request with custom options
    pub fn sendRequestWithOptions(
        self: *Self,
        request: *const Request,
        options: RequestOptions,
    ) RequestError!Response {
        var backoff = Backoff{
            .base_ms = options.base_delay_ms,
            .cap_ms = options.max_delay_ms,
        };

        while (backoff.attempt < options.max_attempts) {
            const result = self.doRequest(request, options);

            if (result) |response| {
                // Check if we should retry based on status code
                if (response.isRetryable() and backoff.attempt + 1 < options.max_attempts) {
                    var resp = response;
                    resp.deinit();
                    backoff.wait();
                    continue;
                }
                return response;
            } else |err| {
                // Don't retry on non-transient errors
                if (err == error.ResponseTooLarge or err == error.OutOfMemory) {
                    return err;
                }
                // Retry on connection/request failures
                if (backoff.attempt + 1 < options.max_attempts) {
                    backoff.wait();
                    continue;
                }
                return err;
            }
        }

        return error.MaxRetriesExceeded;
    }

    /// Perform a single request attempt
    fn doRequest(self: *Self, request: *const Request, options: RequestOptions) RequestError!Response {
        const uri = request.getUri();

        // Build extra headers from request
        var extra_headers_list: std.ArrayListUnmanaged(std.http.Header) = .{};
        defer extra_headers_list.deinit(self.allocator);

        var iter = request.headers.iterator();
        while (iter.next()) |entry| {
            // Skip host header -- std.http.Client sets it from the URI
            if (std.ascii.eqlIgnoreCase(entry.key_ptr.*, "host")) continue;
            extra_headers_list.append(self.allocator, .{
                .name = entry.key_ptr.*,
                .value = entry.value_ptr.*,
            }) catch return error.OutOfMemory;
        }

        var req = self.inner.request(request.method.toStd(), uri, .{
            .extra_headers = extra_headers_list.items,
        }) catch return error.ConnectionFailed;
        defer req.deinit();

        // Send request with or without body
        {
            const req_body = request.body orelse "";
            if (req_body.len > 0 or request.method.toStd().requestHasBody()) {
                req.transfer_encoding = .{ .content_length = req_body.len };
                var body_writer = req.sendBodyUnflushed(&.{}) catch return error.RequestFailed;
                if (req_body.len > 0) {
                    body_writer.writer.writeAll(req_body) catch return error.RequestFailed;
                }
                body_writer.end() catch return error.RequestFailed;
                req.connection.?.flush() catch return error.RequestFailed;
            } else {
                req.sendBodiless() catch return error.RequestFailed;
            }
        }

        // Receive response head
        var redirect_buf: [8192]u8 = undefined;
        var response = req.receiveHead(&redirect_buf) catch return error.RequestFailed;

        // Read response body
        var transfer_buf: [8192]u8 = undefined;
        const body_reader = response.reader(&transfer_buf);
        const body = body_reader.allocRemaining(
            self.allocator,
            std.Io.Limit.limited(options.max_response_size),
        ) catch |err| {
            return if (err == error.StreamTooLong) error.ResponseTooLarge else error.RequestFailed;
        };

        return Response{
            .status = @intFromEnum(response.head.status),
            .body = body,
            .allocator = self.allocator,
        };
    }
};

/// Exponential backoff with full jitter.
/// Based on https://www.awsarchitectureblog.com/2015/03/backoff.html
pub const Backoff = struct {
    attempt: u32 = 0,
    base_ms: u64 = 100,
    cap_ms: u64 = 20_000,

    /// Wait with exponential backoff and jitter, then increment attempt
    pub fn wait(self: *Backoff) void {
        const max_wait = self.maxWaitMs();
        const wait_ms = if (max_wait > 0)
            std.crypto.random.intRangeLessThan(u64, 0, max_wait)
        else
            0;
        std.Thread.sleep(wait_ms * std.time.ns_per_ms);
        self.attempt = self.attempt +| 1;
    }

    /// Calculate max wait for current attempt (for testing)
    pub fn maxWaitMs(self: *const Backoff) u64 {
        const shift: u6 = @intCast(@min(self.attempt, 63));
        return @min(self.cap_ms, self.base_ms *| (@as(u64, 1) << shift));
    }

    /// Reset attempt counter
    pub fn reset(self: *Backoff) void {
        self.attempt = 0;
    }
};

/// Send an HTTP request using std.http.Client (stateless convenience function)
pub fn sendRequest(allocator: Allocator, request: *const Request) RequestError!Response {
    var client = HttpClient.init(allocator);
    defer client.deinit();
    return client.sendRequest(request);
}

/// Send an HTTP request with custom options (stateless convenience function)
pub fn sendRequestWithOptions(
    allocator: Allocator,
    request: *const Request,
    options: RequestOptions,
) RequestError!Response {
    var client = HttpClient.init(allocator);
    defer client.deinit();
    return client.sendRequestWithOptions(request, options);
}

// Tests

test "Request getUri" {
    var request = Request.init("sts.us-east-1.amazonaws.com");
    request.path = "/";
    request.query = "Action=GetCallerIdentity&Version=2011-06-15";

    const uri = request.getUri();
    try std.testing.expectEqualStrings("https", uri.scheme);
    try std.testing.expectEqualStrings("sts.us-east-1.amazonaws.com", uri.host.?.raw);
}

test "Request getUri with port" {
    var request = Request.init("localhost");
    request.port = 4566;
    request.tls = false;
    request.path = "/test";

    const uri = request.getUri();
    try std.testing.expectEqualStrings("http", uri.scheme);
    try std.testing.expectEqual(@as(u16, 4566), uri.port.?);
}

test "Response status helpers" {
    const success = Response{ .status = 200, .body = "", .allocator = std.testing.allocator };
    try std.testing.expect(success.isSuccess());
    try std.testing.expect(!success.isServerError());
    try std.testing.expect(!success.isRetryable());

    const server_error = Response{ .status = 503, .body = "", .allocator = std.testing.allocator };
    try std.testing.expect(!server_error.isSuccess());
    try std.testing.expect(server_error.isServerError());
    try std.testing.expect(server_error.isRetryable());

    const rate_limit = Response{ .status = 429, .body = "", .allocator = std.testing.allocator };
    try std.testing.expect(rate_limit.isRetryable());

    const not_found = Response{ .status = 404, .body = "", .allocator = std.testing.allocator };
    try std.testing.expect(!not_found.isRetryable());
}

test "Backoff max wait calculation" {
    var backoff = Backoff{ .base_ms = 100, .cap_ms = 10000 };

    // attempt 0: min(10000, 100 * 2^0) = 100
    try std.testing.expectEqual(@as(u64, 100), backoff.maxWaitMs());

    backoff.attempt = 1;
    // attempt 1: min(10000, 100 * 2^1) = 200
    try std.testing.expectEqual(@as(u64, 200), backoff.maxWaitMs());

    backoff.attempt = 2;
    // attempt 2: min(10000, 100 * 2^2) = 400
    try std.testing.expectEqual(@as(u64, 400), backoff.maxWaitMs());

    backoff.attempt = 7;
    // attempt 7: min(10000, 100 * 2^7) = min(10000, 12800) = 10000 (capped)
    try std.testing.expectEqual(@as(u64, 10000), backoff.maxWaitMs());
}

test "Backoff reset" {
    var backoff = Backoff{};
    backoff.attempt = 5;
    backoff.reset();
    try std.testing.expectEqual(@as(u32, 0), backoff.attempt);
}

test "RequestOptions defaults" {
    const opts = RequestOptions{};
    try std.testing.expectEqual(@as(u32, 3), opts.max_attempts);
    try std.testing.expectEqual(@as(u32, 100), opts.base_delay_ms);
    try std.testing.expectEqual(@as(u32, 20_000), opts.max_delay_ms);
}
