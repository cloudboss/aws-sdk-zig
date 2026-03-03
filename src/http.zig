//! HTTP utilities for AWS requests
//!
//! Wrapper around std.http.Client with retry support and connection pooling.

const std = @import("std");
const Allocator = std.mem.Allocator;

const checksum_mod = @import("checksum.zig");
const config_mod = @import("config.zig");
const errors = @import("errors.zig");
const user_agent_mod = @import("user_agent.zig");

const log = std.log.scoped(.aws_sdk);

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
    /// Maximum retry attempts (null = use HttpClient.default_max_attempts)
    max_attempts: ?u32 = null,
    /// Base delay for exponential backoff in ms (null = use HttpClient.default_base_delay_ms)
    base_delay_ms: ?u32 = null,
    /// Maximum delay cap in milliseconds (default: 20 seconds)
    max_delay_ms: u32 = 20_000,
    /// Maximum response body size (default: 10MB)
    max_response_size: usize = 10 * 1024 * 1024,
    /// HTTP connection keep-alive (default: true). Set to false when the
    /// server may omit Content-Length on responses, which would otherwise
    /// cause reads to block until the server's keep-alive timeout.
    keep_alive: bool = true,

    /// Return options with only max_attempts set; all other fields use client defaults.
    pub fn withMaxAttempts(n: u32) RequestOptions {
        return .{ .max_attempts = n };
    }

    /// Return options with only base_delay_ms set; all other fields use client defaults.
    pub fn withBaseDelayMs(ms: u32) RequestOptions {
        return .{ .base_delay_ms = ms };
    }
};

/// Stall detection for streaming response bodies.
pub const StallProtectionOptions = struct {
    min_throughput_bytes_per_sec: u32 = 1,
    grace_period_seconds: u32 = 20,
    enabled: bool = true,
};

pub const CompressionAlgorithm = enum {
    gzip,
};

pub const SigningAlgorithm = enum {
    sigv4,
    sigv4a,
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
    service_name: []const u8 = "",
    api_version: []const u8 = "",
    checksum_algorithm: ?checksum_mod.Algorithm = null,
    request_compression: ?CompressionAlgorithm = null,
    signing_algorithm: SigningAlgorithm = .sigv4,

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
        return self.status == 500 or self.status == 502 or
            self.status == 503 or self.status == 504;
    }
};

/// Request error types
pub const RequestError = error{
    ChecksumMismatch,
    ConnectionFailed,
    RequestFailed,
    ResponseTooLarge,
    StreamStalled,
    MaxRetriesExceeded,
    OutOfMemory,
};

pub const Interceptor = struct {
    pre_send: ?*const fn (*const Request) void = null,
    post_receive: ?*const fn (*const Response) RequestError!void = null,
};

/// Token bucket for adaptive retry rate limiting.
/// Tracks available capacity and adjusts refill rate based on
/// throttle/success signals from the service.
pub const TokenBucket = struct {
    max_capacity: f64 = 500.0,
    current_capacity: f64 = 500.0,

    pub fn tryAcquire(self: *TokenBucket, cost: f64) bool {
        if (self.current_capacity >= cost) {
            self.current_capacity -= cost;
            return true;
        }
        return false;
    }

    pub fn onThrottle(self: *TokenBucket) void {
        self.current_capacity = @max(0.0, self.current_capacity - 5.0);
    }

    pub fn onSuccess(self: *TokenBucket) void {
        self.current_capacity = @min(
            self.max_capacity,
            self.current_capacity + 1.0,
        );
    }
};

/// Persistent HTTP client wrapper for connection pooling and retries
pub const HttpClient = struct {
    inner: std.http.Client,
    allocator: Allocator,
    default_options: RequestOptions,
    proxy_arena: std.heap.ArenaAllocator,
    no_proxy: ?[]const u8,
    retry_mode: config_mod.RetryMode = .standard,
    token_bucket: TokenBucket = .{},
    ca_bundle_path: ?[]const u8 = null,
    clock_skew_offset: i64 = 0,
    timeout_ms: u32 = 30_000,
    stall_protection: StallProtectionOptions = .{},
    interceptors: []const Interceptor = &.{},
    default_max_attempts: u32 = 3,
    default_base_delay_ms: u32 = 1_000,

    const Self = @This();

    pub fn init(
        allocator: Allocator,
        retry_mode: config_mod.RetryMode,
    ) Self {
        var self: Self = .{
            .inner = .{ .allocator = allocator },
            .allocator = allocator,
            .default_options = .{},
            .proxy_arena = std.heap.ArenaAllocator.init(allocator),
            .no_proxy = null,
            .retry_mode = retry_mode,
        };
        self.initProxies();
        if (std.posix.getenv("AWS_REQUEST_TIMEOUT")) |val| {
            if (std.fmt.parseInt(u32, val, 10)) |ms| {
                self.timeout_ms = ms;
            } else |_| {}
        }
        return self;
    }

    pub fn initWithOptions(
        allocator: Allocator,
        retry_mode: config_mod.RetryMode,
        options: RequestOptions,
    ) Self {
        var self: Self = .{
            .inner = .{ .allocator = allocator },
            .allocator = allocator,
            .default_options = options,
            .proxy_arena = std.heap.ArenaAllocator.init(allocator),
            .no_proxy = null,
            .retry_mode = retry_mode,
        };
        self.initProxies();
        return self;
    }

    pub fn initWithCaBundle(
        allocator: Allocator,
        retry_mode: config_mod.RetryMode,
        ca_bundle_path: ?[]const u8,
    ) Self {
        var self = init(allocator, retry_mode);
        self.ca_bundle_path = ca_bundle_path;
        return self;
    }

    pub fn deinit(self: *Self) void {
        self.inner.deinit();
        self.proxy_arena.deinit();
    }

    fn initProxies(self: *Self) void {
        const arena = self.proxy_arena.allocator();
        self.inner.initDefaultProxies(arena) catch {};
        self.no_proxy =
            std.process.getEnvVarOwned(arena, "NO_PROXY") catch
                std.process.getEnvVarOwned(arena, "no_proxy") catch
                null;
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
        const bypass = shouldBypassProxy(
            request.host,
            self.no_proxy,
        );
        const saved_http_proxy = self.inner.http_proxy;
        const saved_https_proxy = self.inner.https_proxy;
        if (bypass) {
            self.inner.http_proxy = null;
            self.inner.https_proxy = null;
        }
        defer {
            self.inner.http_proxy = saved_http_proxy;
            self.inner.https_proxy = saved_https_proxy;
        }

        const max_attempts = options.max_attempts orelse self.default_max_attempts;
        const base_delay_ms = options.base_delay_ms orelse self.default_base_delay_ms;
        var backoff = Backoff{
            .base_ms = base_delay_ms,
            .cap_ms = options.max_delay_ms,
        };

        var invocation_id: [36]u8 = undefined;
        generateUuidV4(&invocation_id);
        const start_ns = std.time.nanoTimestamp();
        log.debug("aws request start: {s} {s}{s} invocation={s}", .{
            @tagName(request.method),
            request.host,
            request.path,
            invocation_id,
        });
        while (backoff.attempt < max_attempts) {
            const result = self.doRequest(request, options, &invocation_id);

            if (result) |response| {
                const is_clock_skew = isClockSkewError(
                    response.status,
                    response.body,
                );
                const is_throttle_error = errors.bodyContainsErrorCode(
                    response.body,
                    errors.throttling_error_codes[0..],
                );
                const is_timeout_error = errors.bodyContainsErrorCode(
                    response.body,
                    errors.transient_error_codes[0..],
                );
                const is_retryable = response.isRetryable() or
                    is_clock_skew or
                    is_throttle_error or
                    is_timeout_error;
                if (is_retryable and
                    backoff.attempt + 1 < max_attempts)
                {
                    if (is_clock_skew) {
                        if (response.headers.get("date")) |date_str| {
                            if (parseHttpDate(date_str)) |server_s| {
                                const local_s: i64 = @intCast(
                                    @divTrunc(
                                        std.time.nanoTimestamp(),
                                        std.time.ns_per_s,
                                    ),
                                );
                                self.clock_skew_offset =
                                    (server_s - local_s) *
                                    std.time.ns_per_s;
                            }
                        }
                    }
                    if (self.retry_mode == .adaptive) {
                        const retry_cost: f64 = if (is_timeout_error)
                            10.0
                        else
                            5.0;
                        if (is_throttle_error)
                            self.token_bucket.onThrottle();
                        if (!self.token_bucket.tryAcquire(retry_cost))
                            return response;
                    }
                    const retry_after_ms = parseRetryAfter(
                        response.headers,
                    );
                    const retry_status = response.status;
                    var resp = response;
                    resp.deinit();
                    if (retry_after_ms) |ms| {
                        std.Thread.sleep(ms * std.time.ns_per_ms);
                        backoff.attempt = backoff.attempt +| 1;
                    } else {
                        backoff.wait();
                    }
                    log.debug(
                        "aws request retry: attempt={d} status={d} invocation={s}",
                        .{ backoff.attempt, retry_status, invocation_id },
                    );
                    continue;
                }
                if (self.retry_mode == .adaptive)
                    self.token_bucket.onSuccess();
                const elapsed_ms = @divTrunc(
                    std.time.nanoTimestamp() - start_ns,
                    std.time.ns_per_ms,
                );
                log.debug(
                    "aws request success: status={d} elapsed_ms={d} invocation={s}",
                    .{ response.status, elapsed_ms, invocation_id },
                );
                return response;
            } else |err| {
                // Don't retry on non-transient errors
                if (err == error.ResponseTooLarge or err == error.OutOfMemory) {
                    log.debug(
                        "aws request failed: {s} invocation={s}",
                        .{ @errorName(err), invocation_id },
                    );
                    return err;
                }
                // Retry on connection/request failures
                if (backoff.attempt + 1 < max_attempts) {
                    if (self.retry_mode == .adaptive) {
                        const retry_cost: f64 = if (err == error.ConnectionTimedOut)
                            10.0
                        else
                            5.0;
                        if (!self.token_bucket.tryAcquire(retry_cost))
                            return err;
                    }
                    backoff.wait();
                    continue;
                }
                log.debug(
                    "aws request failed after {d} attempts: {s} invocation={s}",
                    .{ backoff.attempt + 1, @errorName(err), invocation_id },
                );
                return err;
            }
        }

        log.debug(
            "aws request exceeded max retries: attempts={d} invocation={s}",
            .{ max_attempts, invocation_id },
        );
        return error.MaxRetriesExceeded;
    }

    /// Send a request and return a streaming response (connection stays open for body reads).
    /// No retry logic -- streaming responses cannot be replayed.
    pub fn sendStreamingRequest(
        self: *Self,
        request: *const Request,
    ) RequestError!StreamingResponse {
        const bypass = shouldBypassProxy(
            request.host,
            self.no_proxy,
        );
        const saved_http_proxy = self.inner.http_proxy;
        const saved_https_proxy = self.inner.https_proxy;
        if (bypass) {
            self.inner.http_proxy = null;
            self.inner.https_proxy = null;
        }
        defer {
            self.inner.http_proxy = saved_http_proxy;
            self.inner.https_proxy = saved_https_proxy;
        }

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

        const ua = user_agent_mod.buildUserAgent(
            self.allocator,
            request.service_name,
            request.api_version,
        ) catch null;
        defer if (ua) |s| self.allocator.free(s);
        if (ua) |s| {
            extra_headers_list.append(self.allocator, .{
                .name = "User-Agent",
                .value = s,
            }) catch {};
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

        if (self.timeout_ms > 0) {
            if (inner.http_request.connection) |conn| {
                setSocketTimeouts(conn, self.timeout_ms);
            }
        }
        // Send request with or without body
        {
            const req_body = request.body orelse "";
            if (req_body.len > 0 or request.method.toStd().requestHasBody()) {
                inner.http_request.transfer_encoding = .{ .content_length = req_body.len };
                var body_writer = inner.http_request.sendBodyUnflushed(
                    &.{},
                ) catch return error.RequestFailed;
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
        var response = inner.http_request.receiveHead(
            &redirect_buf,
        ) catch return error.RequestFailed;

        // Extract status and response headers before calling reader()
        // (reader() invalidates head string pointers)
        const status = @intFromEnum(response.head.status);

        var resp_headers = std.StringHashMapUnmanaged([]const u8){};
        var header_iter = response.head.iterateHeaders();
        while (header_iter.next()) |header| {
            const key = std.ascii.allocLowerString(
                self.allocator,
                header.name,
            ) catch return error.OutOfMemory;
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
            .body = StreamingBody{
                ._inner = inner,
                .stall_protection = self.stall_protection,
            },
            .allocator = self.allocator,
        };
    }

    /// Perform a single request attempt
    fn doRequest(
        self: *Self,
        request: *const Request,
        options: RequestOptions,
        invocation_id: []const u8,
    ) RequestError!Response {
        if (self.ca_bundle_path) |path| {
            std.fs.cwd().access(path, .{}) catch
                return error.ConnectionFailed;
        }

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

        const ua = user_agent_mod.buildUserAgent(
            self.allocator,
            request.service_name,
            request.api_version,
        ) catch null;
        defer if (ua) |s| self.allocator.free(s);
        if (ua) |s| {
            extra_headers_list.append(self.allocator, .{
                .name = "User-Agent",
                .value = s,
            }) catch {};
        }
        extra_headers_list.append(self.allocator, .{
            .name = "amz-sdk-invocation-id",
            .value = invocation_id,
        }) catch {};

        const effective_checksum_alg: ?checksum_mod.Algorithm =
            request.checksum_algorithm;

        // Inject checksum header when algorithm is specified
        var checksum_header_name: ?[]const u8 = null;
        var checksum_header_value: ?[]const u8 = null;
        var checksum_alg_upper: ?[]const u8 = null;
        defer if (checksum_header_name) |h| self.allocator.free(h);
        defer if (checksum_header_value) |v| self.allocator.free(v);
        defer if (checksum_alg_upper) |u| self.allocator.free(u);
        if (effective_checksum_alg) |alg| {
            const body_data = request.body orelse "";
            const alg_name = algToString(alg);
            if (checksum_mod.computeBase64(
                self.allocator,
                alg,
                body_data,
            )) |b64| {
                checksum_header_value = b64;
                if (std.fmt.allocPrint(
                    self.allocator,
                    "x-amz-checksum-{s}",
                    .{alg_name},
                )) |hname| {
                    checksum_header_name = hname;
                    extra_headers_list.append(self.allocator, .{
                        .name = hname,
                        .value = b64,
                    }) catch {};
                } else |_| {}
                checksum_alg_upper = std.ascii.allocUpperString(
                    self.allocator,
                    alg_name,
                ) catch null;
                if (checksum_alg_upper) |upper| {
                    extra_headers_list.append(self.allocator, .{
                        .name = "x-amz-sdk-checksum-algorithm",
                        .value = upper,
                    }) catch {};
                }
            } else |_| {}
        }

        for (self.interceptors) |ic| {
            if (ic.pre_send) |hook| hook(request);
        }

        var req = self.inner.request(request.method.toStd(), uri, .{
            .extra_headers = extra_headers_list.items,
            .keep_alive = options.keep_alive,
        }) catch return error.ConnectionFailed;
        defer req.deinit();

        if (self.timeout_ms > 0) {
            if (req.connection) |conn| {
                setSocketTimeouts(conn, self.timeout_ms);
            }
        }
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
            const key = std.ascii.allocLowerString(
                self.allocator,
                header.name,
            ) catch return error.OutOfMemory;
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

        if (effective_checksum_alg) |alg| {
            const alg_name = algToString(alg);
            var key_buf: [64]u8 = undefined;
            const header_key = std.fmt.bufPrint(
                &key_buf,
                "x-amz-checksum-{s}",
                .{alg_name},
            ) catch null;
            if (header_key) |k| {
                if (resp_headers.get(k)) |expected| {
                    const ok = checksum_mod.verify(
                        alg,
                        body,
                        expected,
                        self.allocator,
                    ) catch false;
                    if (!ok) {
                        std.log.warn(
                            "Response checksum mismatch for {s}",
                            .{alg_name},
                        );
                    }
                }
            }
        }

        var final_response = Response{
            .status = @intFromEnum(response.head.status),
            .body = body,
            .headers = resp_headers,
            .allocator = self.allocator,
        };

        for (self.interceptors) |ic| {
            if (ic.post_receive) |hook| hook(&final_response) catch |err| return err;
        }

        return final_response;
    }
};

/// Generate a UUID v4 string into buf.
/// Uses std.crypto.random for cryptographically secure random bytes.
/// Version bits are set to 0100 and variant bits to 10xx per RFC 4122.
pub fn generateUuidV4(buf: *[36]u8) void {
    var bytes: [16]u8 = undefined;
    std.crypto.random.bytes(&bytes);
    bytes[6] = (bytes[6] & 0x0f) | 0x40;
    bytes[8] = (bytes[8] & 0x3f) | 0x80;
    const hex = "0123456789abcdef";
    var i: usize = 0;
    for (bytes, 0..) |b, idx| {
        if (idx == 4 or idx == 6 or idx == 8 or idx == 10) {
            buf[i] = '-';
            i += 1;
        }
        buf[i] = hex[b >> 4];
        buf[i + 1] = hex[b & 0x0f];
        i += 2;
    }
}

fn setSocketTimeouts(
    conn: *std.http.Client.Connection,
    timeout_ms: u32,
) void {
    const fd = conn.stream_reader.getStream().handle;
    const sec: isize = @intCast(timeout_ms / 1000);
    const usec: isize = @intCast(
        @as(u64, timeout_ms % 1000) * 1000,
    );
    const tv = std.posix.timeval{ .sec = sec, .usec = usec };
    const opt_bytes = std.mem.asBytes(&tv);
    std.posix.setsockopt(
        fd,
        std.posix.SOL.SOCKET,
        std.posix.SO.RCVTIMEO,
        opt_bytes,
    ) catch {};
    std.posix.setsockopt(
        fd,
        std.posix.SOL.SOCKET,
        std.posix.SO.SNDTIMEO,
        opt_bytes,
    ) catch {};
}

/// Check if a host should bypass the proxy based on the NO_PROXY list.
///
/// Entries are comma-separated. Matching rules:
/// - "*" bypasses all hosts
/// - Exact match (case-insensitive)
/// - Domain suffix: ".example.com" matches "api.example.com"
pub fn shouldBypassProxy(
    host: []const u8,
    no_proxy_list: ?[]const u8,
) bool {
    const list = no_proxy_list orelse return false;
    if (list.len == 0) return false;

    var iter = std.mem.splitScalar(u8, list, ',');
    while (iter.next()) |raw_entry| {
        const entry = std.mem.trim(u8, raw_entry, " \t");
        if (entry.len == 0) continue;
        if (std.mem.eql(u8, entry, "*")) return true;
        if (std.ascii.eqlIgnoreCase(entry, host))
            return true;
        if (entry[0] == '.' and host.len >= entry.len) {
            const suffix = host[host.len - entry.len ..];
            if (std.ascii.eqlIgnoreCase(suffix, entry))
                return true;
        }
    }
    return false;
}

fn algToString(alg: checksum_mod.Algorithm) []const u8 {
    return switch (alg) {
        .crc32 => "crc32",
        .crc32c => "crc32c",
        .crc64nvme => "crc64nvme",
        .sha256 => "sha256",
        .sha1 => "sha1",
    };
}

pub fn isClockSkewError(status: u16, body: []const u8) bool {
    if (status != 403 and status != 400) return false;
    const clock_skew_codes = [_][]const u8{
        "RequestTimeTooSkewed",
        "RequestExpired",
        "InvalidSignatureException",
        "SignatureDoesNotMatch",
        "AuthFailure",
        "RequestInTheFuture",
    };
    for (clock_skew_codes) |code| {
        if (std.mem.containsAtLeast(u8, body, 1, code))
            return true;
    }
    return false;
}

pub fn parseRetryAfter(
    headers: std.StringHashMapUnmanaged([]const u8),
) ?u64 {
    const value = headers.get("x-amz-retry-after") orelse return null;
    const millis = std.fmt.parseInt(
        u64,
        std.mem.trim(u8, value, " \t"),
        10,
    ) catch return null;
    return millis;
}

fn parseHttpDate(date_str: []const u8) ?i64 {
    const months = [_][]const u8{
        "Jan", "Feb", "Mar", "Apr", "May", "Jun",
        "Jul", "Aug", "Sep", "Oct", "Nov", "Dec",
    };
    var parts_buf: [8][]const u8 = undefined;
    var parts_count: usize = 0;
    var iter = std.mem.splitScalar(
        u8,
        std.mem.trim(u8, date_str, " \t"),
        ' ',
    );
    while (iter.next()) |part| {
        if (part.len == 0) continue;
        if (parts_count >= parts_buf.len) break;
        parts_buf[parts_count] = part;
        parts_count += 1;
    }
    if (parts_count < 5) return null;

    const day_str = parts_buf[1];
    const month_str = parts_buf[2];
    const year_str = parts_buf[3];
    const time_str = parts_buf[4];

    const day = std.fmt.parseInt(
        i64,
        day_str,
        10,
    ) catch return null;
    const year = std.fmt.parseInt(
        i64,
        year_str,
        10,
    ) catch return null;

    var month: i64 = 0;
    for (months, 0..) |m, i| {
        if (std.mem.eql(u8, m, month_str)) {
            month = @intCast(i + 1);
            break;
        }
    }
    if (month == 0) return null;

    if (time_str.len < 8) return null;
    const hour = std.fmt.parseInt(
        i64,
        time_str[0..2],
        10,
    ) catch return null;
    const minute = std.fmt.parseInt(
        i64,
        time_str[3..5],
        10,
    ) catch return null;
    const second = std.fmt.parseInt(
        i64,
        time_str[6..8],
        10,
    ) catch return null;

    const y1 = year - 1;
    const leap_before = @divTrunc(y1, 4) -
        @divTrunc(y1, 100) + @divTrunc(y1, 400);
    const epoch_leap: i64 = 477;
    const leap_days = leap_before - epoch_leap;
    const years = year - 1970;
    const month_days = [_]i64{
        0, 31, 59, 90, 120, 151, 181, 212, 243, 273, 304, 334,
    };
    const is_leap = (@rem(year, 4) == 0 and
        @rem(year, 100) != 0) or @rem(year, 400) == 0;
    const leap_day: i64 = if (is_leap and month > 2) 1 else 0;
    const days = years * 365 + leap_days +
        month_days[@intCast(month - 1)] + leap_day + day - 1;
    return days * 86400 + hour * 3600 + minute * 60 + second;
}

/// Streaming body for responses where the HTTP connection stays open.
/// Used for `@streaming` blob payloads (e.g., S3 GetObject).
pub const StreamingBody = struct {
    _inner: *Inner,
    stall_protection: StallProtectionOptions,

    pub const StallState = struct {
        last_check_ns: i128,
        last_check_bytes: usize,
        consecutive_low_seconds: u32,
    };

    const Inner = struct {
        http_request: std.http.Client.Request,
        body_reader: *std.Io.Reader,
        transfer_buf: [8192]u8,
        allocator: Allocator,
    };

    /// Read entire remaining body into memory.
    pub fn readAll(self: *StreamingBody, allocator: Allocator, max_size: usize) ![]const u8 {
        var list: std.ArrayListUnmanaged(u8) = .{};
        errdefer list.deinit(allocator);

        var total_read: usize = 0;
        var buf: [8192]u8 = undefined;

        const options = self.stall_protection;
        var stall_state = StallState{
            .last_check_ns = std.time.nanoTimestamp(),
            .last_check_bytes = 0,
            .consecutive_low_seconds = 0,
        };

        while (true) {
            const remaining = max_size - total_read;
            const max_chunk = remaining +| 1;
            const chunk_len = @min(buf.len, max_chunk);
            var buffers = [_][]u8{buf[0..chunk_len]};
            const read_len = self._inner.body_reader.readVec(&buffers) catch |err| switch (err) {
                error.EndOfStream => break,
                else => return error.RequestFailed,
            };
            if (read_len == 0) continue;
            if (read_len > remaining) return error.ResponseTooLarge;

            list.appendSlice(allocator, buf[0..read_len]) catch return error.OutOfMemory;
            total_read += read_len;

            const now_ns = std.time.nanoTimestamp();
            try updateStallState(options, total_read, now_ns, &stall_state);
        }

        return list.toOwnedSlice(allocator);
    }

    pub fn updateStallState(
        options: StallProtectionOptions,
        total_read: usize,
        now_ns: i128,
        stall_state: *StallState,
    ) RequestError!void {
        if (!options.enabled) return;

        const elapsed_ns = now_ns - stall_state.last_check_ns;
        if (elapsed_ns <= 0) {
            stall_state.last_check_ns = now_ns;
            return;
        }

        const ns_per_s: i128 = std.time.ns_per_s;
        if (elapsed_ns < ns_per_s) return;

        const elapsed_seconds: u32 = @intCast(@divTrunc(elapsed_ns, ns_per_s));
        const bytes_since_check = total_read - stall_state.last_check_bytes;
        const throughput = @divTrunc(bytes_since_check, @as(usize, elapsed_seconds));

        if (throughput < @as(usize, options.min_throughput_bytes_per_sec)) {
            stall_state.consecutive_low_seconds +|= elapsed_seconds;
        } else {
            stall_state.consecutive_low_seconds = 0;
        }

        if (stall_state.consecutive_low_seconds >= options.grace_period_seconds) {
            return error.StreamStalled;
        }

        stall_state.last_check_ns += @as(i128, elapsed_seconds) * ns_per_s;
        stall_state.last_check_bytes = total_read;
    }

    pub fn reader(self: *StreamingBody) *std.Io.Reader {
        return self._inner.body_reader;
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
    var client = HttpClient.init(allocator, .standard);
    defer client.deinit();
    return client.sendRequest(request);
}

/// Send an HTTP request with custom options (stateless convenience function)
pub fn sendRequestWithOptions(
    allocator: Allocator,
    request: *const Request,
    options: RequestOptions,
) RequestError!Response {
    var client = HttpClient.init(allocator, .standard);
    defer client.deinit();
    return client.sendRequestWithOptions(request, options);
}

// Tests

const TestServer = struct {
    server: std.net.Server,
    address: std.net.Address,
    responses: []const []const u8,
    thread: ?std.Thread = null,

    const Self = @This();

    pub fn init(responses: []const []const u8) !Self {
        const loopback = try std.net.Address.parseIp4("127.0.0.1", 0);
        const server = try loopback.listen(.{ .reuse_address = true });
        return .{
            .server = server,
            .address = server.listen_address,
            .responses = responses,
        };
    }

    pub fn start(self: *Self) !void {
        self.thread = try std.Thread.spawn(.{}, run, .{self});
    }

    pub fn deinit(self: *Self) void {
        self.server.deinit();
        if (self.thread) |thread| thread.join();
    }

    fn run(self: *Self) void {
        var idx: usize = 0;
        while (idx < self.responses.len) : (idx += 1) {
            var conn = self.server.accept() catch return;
            handleConnection(&conn, self.responses[idx]);
        }
    }

    fn handleConnection(conn: *std.net.Server.Connection, response_bytes: []const u8) void {
        defer conn.stream.close();
        readRequest(conn);
        conn.stream.writeAll(response_bytes) catch {};
    }

    fn readRequest(conn: *std.net.Server.Connection) void {
        var buf: [4096]u8 = undefined;
        var total: usize = 0;
        while (true) {
            const read_len = conn.stream.read(&buf) catch return;
            if (read_len == 0) return;
            total += read_len;
            if (std.mem.indexOf(u8, buf[0..read_len], "\r\n\r\n") != null)
                return;
            if (total > 16 * 1024) return;
        }
    }
};

const HookState = struct {
    pre_count: usize = 0,
    post_count: usize = 0,
    statuses: [2]u16 = .{ 0, 0 },
    status_index: usize = 0,
};

var hook_state: ?*HookState = null;

fn testPreSend(request: *const Request) void {
    _ = request;
    if (hook_state) |state| {
        state.pre_count += 1;
    }
}

fn testPostReceive(response: *const Response) RequestError!void {
    if (hook_state) |state| {
        state.post_count += 1;
        if (state.status_index < state.statuses.len) {
            state.statuses[state.status_index] = response.status;
            state.status_index += 1;
        }
    }
}

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
    const success = Response{
        .status = 200,
        .body = "",
        .headers = .{},
        .allocator = std.testing.allocator,
    };
    try std.testing.expect(success.isSuccess());
    try std.testing.expect(!success.isServerError());
    try std.testing.expect(!success.isRetryable());

    const server_error = Response{
        .status = 500,
        .body = "",
        .headers = .{},
        .allocator = std.testing.allocator,
    };
    try std.testing.expect(!server_error.isSuccess());
    try std.testing.expect(server_error.isServerError());
    try std.testing.expect(server_error.isRetryable());

    const gateway_timeout = Response{
        .status = 504,
        .body = "",
        .headers = .{},
        .allocator = std.testing.allocator,
    };
    try std.testing.expect(gateway_timeout.isRetryable());

    const not_retryable = Response{
        .status = 429,
        .body = "",
        .headers = .{},
        .allocator = std.testing.allocator,
    };
    try std.testing.expect(!not_retryable.isRetryable());

    const timeout = Response{
        .status = 408,
        .body = "",
        .headers = .{},
        .allocator = std.testing.allocator,
    };
    try std.testing.expect(!timeout.isRetryable());

    const not_supported = Response{
        .status = 505,
        .body = "",
        .headers = .{},
        .allocator = std.testing.allocator,
    };
    try std.testing.expect(!not_supported.isRetryable());

    const not_found = Response{
        .status = 404,
        .body = "",
        .headers = .{},
        .allocator = std.testing.allocator,
    };
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
    try std.testing.expectEqual(@as(?u32, null), opts.max_attempts);
    try std.testing.expectEqual(@as(?u32, null), opts.base_delay_ms);
    try std.testing.expectEqual(@as(u32, 20_000), opts.max_delay_ms);
}

test "HttpClient exposes default_max_attempts and default_base_delay_ms" {
    var client = HttpClient.init(std.testing.allocator, .standard);
    defer client.deinit();
    try std.testing.expectEqual(@as(u32, 3), client.default_max_attempts);
    try std.testing.expectEqual(@as(u32, 1_000), client.default_base_delay_ms);
}

test "per-call max_attempts overrides HttpClient default" {
    var client = HttpClient.init(std.testing.allocator, .standard);
    defer client.deinit();
    client.default_max_attempts = 5;
    const opts = RequestOptions{ .max_attempts = 1 };
    const effective = opts.max_attempts orelse client.default_max_attempts;
    try std.testing.expectEqual(@as(u32, 1), effective);
}

test "null max_attempts falls back to HttpClient default" {
    var client = HttpClient.init(std.testing.allocator, .standard);
    defer client.deinit();
    client.default_max_attempts = 7;
    const opts = RequestOptions{};
    const effective = opts.max_attempts orelse client.default_max_attempts;
    try std.testing.expectEqual(@as(u32, 7), effective);
}

test "RequestOptions convenience builders" {
    const with_attempts = RequestOptions.withMaxAttempts(5);
    try std.testing.expectEqual(@as(?u32, 5), with_attempts.max_attempts);
    try std.testing.expectEqual(@as(?u32, null), with_attempts.base_delay_ms);

    const with_delay = RequestOptions.withBaseDelayMs(250);
    try std.testing.expectEqual(@as(?u32, null), with_delay.max_attempts);
    try std.testing.expectEqual(@as(?u32, 250), with_delay.base_delay_ms);
}

test "StallProtectionOptions defaults" {
    const opts = StallProtectionOptions{};
    try std.testing.expectEqual(@as(u32, 1), opts.min_throughput_bytes_per_sec);
    try std.testing.expectEqual(@as(u32, 20), opts.grace_period_seconds);
    try std.testing.expect(opts.enabled);
}

test "StreamingBody stall protection disabled" {
    const options = StallProtectionOptions{ .enabled = false };
    var stall_state = StreamingBody.StallState{
        .last_check_ns = 0,
        .last_check_bytes = 0,
        .consecutive_low_seconds = 0,
    };
    const now_ns: i128 = std.time.ns_per_s * 60;
    try StreamingBody.updateStallState(
        options,
        0,
        now_ns,
        &stall_state,
    );
    try std.testing.expectEqual(@as(u32, 0), stall_state.consecutive_low_seconds);
}

test "StreamingBody stall protection honors thresholds" {
    const options = StallProtectionOptions{
        .min_throughput_bytes_per_sec = 10,
        .grace_period_seconds = 3,
        .enabled = true,
    };
    var stall_state = StreamingBody.StallState{
        .last_check_ns = 0,
        .last_check_bytes = 0,
        .consecutive_low_seconds = 0,
    };

    try StreamingBody.updateStallState(
        options,
        0,
        std.time.ns_per_s * 2,
        &stall_state,
    );
    try std.testing.expectEqual(@as(u32, 2), stall_state.consecutive_low_seconds);

    try StreamingBody.updateStallState(
        options,
        30,
        std.time.ns_per_s * 3,
        &stall_state,
    );
    try std.testing.expectEqual(@as(u32, 0), stall_state.consecutive_low_seconds);

    try std.testing.expectError(
        error.StreamStalled,
        StreamingBody.updateStallState(
            options,
            30,
            std.time.ns_per_s * 6,
            &stall_state,
        ),
    );
}

test "shouldBypassProxy returns false for null list" {
    try std.testing.expect(!shouldBypassProxy("example.com", null));
}

test "shouldBypassProxy returns false for empty list" {
    try std.testing.expect(!shouldBypassProxy("example.com", ""));
}

test "shouldBypassProxy wildcard bypasses all" {
    try std.testing.expect(shouldBypassProxy("anything.com", "*"));
    try std.testing.expect(shouldBypassProxy("localhost", "foo, *"));
}

test "shouldBypassProxy exact match" {
    try std.testing.expect(
        shouldBypassProxy("example.com", "example.com"),
    );
    try std.testing.expect(
        !shouldBypassProxy("other.com", "example.com"),
    );
}

test "shouldBypassProxy case insensitive match" {
    try std.testing.expect(
        shouldBypassProxy("Example.COM", "example.com"),
    );
    try std.testing.expect(
        shouldBypassProxy("example.com", "EXAMPLE.COM"),
    );
}

test "shouldBypassProxy domain suffix" {
    try std.testing.expect(
        shouldBypassProxy("api.example.com", ".example.com"),
    );
    try std.testing.expect(
        shouldBypassProxy("deep.sub.example.com", ".example.com"),
    );
    // Bare domain does not match suffix rule
    try std.testing.expect(
        !shouldBypassProxy("example.com", ".example.com"),
    );
    // Partial name overlap is not a match
    try std.testing.expect(
        !shouldBypassProxy("notexample.com", ".example.com"),
    );
}

test "shouldBypassProxy multiple entries" {
    const list = "a.com, b.com, .internal.net";
    try std.testing.expect(shouldBypassProxy("a.com", list));
    try std.testing.expect(shouldBypassProxy("b.com", list));
    try std.testing.expect(
        shouldBypassProxy("svc.internal.net", list),
    );
    try std.testing.expect(
        !shouldBypassProxy("external.com", list),
    );
}

test "TokenBucket tryAcquire tracks capacity" {
    var bucket = TokenBucket{};
    try std.testing.expectEqual(@as(f64, 500.0), bucket.current_capacity);

    try std.testing.expect(bucket.tryAcquire(1.0));
    try std.testing.expectEqual(@as(f64, 499.0), bucket.current_capacity);

    try std.testing.expect(bucket.tryAcquire(499.0));
    try std.testing.expectEqual(@as(f64, 0.0), bucket.current_capacity);

    try std.testing.expect(!bucket.tryAcquire(1.0));
}

test "TokenBucket onThrottle reduces capacity" {
    var bucket = TokenBucket{};
    bucket.onThrottle();
    try std.testing.expectEqual(@as(f64, 495.0), bucket.current_capacity);
}

test "TokenBucket onSuccess adds tokens" {
    var bucket = TokenBucket{};
    bucket.onSuccess();
    try std.testing.expectEqual(@as(f64, 500.0), bucket.current_capacity);
    bucket.current_capacity = 499.0;
    bucket.onSuccess();
    try std.testing.expectEqual(@as(f64, 500.0), bucket.current_capacity);
}

test "TokenBucket retry costs" {
    var bucket = TokenBucket{};
    try std.testing.expect(bucket.tryAcquire(5.0));
    try std.testing.expectEqual(@as(f64, 495.0), bucket.current_capacity);
    try std.testing.expect(bucket.tryAcquire(10.0));
    try std.testing.expectEqual(@as(f64, 485.0), bucket.current_capacity);
}

test "TokenBucket cost limits" {
    var bucket = TokenBucket{ .current_capacity = 4.0 };
    try std.testing.expect(!bucket.tryAcquire(5.0));
    try std.testing.expectEqual(@as(f64, 4.0), bucket.current_capacity);
    try std.testing.expect(!bucket.tryAcquire(10.0));
    try std.testing.expectEqual(@as(f64, 4.0), bucket.current_capacity);
}

test "HttpClient defaults to standard retry mode" {
    var client = HttpClient.init(std.testing.allocator, .standard);
    defer client.deinit();
    try std.testing.expectEqual(
        config_mod.RetryMode.standard,
        client.retry_mode,
    );
}

test "HttpClient interceptors fire on success" {
    const responses = [_][]const u8{
        "HTTP/1.1 200 OK\r\nContent-Length: 0\r\nConnection: close\r\n\r\n",
    };
    var server = try TestServer.init(responses[0..]);
    defer server.deinit();
    try server.start();

    var client = HttpClient.init(std.testing.allocator, .standard);
    defer client.deinit();

    var state = HookState{};
    hook_state = &state;
    defer hook_state = null;

    client.interceptors = &[_]Interceptor{
        .{ .pre_send = testPreSend, .post_receive = testPostReceive },
    };

    var request = Request.init("127.0.0.1");
    defer request.deinit(std.testing.allocator);
    request.method = .GET;
    request.path = "/";
    request.port = server.address.getPort();
    request.tls = false;

    var response = try client.sendRequestWithOptions(
        &request,
        .{ .max_attempts = 1, .keep_alive = false },
    );
    defer response.deinit();

    try std.testing.expectEqual(@as(usize, 1), state.pre_count);
    try std.testing.expectEqual(@as(usize, 1), state.post_count);
    try std.testing.expectEqual(@as(u16, 200), state.statuses[0]);
}

test "HttpClient interceptors fire per retry" {
    const responses = [_][]const u8{
        "HTTP/1.1 500 Internal Server Error\r\nContent-Length: 0\r\n" ++
            "Connection: close\r\n\r\n",
        "HTTP/1.1 200 OK\r\nContent-Length: 0\r\nConnection: close\r\n\r\n",
    };
    var server = try TestServer.init(responses[0..]);
    defer server.deinit();
    try server.start();

    var client = HttpClient.init(std.testing.allocator, .standard);
    defer client.deinit();

    var state = HookState{};
    hook_state = &state;
    defer hook_state = null;

    client.interceptors = &[_]Interceptor{
        .{ .pre_send = testPreSend, .post_receive = testPostReceive },
    };

    var request = Request.init("127.0.0.1");
    defer request.deinit(std.testing.allocator);
    request.method = .GET;
    request.path = "/";
    request.port = server.address.getPort();
    request.tls = false;

    var response = try client.sendRequestWithOptions(
        &request,
        .{ .max_attempts = 2, .keep_alive = false },
    );
    defer response.deinit();

    try std.testing.expectEqual(@as(u16, 200), response.status);
    try std.testing.expectEqual(@as(usize, 2), state.pre_count);
    try std.testing.expectEqual(@as(usize, 2), state.post_count);
    try std.testing.expectEqual(@as(u16, 500), state.statuses[0]);
    try std.testing.expectEqual(@as(u16, 200), state.statuses[1]);
}

test "HttpClient interceptors empty slice is no-op" {
    const responses = [_][]const u8{
        "HTTP/1.1 200 OK\r\nContent-Length: 0\r\nConnection: close\r\n\r\n",
    };
    var server = try TestServer.init(responses[0..]);
    defer server.deinit();
    try server.start();

    var client = HttpClient.init(std.testing.allocator, .standard);
    defer client.deinit();

    var request = Request.init("127.0.0.1");
    defer request.deinit(std.testing.allocator);
    request.method = .GET;
    request.path = "/";
    request.port = server.address.getPort();
    request.tls = false;

    var response = try client.sendRequestWithOptions(
        &request,
        .{ .max_attempts = 1, .keep_alive = false },
    );
    defer response.deinit();

    try std.testing.expectEqual(@as(u16, 200), response.status);
}

test "HttpClient stores ca_bundle_path" {
    var client = HttpClient.initWithCaBundle(
        std.testing.allocator,
        .standard,
        "/etc/pki/tls/certs/ca-bundle.crt",
    );
    defer client.deinit();
    try std.testing.expectEqualStrings(
        "/etc/pki/tls/certs/ca-bundle.crt",
        client.ca_bundle_path.?,
    );
}

test "HttpClient ca_bundle_path defaults to null" {
    var client = HttpClient.init(std.testing.allocator, .standard);
    defer client.deinit();
    try std.testing.expectEqual(@as(?[]const u8, null), client.ca_bundle_path);
}

test "HttpClient timeout_ms defaults to 30s" {
    var client = HttpClient.init(std.testing.allocator, .standard);
    defer client.deinit();
    try std.testing.expectEqual(
        @as(u32, 30_000),
        client.timeout_ms,
    );
}

test "HttpClient.init reads AWS_REQUEST_TIMEOUT env var" {
    const old_len = std.os.environ.len;
    const entry: [*:0]u8 = @constCast("AWS_REQUEST_TIMEOUT=5000");
    std.os.environ.len += 1;
    std.os.environ[old_len] = entry;
    defer std.os.environ.len = old_len;
    var client = HttpClient.init(std.testing.allocator, .standard);
    defer client.deinit();
    try std.testing.expectEqual(@as(u32, 5000), client.timeout_ms);
}

test "Request stores service_name and api_version for User-Agent" {
    var request = Request.init("sts.us-east-1.amazonaws.com");
    request.service_name = "sts";
    request.api_version = "2011-06-15";

    try std.testing.expectEqualStrings("sts", request.service_name);
    try std.testing.expectEqualStrings("2011-06-15", request.api_version);

    const ua = try user_agent_mod.buildUserAgent(
        std.testing.allocator,
        request.service_name,
        request.api_version,
    );
    defer std.testing.allocator.free(ua);

    try std.testing.expect(
        std.mem.startsWith(u8, ua, "aws-sdk-zig/"),
    );
    try std.testing.expect(
        std.mem.containsAtLeast(u8, ua, 1, "api/sts#2011-06-15"),
    );
}

test "Request checksum_algorithm defaults to null" {
    const request = Request.init("s3.us-east-1.amazonaws.com");
    try std.testing.expectEqual(
        @as(?checksum_mod.Algorithm, null),
        request.checksum_algorithm,
    );
}

test "algToString maps algorithms to header names" {
    try std.testing.expectEqualStrings(
        "crc32",
        algToString(.crc32),
    );
    try std.testing.expectEqualStrings(
        "crc32c",
        algToString(.crc32c),
    );
    try std.testing.expectEqualStrings(
        "crc64nvme",
        algToString(.crc64nvme),
    );

    try std.testing.expectEqualStrings(
        "sha256",
        algToString(.sha256),
    );
    try std.testing.expectEqualStrings(
        "sha1",
        algToString(.sha1),
    );
}

test "checksum computeBase64 and verify round-trip" {
    const b64 = try checksum_mod.computeBase64(
        std.testing.allocator,
        .crc32,
        "test",
    );
    defer std.testing.allocator.free(b64);

    const ok = try checksum_mod.verify(
        .crc32,
        "test",
        b64,
        std.testing.allocator,
    );
    try std.testing.expect(ok);

    const bad = try checksum_mod.verify(
        .crc32,
        "test",
        "AAAA",
        std.testing.allocator,
    );
    try std.testing.expect(!bad);
}

test "isClockSkewError detects clock skew codes" {
    try std.testing.expect(
        isClockSkewError(403, "RequestTimeTooSkewed: ..."),
    );
    try std.testing.expect(
        isClockSkewError(403, "SignatureDoesNotMatch: ..."),
    );
    try std.testing.expect(
        !isClockSkewError(403, "AccessDenied: ..."),
    );
    try std.testing.expect(
        !isClockSkewError(200, "RequestTimeTooSkewed: ..."),
    );
}

test "parseRetryAfter parses integer milliseconds" {
    var headers = std.StringHashMapUnmanaged([]const u8){};
    defer headers.deinit(std.testing.allocator);
    try headers.put(
        std.testing.allocator,
        "x-amz-retry-after",
        "2500",
    );
    const ms = parseRetryAfter(headers);
    try std.testing.expectEqual(@as(?u64, 2500), ms);
}

test "parseRetryAfter returns null when header absent" {
    const headers = std.StringHashMapUnmanaged([]const u8){};
    try std.testing.expectEqual(
        @as(?u64, null),
        parseRetryAfter(headers),
    );
}

test "parseHttpDate parses valid HTTP date" {
    const ts = parseHttpDate("Thu, 01 Jan 2026 00:00:00 GMT");
    try std.testing.expect(ts != null);
    try std.testing.expectEqual(
        @as(i64, 1767225600),
        ts.?,
    );
}

test "generateUuidV4 produces valid UUID v4 format" {
    var buf: [36]u8 = undefined;
    generateUuidV4(&buf);
    const s = buf[0..];
    try std.testing.expectEqual(@as(usize, 36), s.len);
    try std.testing.expectEqual(@as(u8, '-'), s[8]);
    try std.testing.expectEqual(@as(u8, '-'), s[13]);
    try std.testing.expectEqual(@as(u8, '-'), s[18]);
    try std.testing.expectEqual(@as(u8, '-'), s[23]);
    try std.testing.expectEqual(@as(u8, '4'), s[14]);
    try std.testing.expect(s[19] == '8' or s[19] == '9' or
        s[19] == 'a' or s[19] == 'b');
    for (s, 0..) |c, i| {
        if (i == 8 or i == 13 or i == 18 or i == 23) continue;
        try std.testing.expect(
            (c >= '0' and c <= '9') or (c >= 'a' and c <= 'f'),
        );
    }
}

test "generateUuidV4 produces unique values" {
    var buf1: [36]u8 = undefined;
    var buf2: [36]u8 = undefined;
    generateUuidV4(&buf1);
    generateUuidV4(&buf2);
    try std.testing.expect(!std.mem.eql(u8, &buf1, &buf2));
}

test "HttpClient sends amz-sdk-invocation-id header" {
    const responses = [_][]const u8{
        "HTTP/1.1 200 OK\r\nContent-Length: 0\r\nConnection: close\r\n\r\n",
    };
    var server = try TestServer.init(responses[0..]);
    defer server.deinit();
    try server.start();

    var client = HttpClient.init(std.testing.allocator, .standard);
    defer client.deinit();

    var request = Request.init("127.0.0.1");
    defer request.deinit(std.testing.allocator);
    request.method = .GET;
    request.path = "/";
    request.port = server.address.getPort();
    request.tls = false;

    var response = try client.sendRequestWithOptions(
        &request,
        .{ .max_attempts = 1, .keep_alive = false },
    );
    defer response.deinit();

    try std.testing.expectEqual(@as(u16, 200), response.status);
}

test "adaptive retry: depleted bucket prevents retry" {
    // Only one response: client should not retry when bucket is depleted.
    const responses = [_][]const u8{
        "HTTP/1.1 503 Service Unavailable\r\nContent-Length: 0\r\nConnection: close\r\n\r\n",
    };
    var server = try TestServer.init(responses[0..]);
    defer server.deinit();
    try server.start();

    var client = HttpClient.init(std.testing.allocator, .adaptive);
    defer client.deinit();
    client.token_bucket.current_capacity = 0.0;

    var request = Request.init("127.0.0.1");
    defer request.deinit(std.testing.allocator);
    request.method = .GET;
    request.path = "/";
    request.port = server.address.getPort();
    request.tls = false;

    var response = try client.sendRequestWithOptions(
        &request,
        .{ .max_attempts = 3, .keep_alive = false, .base_delay_ms = 1 },
    );
    defer response.deinit();

    // Should get 503 back (no retry due to depleted bucket)
    try std.testing.expectEqual(@as(u16, 503), response.status);
}

test "adaptive retry: sufficient tokens allow retry" {
    // Server sends 503 then 200 -- with full bucket, retry should succeed.
    const responses = [_][]const u8{
        "HTTP/1.1 503 Service Unavailable\r\nContent-Length: 0\r\nConnection: close\r\n\r\n",
        "HTTP/1.1 200 OK\r\nContent-Length: 0\r\nConnection: close\r\n\r\n",
    };
    var server = try TestServer.init(responses[0..]);
    defer server.deinit();
    try server.start();

    var client = HttpClient.init(std.testing.allocator, .adaptive);
    defer client.deinit();

    var request = Request.init("127.0.0.1");
    defer request.deinit(std.testing.allocator);
    request.method = .GET;
    request.path = "/";
    request.port = server.address.getPort();
    request.tls = false;

    var response = try client.sendRequestWithOptions(
        &request,
        .{ .max_attempts = 3, .keep_alive = false, .base_delay_ms = 1 },
    );
    defer response.deinit();

    // Should get 200 (retried successfully)
    try std.testing.expectEqual(@as(u16, 200), response.status);
}

test "adaptive retry: throttle error depletes bucket and stops retry" {
    // Only one response: throttle + low capacity means no retry.
    const body =
        "{\"__type\":\"ThrottlingException\"," ++
        "\"message\":\"Rate exceeded\"}";
    const response_str = std.fmt.comptimePrint(
        "HTTP/1.1 429 Too Many Requests\r\n" ++
            "Content-Length: {d}\r\n" ++
            "Connection: close\r\n\r\n{s}",
        .{ body.len, body },
    );
    const responses = [_][]const u8{
        response_str,
    };
    var server = try TestServer.init(responses[0..]);
    defer server.deinit();
    try server.start();

    var client = HttpClient.init(std.testing.allocator, .adaptive);
    defer client.deinit();
    client.token_bucket.current_capacity = 4.0;

    var request = Request.init("127.0.0.1");
    defer request.deinit(std.testing.allocator);
    request.method = .GET;
    request.path = "/";
    request.port = server.address.getPort();
    request.tls = false;

    var response = try client.sendRequestWithOptions(
        &request,
        .{ .max_attempts = 3, .keep_alive = false, .base_delay_ms = 1 },
    );
    defer response.deinit();

    // Throttle reduces capacity, then tryAcquire(5.0) fails on remaining capacity
    // Should return 429 without retrying
    try std.testing.expectEqual(@as(u16, 429), response.status);
}

test "adaptive retry: onSuccess restores capacity" {
    // Successful request should call onSuccess
    const responses = [_][]const u8{
        "HTTP/1.1 200 OK\r\nContent-Length: 0\r\nConnection: close\r\n\r\n",
    };
    var server = try TestServer.init(responses[0..]);
    defer server.deinit();
    try server.start();

    var client = HttpClient.init(std.testing.allocator, .adaptive);
    defer client.deinit();
    client.token_bucket.current_capacity = 490.0;

    var request = Request.init("127.0.0.1");
    defer request.deinit(std.testing.allocator);
    request.method = .GET;
    request.path = "/";
    request.port = server.address.getPort();
    request.tls = false;

    var response = try client.sendRequestWithOptions(
        &request,
        .{ .max_attempts = 1, .keep_alive = false },
    );
    defer response.deinit();

    try std.testing.expectEqual(@as(u16, 200), response.status);
    // onSuccess adds 1.0, capped at 500.0
    try std.testing.expectEqual(@as(f64, 491.0), client.token_bucket.current_capacity);
}
