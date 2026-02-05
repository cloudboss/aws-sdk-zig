//! ECS Container Credentials Provider
//!
//! Retrieves credentials from the ECS container metadata service.
//! Used when running in AWS ECS tasks or Fargate.
//!
//! Reference: https://docs.aws.amazon.com/sdkref/latest/guide/feature-container-credentials.html

const std = @import("std");
const Allocator = std.mem.Allocator;

/// Default ECS metadata endpoint (link-local address)
pub const default_endpoint = "http://169.254.170.2";

/// ECS container credentials provider
pub const Provider = struct {
    allocator: Allocator,

    const Self = @This();

    pub fn init(allocator: Allocator) Self {
        return .{ .allocator = allocator };
    }

    /// Load credentials from ECS container metadata service
    pub fn getCredentials(self: *Self) !Credentials {
        const uri = try self.resolveCredentialsUri();
        defer self.allocator.free(uri);

        const auth_token = try self.getAuthorizationToken();
        defer if (auth_token) |t| self.allocator.free(t);

        const json = try self.doRequest(uri, auth_token);
        defer self.allocator.free(json);

        return parseCredentials(self.allocator, json);
    }

    /// Resolve the credentials endpoint URI
    fn resolveCredentialsUri(self: *Self) ![]const u8 {
        // 1. Check for full URI
        if (std.posix.getenv("AWS_CONTAINER_CREDENTIALS_FULL_URI")) |full_uri| {
            return try self.allocator.dupe(u8, full_uri);
        }

        // 2. Check for relative URI (appended to default endpoint)
        if (std.posix.getenv("AWS_CONTAINER_CREDENTIALS_RELATIVE_URI")) |relative_uri| {
            return std.fmt.allocPrint(self.allocator, "{s}{s}", .{ default_endpoint, relative_uri });
        }

        return error.EcsCredentialsNotConfigured;
    }

    /// Get authorization token if configured
    fn getAuthorizationToken(self: *Self) !?[]const u8 {
        // 1. Check for token in environment variable
        if (std.posix.getenv("AWS_CONTAINER_AUTHORIZATION_TOKEN")) |token| {
            return try self.allocator.dupe(u8, token);
        }

        // 2. Check for token file
        if (std.posix.getenv("AWS_CONTAINER_AUTHORIZATION_TOKEN_FILE")) |token_file| {
            const file = std.fs.openFileAbsolute(token_file, .{}) catch |err| {
                if (err == error.FileNotFound) return null;
                return err;
            };
            defer file.close();

            const token = file.readToEndAlloc(self.allocator, 8192) catch return null;
            // Trim whitespace
            const trimmed = std.mem.trim(u8, token, " \t\r\n");
            if (trimmed.len == token.len) {
                return token;
            }
            defer self.allocator.free(token);
            return try self.allocator.dupe(u8, trimmed);
        }

        return null;
    }

    /// Make HTTP request to credentials endpoint
    fn doRequest(self: *Self, uri_str: []const u8, auth_token: ?[]const u8) ![]const u8 {
        const uri = std.Uri.parse(uri_str) catch return error.EcsRequestFailed;

        var client = std.http.Client{ .allocator = self.allocator };
        defer client.deinit();

        var extra_headers_buf: [1]std.http.Header = undefined;
        const extra_headers: []const std.http.Header = if (auth_token) |token| blk: {
            extra_headers_buf[0] = .{ .name = "Authorization", .value = token };
            break :blk &extra_headers_buf;
        } else &.{};

        var req = client.request(.GET, uri, .{
            .extra_headers = extra_headers,
        }) catch return error.EcsConnectionFailed;
        defer req.deinit();

        req.sendBodiless() catch return error.EcsRequestFailed;

        var redirect_buf: [1024]u8 = undefined;
        var response = req.receiveHead(&redirect_buf) catch return error.EcsRequestFailed;

        if (response.head.status != .ok) {
            return error.EcsRequestFailed;
        }

        var transfer_buf: [4096]u8 = undefined;
        const body_reader = response.reader(&transfer_buf);
        const body = body_reader.allocRemaining(self.allocator, std.Io.Limit.limited(64 * 1024)) catch return error.EcsRequestFailed;
        return body;
    }
};

/// Credentials returned by ECS metadata service
pub const Credentials = struct {
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

    /// Check if credentials are expired (with 5 minute buffer)
    pub fn isExpired(self: Self) bool {
        return std.time.timestamp() >= (self.expiration - 300);
    }
};

/// Parse credentials from ECS JSON response
fn parseCredentials(allocator: Allocator, json: []const u8) !Credentials {
    const access_key = try parseJsonField(allocator, json, "AccessKeyId");
    errdefer allocator.free(access_key);

    const secret_key = try parseJsonField(allocator, json, "SecretAccessKey");
    errdefer allocator.free(secret_key);

    const token = try parseJsonField(allocator, json, "Token");
    errdefer allocator.free(token);

    const expiration_str = try parseJsonField(allocator, json, "Expiration");
    defer allocator.free(expiration_str);

    const expiration = parseIso8601(expiration_str) catch 0;

    return Credentials{
        .access_key_id = access_key,
        .secret_access_key = secret_key,
        .token = token,
        .expiration = expiration,
        .allocator = allocator,
    };
}

/// Simple JSON string field parser
fn parseJsonField(allocator: Allocator, json: []const u8, field: []const u8) ![]const u8 {
    const search_pattern = try std.fmt.allocPrint(allocator, "\"{s}\"", .{field});
    defer allocator.free(search_pattern);

    const field_start = std.mem.indexOf(u8, json, search_pattern) orelse
        return error.JsonFieldNotFound;

    const after_field = json[field_start + search_pattern.len ..];
    const colon_pos = std.mem.indexOfScalar(u8, after_field, ':') orelse
        return error.JsonFieldNotFound;

    const after_colon = after_field[colon_pos + 1 ..];
    const quote_start = std.mem.indexOfScalar(u8, after_colon, '"') orelse
        return error.JsonFieldNotFound;

    const value_start = after_colon[quote_start + 1 ..];
    const quote_end = std.mem.indexOfScalar(u8, value_start, '"') orelse
        return error.JsonFieldNotFound;

    return try allocator.dupe(u8, value_start[0..quote_end]);
}

/// Parse ISO 8601 timestamp to epoch seconds
fn parseIso8601(timestamp: []const u8) !i64 {
    if (timestamp.len < 19) return error.InvalidTimestamp;

    const year = std.fmt.parseInt(u16, timestamp[0..4], 10) catch return error.InvalidTimestamp;
    const month = std.fmt.parseInt(u4, timestamp[5..7], 10) catch return error.InvalidTimestamp;
    const day = std.fmt.parseInt(u5, timestamp[8..10], 10) catch return error.InvalidTimestamp;
    const hour = std.fmt.parseInt(u5, timestamp[11..13], 10) catch return error.InvalidTimestamp;
    const minute = std.fmt.parseInt(u6, timestamp[14..16], 10) catch return error.InvalidTimestamp;
    const second = std.fmt.parseInt(u6, timestamp[17..19], 10) catch return error.InvalidTimestamp;

    const epoch_day = yearDayToEpochDay(year, dayOfYear(year, month, day));
    const day_seconds = @as(i64, hour) * 3600 + @as(i64, minute) * 60 + @as(i64, second);
    return epoch_day * 86400 + day_seconds;
}

fn yearDayToEpochDay(year: u16, day_of_year: u9) i64 {
    var days: i64 = day_of_year;

    if (year >= 1970) {
        var y: u16 = 1970;
        while (y < year) : (y += 1) {
            days += if (isLeapYear(y)) 366 else 365;
        }
    } else {
        var y: u16 = year;
        while (y < 1970) : (y += 1) {
            days -= if (isLeapYear(y)) 366 else 365;
        }
    }

    return days;
}

fn dayOfYear(year: u16, month: u4, day: u5) u9 {
    const days_before_month = [_]u16{ 0, 31, 59, 90, 120, 151, 181, 212, 243, 273, 304, 334 };
    var result: u16 = days_before_month[month - 1] + day - 1;

    if (month > 2 and isLeapYear(year)) {
        result += 1;
    }

    return @intCast(result);
}

fn isLeapYear(year: u16) bool {
    if (@mod(year, 4) != 0) return false;
    if (@mod(year, 100) != 0) return true;
    return @mod(year, 400) == 0;
}

// Tests

test "parseJsonField" {
    const allocator = std.testing.allocator;

    const json =
        \\{
        \\  "AccessKeyId" : "ASIAXXX",
        \\  "SecretAccessKey" : "secretXXX",
        \\  "Token" : "tokenXXX",
        \\  "Expiration" : "2024-01-15T12:00:00Z"
        \\}
    ;

    const access_key = try parseJsonField(allocator, json, "AccessKeyId");
    defer allocator.free(access_key);
    try std.testing.expectEqualStrings("ASIAXXX", access_key);

    const token = try parseJsonField(allocator, json, "Token");
    defer allocator.free(token);
    try std.testing.expectEqualStrings("tokenXXX", token);
}

test "parseIso8601" {
    const ts = try parseIso8601("2024-01-15T12:00:00Z");
    try std.testing.expect(ts > 1705300000);
    try std.testing.expect(ts < 1705400000);
}

test "resolveCredentialsUri with relative URI" {
    // This test would require setting environment variables
    // which we can't do reliably in unit tests
}

test "Credentials expiration" {
    var creds = Credentials{
        .access_key_id = "test",
        .secret_access_key = "test",
        .token = "test",
        .expiration = 0,
        .allocator = std.testing.allocator,
    };

    try std.testing.expect(creds.isExpired());

    creds.expiration = std.time.timestamp() + 3600;
    try std.testing.expect(!creds.isExpired());
}
