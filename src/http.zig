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
    /// HTTP connection keep-alive (default: true). Set to false when the
    /// server may omit Content-Length on responses, which would otherwise
    /// cause reads to block until the server's keep-alive timeout.
    keep_alive: bool = true,
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
            // Query values are already percent-encoded by the request serializer
            .query = if (self.query) |q| .{ .percent_encoded = q } else null,
        };
    }
};

/// HTTP response
pub const Response = struct {
    status: u16,
    body: []const u8,
    headers: std.StringHashMapUnmanaged([]const u8),
    allocator: Allocator,

    const Self = @This();

    pub fn deinit(self: *Self) void {
        var iter = self.headers.iterator();
        while (iter.next()) |entry| {
            self.allocator.free(entry.key_ptr.*);
            self.allocator.free(entry.value_ptr.*);
        }
        self.headers.deinit(self.allocator);
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

    /// Send a request and return a streaming response (connection stays open for body reads).
    /// No retry logic -- streaming responses cannot be replayed.
    pub fn sendStreamingRequest(self: *Self, request: *const Request) RequestError!StreamingResponse {
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

        // Heap-allocate Inner for pointer stability
        const inner = self.allocator.create(StreamingBody.Inner) catch return error.OutOfMemory;
        errdefer self.allocator.destroy(inner);
        inner.allocator = self.allocator;

        inner.http_request = self.inner.request(request.method.toStd(), uri, .{
            .extra_headers = extra_headers_list.items,
            .keep_alive = self.default_options.keep_alive,
        }) catch return error.ConnectionFailed;
        errdefer inner.http_request.deinit();

        // Send request with or without body
        {
            const req_body = request.body orelse "";
            if (req_body.len > 0 or request.method.toStd().requestHasBody()) {
                inner.http_request.transfer_encoding = .{ .content_length = req_body.len };
                var body_writer = inner.http_request.sendBodyUnflushed(&.{}) catch return error.RequestFailed;
                if (req_body.len > 0) {
                    body_writer.writer.writeAll(req_body) catch return error.RequestFailed;
                }
                body_writer.end() catch return error.RequestFailed;
                inner.http_request.connection.?.flush() catch return error.RequestFailed;
            } else {
                inner.http_request.sendBodiless() catch return error.RequestFailed;
            }
        }

        // Receive response head
        var redirect_buf: [8192]u8 = undefined;
        var response = inner.http_request.receiveHead(&redirect_buf) catch return error.RequestFailed;

        // Extract status and response headers before calling reader()
        // (reader() invalidates head string pointers)
        const status = @intFromEnum(response.head.status);

        var resp_headers = std.StringHashMapUnmanaged([]const u8){};
        var header_iter = response.head.iterateHeaders();
        while (header_iter.next()) |header| {
            const key = std.ascii.allocLowerString(self.allocator, header.name) catch return error.OutOfMemory;
            const value = self.allocator.dupe(u8, header.value) catch {
                self.allocator.free(key);
                return error.OutOfMemory;
            };
            resp_headers.put(self.allocator, key, value) catch {
                self.allocator.free(key);
                self.allocator.free(value);
                return error.OutOfMemory;
            };
        }

        // Initialize body reader -- this invalidates head strings but we've already duped them.
        // The returned pointer lives inside inner.http_request and remains valid.
        inner.body_reader = response.reader(&inner.transfer_buf);

        return StreamingResponse{
            .status = status,
            .headers = resp_headers,
            .body = StreamingBody{ ._inner = inner },
            .allocator = self.allocator,
        };
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
            .keep_alive = options.keep_alive,
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

        // Extract response headers (lowercase keys for case-insensitive lookup)
        var resp_headers = std.StringHashMapUnmanaged([]const u8){};
        var header_iter = response.head.iterateHeaders();
        while (header_iter.next()) |header| {
            const key = std.ascii.allocLowerString(self.allocator, header.name) catch return error.OutOfMemory;
            const value = self.allocator.dupe(u8, header.value) catch {
                self.allocator.free(key);
                return error.OutOfMemory;
            };
            resp_headers.put(self.allocator, key, value) catch {
                self.allocator.free(key);
                self.allocator.free(value);
                return error.OutOfMemory;
            };
        }

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
            .headers = resp_headers,
            .allocator = self.allocator,
        };
    }
};

/// Streaming body for responses where the HTTP connection stays open.
/// Used for `@streaming` blob payloads (e.g., S3 GetObject).
pub const StreamingBody = struct {
    _inner: *Inner,

    const Inner = struct {
        http_request: std.http.Client.Request,
        body_reader: *std.Io.Reader,
        transfer_buf: [8192]u8,
        allocator: Allocator,
    };

    /// Read entire remaining body into memory.
    pub fn readAll(self: *StreamingBody, allocator: Allocator, max_size: usize) ![]const u8 {
        return self._inner.body_reader.allocRemaining(
            allocator,
            std.Io.Limit.limited(max_size),
        ) catch |err| {
            return if (err == error.StreamTooLong) error.ResponseTooLarge else error.RequestFailed;
        };
    }

    pub fn deinit(self: *StreamingBody) void {
        self._inner.http_request.deinit();
        self._inner.allocator.destroy(self._inner);
    }
};

/// Streaming HTTP response -- keeps the connection open for body reads.
pub const StreamingResponse = struct {
    status: u16,
    headers: std.StringHashMapUnmanaged([]const u8),
    body: StreamingBody,
    allocator: Allocator,

    const Self = @This();

    pub fn isSuccess(self: Self) bool {
        return self.status >= 200 and self.status < 300;
    }

    /// Free headers only (body ownership transfers to output struct).
    pub fn deinitHeaders(self: *Self) void {
        var iter = self.headers.iterator();
        while (iter.next()) |entry| {
            self.allocator.free(entry.key_ptr.*);
            self.allocator.free(entry.value_ptr.*);
        }
        self.headers.deinit(self.allocator);
    }

    /// Free everything including body connection.
    pub fn deinit(self: *Self) void {
        self.deinitHeaders();
        self.body.deinit();
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
    const success = Response{ .status = 200, .body = "", .headers = .{}, .allocator = std.testing.allocator };
    try std.testing.expect(success.isSuccess());
    try std.testing.expect(!success.isServerError());
    try std.testing.expect(!success.isRetryable());

    const server_error = Response{ .status = 503, .body = "", .headers = .{}, .allocator = std.testing.allocator };
    try std.testing.expect(!server_error.isSuccess());
    try std.testing.expect(server_error.isServerError());
    try std.testing.expect(server_error.isRetryable());

    const rate_limit = Response{ .status = 429, .body = "", .headers = .{}, .allocator = std.testing.allocator };
    try std.testing.expect(rate_limit.isRetryable());

    const not_found = Response{ .status = 404, .body = "", .headers = .{}, .allocator = std.testing.allocator };
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
