//! EC2 Instance Metadata Service (IMDS) Client
//!
//! Provides access to EC2 instance metadata using IMDSv2 protocol.
//! Can be used standalone or through the credential chain.
//!
//! Reference: https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/instancedata-data-retrieval.html

const std = @import("std");
const Allocator = std.mem.Allocator;
const log = std.log.scoped(.aws_sdk);

const http = @import("http.zig");
const date = @import("date.zig");

/// Default IMDS IPv4 endpoint (link-local address)
pub const default_ipv4_endpoint = "http://169.254.169.254";

/// Default IMDS IPv6 endpoint
pub const default_ipv6_endpoint = "http://[fd00:ec2::254]";

/// Default token TTL in seconds (6 hours max)
pub const default_token_ttl: u32 = 21600;

pub const EndpointMode = enum {
    ipv4,
    ipv6,

    pub fn fromString(str: []const u8) error{InvalidEndpointMode}!EndpointMode {
        if (std.ascii.eqlIgnoreCase(str, "IPv4")) return .ipv4;
        if (std.ascii.eqlIgnoreCase(str, "IPv6")) return .ipv6;
        return error.InvalidEndpointMode;
    }

    pub fn endpoint(self: EndpointMode) []const u8 {
        return switch (self) {
            .ipv4 => default_ipv4_endpoint,
            .ipv6 => default_ipv6_endpoint,
        };
    }
};

/// Error information from an IMDS request
pub const ServiceError = struct {
    kind: Kind,

    pub const Kind = union(enum) {
        unknown: UnknownError,

        pub fn code(self: Kind) []const u8 {
            return switch (self) {
                .unknown => |e| e.code,
            };
        }

        pub fn message(self: Kind) []const u8 {
            return switch (self) {
                .unknown => |e| e.message,
            };
        }

        pub fn httpStatus(self: Kind) u16 {
            return switch (self) {
                .unknown => |e| e.http_status,
            };
        }
    };

    pub fn code(self: ServiceError) []const u8 {
        return self.kind.code();
    }

    pub fn message(self: ServiceError) []const u8 {
        return self.kind.message();
    }

    pub fn httpStatus(self: ServiceError) u16 {
        return self.kind.httpStatus();
    }
};

pub const UnknownError = struct {
    code: []const u8 = "",
    message: []const u8 = "",
    http_status: u16 = 0,
};

/// Per-call options for IMDS requests
pub const CallOptions = struct {
    /// Optional error details to fill on error
    diagnostic: ?*ServiceError = null,
};

/// IMDS client for querying EC2 instance metadata
pub const Client = struct {
    allocator: Allocator,
    endpoint: []const u8,
    token_ttl: u32,
    http_client: http.HttpClient,

    /// Cached session token for IMDSv2
    session_token: ?[]const u8 = null,
    /// When the session token expires (epoch seconds)
    token_expiry: i64 = 0,

    const Self = @This();

    pub const Options = struct {
        endpoint: ?[]const u8 = null,
        endpoint_mode: ?EndpointMode = null,
        token_ttl: u32 = default_token_ttl,
    };

    pub fn init(allocator: Allocator, options: Options) !Self {
        return .{
            .allocator = allocator,
            .endpoint = try resolveEndpoint(options),
            .token_ttl = options.token_ttl,
            .http_client = http.HttpClient.init(allocator, .{
                .request_options = .{
                    .max_attempts = 3,
                    .base_delay_ms = 1_000,
                    .max_delay_ms = 1_000,
                    .max_response_size = 64 * 1024,
                },
            }),
        };
    }

    /// Resolve endpoint following AWS SDK precedence:
    /// 1. Programmatic endpoint URL
    /// 2. AWS_EC2_METADATA_SERVICE_ENDPOINT env var
    /// 3. Programmatic endpoint mode
    /// 4. AWS_EC2_METADATA_SERVICE_ENDPOINT_MODE env var
    /// 5. Default: IPv4
    fn resolveEndpoint(options: Options) ![]const u8 {
        if (options.endpoint) |ep| return ep;
        if (std.posix.getenv("AWS_EC2_METADATA_SERVICE_ENDPOINT")) |ep| return ep;
        if (options.endpoint_mode) |mode| return mode.endpoint();
        if (std.posix.getenv("AWS_EC2_METADATA_SERVICE_ENDPOINT_MODE")) |mode_str| {
            if (mode_str.len == 0) return default_ipv4_endpoint;
            return (try EndpointMode.fromString(mode_str)).endpoint();
        }
        return default_ipv4_endpoint;
    }

    pub fn deinit(self: *Self) void {
        if (self.session_token) |token| {
            self.allocator.free(token);
        }
        self.http_client.deinit();
    }

    /// Get metadata from an arbitrary path
    /// Path should start with / (e.g., "/latest/meta-data/instance-id")
    pub fn getMetadata(self: *Self, path: []const u8, options: CallOptions) ![]const u8 {
        const token = try self.getToken(options);
        return self.doGetRequest(path, token, options);
    }

    /// Get the AWS region from instance identity document
    pub fn getRegion(self: *Self, options: CallOptions) ![]const u8 {
        const doc = try self.getMetadata("/latest/dynamic/instance-identity/document", options);
        defer self.allocator.free(doc);

        return parseJsonField(self.allocator, doc, "region");
    }

    /// Get the instance ID
    pub fn getInstanceId(self: *Self, options: CallOptions) ![]const u8 {
        return self.getMetadata("/latest/meta-data/instance-id", options);
    }

    /// Get IAM credentials for the instance's role
    pub fn getIamCredentials(self: *Self, options: CallOptions) !IamCredentials {
        // First, get the role name
        const role_name = try self.getMetadata("/latest/meta-data/iam/security-credentials/", options);
        defer self.allocator.free(role_name);

        // Trim any trailing newline/whitespace
        const trimmed_role = std.mem.trim(u8, role_name, " \t\r\n");

        // Build the credentials path
        const creds_path = try std.fmt.allocPrint(
            self.allocator,
            "/latest/meta-data/iam/security-credentials/{s}",
            .{trimmed_role},
        );
        defer self.allocator.free(creds_path);

        // Get credentials JSON
        const creds_json = try self.getMetadata(creds_path, options);
        defer self.allocator.free(creds_json);

        // Parse credentials
        return parseIamCredentials(self.allocator, creds_json);
    }

    /// Get or refresh the IMDSv2 session token
    fn getToken(self: *Self, options: CallOptions) ![]const u8 {
        const now = std.time.timestamp();

        // Return cached token if still valid (with 5 minute buffer)
        if (self.session_token) |token| {
            if (now < self.token_expiry - 300) {
                return token;
            }
            // Token expired, free it
            self.allocator.free(token);
            self.session_token = null;
        }

        // Request new token via PUT
        const token = try self.doPutTokenRequest(options);
        self.session_token = token;
        self.token_expiry = now + @as(i64, self.token_ttl);
        return token;
    }

    /// Invalidate the cached session token
    fn invalidateToken(self: *Self) void {
        if (self.session_token) |token| {
            self.allocator.free(token);
            self.session_token = null;
            self.token_expiry = 0;
        }
    }

    /// PUT request to get IMDSv2 session token
    fn doPutTokenRequest(self: *Self, options: CallOptions) ![]const u8 {
        const ttl_str = try std.fmt.allocPrint(self.allocator, "{d}", .{self.token_ttl});
        defer self.allocator.free(ttl_str);

        const ep = try parseEndpoint(self.endpoint);

        var request = http.Request.init(ep.host);
        defer request.deinit(self.allocator);

        request.method = .PUT;
        request.path = "/latest/api/token";
        request.port = ep.port;
        request.tls = ep.tls;
        request.body = "";

        request.headers.put(self.allocator, "X-aws-ec2-metadata-token-ttl-seconds", ttl_str) catch
            return error.OutOfMemory;

        var response = self.http_client.sendRequest(&request) catch |err| {
            log.debug("IMDS token PUT failed: {s}", .{@errorName(err)});
            fillDiagnosticFromError(options.diagnostic, err, "token request failed");
            return err;
        };
        defer response.deinit();

        if (!response.isSuccess()) {
            log.debug("IMDS token PUT status={d} body={s}", .{ response.status, response.body });
            fillDiagnosticFromStatus(options.diagnostic, @intCast(response.status), "token request failed");
            return error.HttpError;
        }

        return self.allocator.dupe(u8, response.body) catch return error.OutOfMemory;
    }

    /// GET request with session token
    fn doGetRequest(self: *Self, path: []const u8, token: []const u8, options: CallOptions) ![]const u8 {
        // Ensure we always have a diagnostic to check for 401 status.
        var local_diag: ServiceError = undefined;
        const inner_options = if (options.diagnostic == null)
            CallOptions{ .diagnostic = &local_diag }
        else
            options;

        return self.doGetRequestInner(path, token, inner_options) catch |err| {
            // On 401, invalidate token and retry once
            if (err == error.HttpError) {
                const diag = inner_options.diagnostic.?;
                if (diag.httpStatus() == 401) {
                    self.invalidateToken();

                    // Get fresh token
                    const new_token = self.doPutTokenRequest(
                        inner_options,
                    ) catch return err;
                    self.session_token = new_token;
                    self.token_expiry = std.time.timestamp() + @as(i64, self.token_ttl);

                    // Retry with new token
                    return self.doGetRequestInner(
                        path,
                        new_token,
                        inner_options,
                    );
                }
            }
            return err;
        };
    }

    /// Inner GET request (used by doGetRequest for retry logic)
    fn doGetRequestInner(self: *Self, path: []const u8, token: []const u8, options: CallOptions) ![]const u8 {
        const ep = try parseEndpoint(self.endpoint);

        var request = http.Request.init(ep.host);
        defer request.deinit(self.allocator);

        request.method = .GET;
        request.path = path;
        request.port = ep.port;
        request.tls = ep.tls;

        request.headers.put(self.allocator, "X-aws-ec2-metadata-token", token) catch
            return error.OutOfMemory;

        var response = self.http_client.sendRequest(&request) catch |err| {
            log.debug("IMDS GET {s} failed: {s}", .{ path, @errorName(err) });
            fillDiagnosticFromError(options.diagnostic, err, "metadata request failed");
            return err;
        };
        defer response.deinit();

        if (!response.isSuccess()) {
            log.debug("IMDS GET {s} status={d} body={s}", .{ path, response.status, response.body });
            fillDiagnosticFromStatus(options.diagnostic, @intCast(response.status), "metadata request failed");
            return error.HttpError;
        }

        return self.allocator.dupe(u8, response.body) catch return error.OutOfMemory;
    }

    /// Parse endpoint into host, port, and TLS fields for http.Request
    const EndpointInfo = struct {
        host: []const u8,
        port: ?u16,
        tls: bool,
    };

    fn parseEndpoint(endpoint: []const u8) !EndpointInfo {
        const uri = std.Uri.parse(endpoint) catch return error.RequestFailed;
        const host = if (uri.host) |h| switch (h) {
            .raw => |r| r,
            .percent_encoded => |p| p,
        } else return error.RequestFailed;
        return .{
            .host = host,
            .port = uri.port,
            .tls = std.mem.eql(u8, uri.scheme, "https"),
        };
    }
};

/// Fill diagnostic from an HTTP-layer error
fn fillDiagnosticFromError(diagnostic: ?*ServiceError, err: http.RequestError, message: []const u8) void {
    if (diagnostic) |diag| {
        diag.* = .{ .kind = .{ .unknown = .{
            .message = message,
            .http_status = switch (err) {
                error.ChecksumMismatch => 0,
                error.ConnectionFailed => 0,
                error.RequestFailed => 0,
                error.ResponseTooLarge => 0,
                error.StreamStalled => 0,
                error.MaxRetriesExceeded => 0,
                error.OutOfMemory => 0,
            },
        } } };
    }
}

/// Fill diagnostic from a non-success HTTP status
fn fillDiagnosticFromStatus(diagnostic: ?*ServiceError, status: u16, message: []const u8) void {
    if (diagnostic) |diag| {
        diag.* = .{ .kind = .{ .unknown = .{
            .http_status = status,
            .message = message,
        } } };
    }
}

/// IAM credentials returned by IMDS
pub const IamCredentials = struct {
    access_key_id: []const u8,
    secret_access_key: []const u8,
    token: []const u8,
    expiration: i64,
    allocator: Allocator,

    const Self = @This();

    pub fn deinit(self: *Self) void {
        self.allocator.free(self.access_key_id);
        self.allocator.free(self.secret_access_key);
        self.allocator.free(self.token);
    }
};

/// Parse IAM credentials from IMDS JSON response
fn parseIamCredentials(allocator: Allocator, json: []const u8) !IamCredentials {
    const access_key = try parseJsonField(allocator, json, "AccessKeyId");
    errdefer allocator.free(access_key);

    const secret_key = try parseJsonField(allocator, json, "SecretAccessKey");
    errdefer allocator.free(secret_key);

    const token = try parseJsonField(allocator, json, "Token");
    errdefer allocator.free(token);

    const expiration_str = try parseJsonField(allocator, json, "Expiration");
    defer allocator.free(expiration_str);

    const expiration = try date.parseIso8601(expiration_str);

    return IamCredentials{
        .access_key_id = access_key,
        .secret_access_key = secret_key,
        .token = token,
        .expiration = expiration,
        .allocator = allocator,
    };
}

/// Simple JSON string field parser (no dependencies)
fn parseJsonField(allocator: Allocator, json: []const u8, field: []const u8) ![]const u8 {
    // Look for "field" : "value" or "field": "value"
    const search_pattern = try std.fmt.allocPrint(allocator, "\"{s}\"", .{field});
    defer allocator.free(search_pattern);

    const field_start = std.mem.indexOf(u8, json, search_pattern) orelse
        return error.JsonFieldNotFound;

    // Find the colon after the field name
    const after_field = json[field_start + search_pattern.len ..];
    const colon_pos = std.mem.indexOfScalar(u8, after_field, ':') orelse
        return error.JsonFieldNotFound;

    // Find the opening quote of the value
    const after_colon = after_field[colon_pos + 1 ..];
    const quote_start = std.mem.indexOfScalar(u8, after_colon, '"') orelse
        return error.JsonFieldNotFound;

    // Find the closing quote
    const value_start = after_colon[quote_start + 1 ..];
    const quote_end = std.mem.indexOfScalar(u8, value_start, '"') orelse
        return error.JsonFieldNotFound;

    return try allocator.dupe(u8, value_start[0..quote_end]);
}

// Tests

test "parseJsonField" {
    const allocator = std.testing.allocator;

    const json =
        \\{
        \\  "Code" : "Success",
        \\  "AccessKeyId" : "ASIAXXX",
        \\  "SecretAccessKey" : "secretXXX",
        \\  "Token" : "tokenXXX",
        \\  "Expiration" : "2024-01-15T12:00:00Z"
        \\}
    ;

    const access_key = try parseJsonField(allocator, json, "AccessKeyId");
    defer allocator.free(access_key);
    try std.testing.expectEqualStrings("ASIAXXX", access_key);

    const secret = try parseJsonField(allocator, json, "SecretAccessKey");
    defer allocator.free(secret);
    try std.testing.expectEqualStrings("secretXXX", secret);
}

test "parseJsonField returns error for missing field" {
    const allocator = std.testing.allocator;
    const json =
        \\{ "Name" : "value" }
    ;
    try std.testing.expectError(error.JsonFieldNotFound, parseJsonField(allocator, json, "Missing"));
}

test "parseJsonField extracts empty string value" {
    const allocator = std.testing.allocator;
    const json =
        \\{ "Key" : "" }
    ;
    const val = try parseJsonField(allocator, json, "Key");
    defer allocator.free(val);
    try std.testing.expectEqualStrings("", val);
}

test "parseJsonField returns error for empty JSON" {
    const allocator = std.testing.allocator;
    try std.testing.expectError(error.JsonFieldNotFound, parseJsonField(allocator, "", "Key"));
}

test "parseJsonField returns error for truncated JSON missing closing quote" {
    const allocator = std.testing.allocator;
    const json =
        \\{ "Key" : "no closing quote
    ;
    try std.testing.expectError(error.JsonFieldNotFound, parseJsonField(allocator, json, "Key"));
}

test "parseJsonField returns error for field without colon" {
    const allocator = std.testing.allocator;
    // Field name present but no colon follows
    const json =
        \\"Key"
    ;
    try std.testing.expectError(error.JsonFieldNotFound, parseJsonField(allocator, json, "Key"));
}

test "parseJsonField matches first occurrence of field name" {
    const allocator = std.testing.allocator;
    // When "Token" appears before "SecurityToken", verify it gets the right one
    const json =
        \\{
        \\  "Token" : "first_value",
        \\  "SecurityToken" : "second_value"
        \\}
    ;
    const val = try parseJsonField(allocator, json, "Token");
    defer allocator.free(val);
    try std.testing.expectEqualStrings("first_value", val);
}

test "parseIamCredentials parses valid IMDS JSON" {
    const allocator = std.testing.allocator;
    const json =
        \\{
        \\  "Code" : "Success",
        \\  "AccessKeyId" : "ASIAXXX",
        \\  "SecretAccessKey" : "secretXXX",
        \\  "Token" : "tokenXXX",
        \\  "Expiration" : "2024-01-15T12:00:00Z"
        \\}
    ;
    var creds = try parseIamCredentials(allocator, json);
    defer creds.deinit();

    try std.testing.expectEqualStrings("ASIAXXX", creds.access_key_id);
    try std.testing.expectEqualStrings("secretXXX", creds.secret_access_key);
    try std.testing.expectEqualStrings("tokenXXX", creds.token);
    try std.testing.expectEqual(@as(i64, 1705320000), creds.expiration);
}

test "parseIamCredentials returns error when AccessKeyId is missing" {
    const allocator = std.testing.allocator;
    const json =
        \\{
        \\  "SecretAccessKey" : "secretXXX",
        \\  "Token" : "tokenXXX",
        \\  "Expiration" : "2024-01-15T12:00:00Z"
        \\}
    ;
    try std.testing.expectError(error.JsonFieldNotFound, parseIamCredentials(allocator, json));
}

test "parseIamCredentials returns error when Token is missing" {
    const allocator = std.testing.allocator;
    const json =
        \\{
        \\  "AccessKeyId" : "ASIAXXX",
        \\  "SecretAccessKey" : "secretXXX",
        \\  "Expiration" : "2024-01-15T12:00:00Z"
        \\}
    ;
    try std.testing.expectError(error.JsonFieldNotFound, parseIamCredentials(allocator, json));
}

test "parseIamCredentials returns error for invalid expiration" {
    const allocator = std.testing.allocator;
    const json =
        \\{
        \\  "AccessKeyId" : "ASIAXXX",
        \\  "SecretAccessKey" : "secretXXX",
        \\  "Token" : "tokenXXX",
        \\  "Expiration" : "not-a-date"
        \\}
    ;
    try std.testing.expectError(error.InvalidTimestamp, parseIamCredentials(allocator, json));
}

test "IamCredentials deinit frees all allocated strings" {
    const allocator = std.testing.allocator;
    var creds = IamCredentials{
        .access_key_id = try allocator.dupe(u8, "access"),
        .secret_access_key = try allocator.dupe(u8, "secret"),
        .token = try allocator.dupe(u8, "token"),
        .expiration = 12345,
        .allocator = allocator,
    };
    // If deinit leaks, the testing allocator will catch it
    creds.deinit();
}

test "Client init with default options" {
    var client = try Client.init(std.testing.allocator, .{});
    defer client.deinit();
    try std.testing.expectEqualStrings(default_ipv4_endpoint, client.endpoint);
    try std.testing.expectEqual(default_token_ttl, client.token_ttl);
    try std.testing.expect(client.session_token == null);
    try std.testing.expectEqual(@as(i64, 0), client.token_expiry);
}

test "Client init with custom options" {
    var client = try Client.init(std.testing.allocator, .{
        .endpoint = "http://custom:1234",
        .token_ttl = 3600,
    });
    defer client.deinit();
    try std.testing.expectEqualStrings("http://custom:1234", client.endpoint);
    try std.testing.expectEqual(@as(u32, 3600), client.token_ttl);
}

test "Client init with endpoint mode" {
    var client_v4 = try Client.init(std.testing.allocator, .{ .endpoint_mode = .ipv4 });
    defer client_v4.deinit();
    try std.testing.expectEqualStrings(default_ipv4_endpoint, client_v4.endpoint);

    var client_v6 = try Client.init(std.testing.allocator, .{ .endpoint_mode = .ipv6 });
    defer client_v6.deinit();
    try std.testing.expectEqualStrings(default_ipv6_endpoint, client_v6.endpoint);
}

test "Client init explicit endpoint overrides endpoint mode" {
    var client = try Client.init(std.testing.allocator, .{
        .endpoint = "http://custom:1234",
        .endpoint_mode = .ipv6,
    });
    defer client.deinit();
    try std.testing.expectEqualStrings("http://custom:1234", client.endpoint);
}

test "Client deinit with null token does not crash" {
    var client = try Client.init(std.testing.allocator, .{});
    client.deinit();
}

test "Client deinit frees cached session token" {
    var client = try Client.init(std.testing.allocator, .{});
    client.session_token = try std.testing.allocator.dupe(u8, "test-token");
    // If deinit leaks, the testing allocator will catch it
    client.deinit();
}

test "Client invalidateToken clears cached token" {
    var client = try Client.init(std.testing.allocator, .{});
    defer client.deinit();

    client.session_token = try std.testing.allocator.dupe(u8, "test-token");
    client.token_expiry = 99999;

    client.invalidateToken();
    try std.testing.expect(client.session_token == null);
    try std.testing.expectEqual(@as(i64, 0), client.token_expiry);
}

test "Client invalidateToken with null token is safe" {
    var client = try Client.init(std.testing.allocator, .{});
    defer client.deinit();

    client.invalidateToken();
    try std.testing.expect(client.session_token == null);
}

test "fillDiagnosticFromStatus sets fields" {
    var diag: ServiceError = undefined;
    fillDiagnosticFromStatus(&diag, 404, "not found");
    try std.testing.expectEqual(@as(u16, 404), diag.httpStatus());
    try std.testing.expectEqualStrings("not found", diag.message());
    try std.testing.expectEqualStrings("", diag.code());
}

test "fillDiagnosticFromStatus with null diagnostic is safe" {
    fillDiagnosticFromStatus(null, 500, "error");
}

test "fillDiagnosticFromError sets fields" {
    var diag: ServiceError = undefined;
    fillDiagnosticFromError(&diag, error.ConnectionFailed, "connection failed");
    try std.testing.expectEqual(@as(u16, 0), diag.httpStatus());
    try std.testing.expectEqualStrings("connection failed", diag.message());
}

test "fillDiagnosticFromError with null diagnostic is safe" {
    fillDiagnosticFromError(null, error.RequestFailed, "error");
}

test "CallOptions defaults" {
    const opts = CallOptions{};
    try std.testing.expect(opts.diagnostic == null);
}
