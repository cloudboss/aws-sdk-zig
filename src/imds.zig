//! EC2 Instance Metadata Service (IMDS) Client
//!
//! Provides access to EC2 instance metadata using IMDSv2 protocol.
//! Can be used standalone or through the credential chain.
//!
//! Reference: https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/instancedata-data-retrieval.html

const std = @import("std");
const Allocator = std.mem.Allocator;

/// Default IMDS endpoint (link-local address)
pub const default_endpoint = "http://169.254.169.254";

/// Default token TTL in seconds (6 hours max)
pub const default_token_ttl: u32 = 21600;

/// IMDS client for querying EC2 instance metadata
pub const Client = struct {
    allocator: Allocator,
    endpoint: []const u8,
    token_ttl: u32,

    /// Cached session token for IMDSv2
    session_token: ?[]const u8 = null,
    /// When the session token expires (epoch seconds)
    token_expiry: i64 = 0,

    const Self = @This();

    pub const Options = struct {
        endpoint: []const u8 = default_endpoint,
        token_ttl: u32 = default_token_ttl,
    };

    pub fn init(allocator: Allocator, options: Options) Self {
        return .{
            .allocator = allocator,
            .endpoint = options.endpoint,
            .token_ttl = options.token_ttl,
        };
    }

    pub fn deinit(self: *Self) void {
        if (self.session_token) |token| {
            self.allocator.free(token);
        }
    }

    /// Get metadata from an arbitrary path
    /// Path should start with / (e.g., "/latest/meta-data/instance-id")
    pub fn getMetadata(self: *Self, path: []const u8) ![]const u8 {
        const token = try self.getToken();
        return self.doGetRequest(path, token);
    }

    /// Get the AWS region from instance identity document
    pub fn getRegion(self: *Self) ![]const u8 {
        const doc = try self.getMetadata("/latest/dynamic/instance-identity/document");
        defer self.allocator.free(doc);

        // Parse JSON to extract region
        return parseJsonField(self.allocator, doc, "region");
    }

    /// Get the instance ID
    pub fn getInstanceId(self: *Self) ![]const u8 {
        return self.getMetadata("/latest/meta-data/instance-id");
    }

    /// Get IAM credentials for the instance's role
    pub fn getIamCredentials(self: *Self) !IamCredentials {
        // First, get the role name
        const role_name = try self.getMetadata("/latest/meta-data/iam/security-credentials/");
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
        const creds_json = try self.getMetadata(creds_path);
        defer self.allocator.free(creds_json);

        // Parse credentials
        return parseIamCredentials(self.allocator, creds_json);
    }

    /// Get or refresh the IMDSv2 session token
    fn getToken(self: *Self) ![]const u8 {
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
        const token = try self.doPutTokenRequest();
        self.session_token = token;
        self.token_expiry = now + @as(i64, self.token_ttl);
        return token;
    }

    /// PUT request to get IMDSv2 session token
    fn doPutTokenRequest(self: *Self) ![]const u8 {
        const ttl_str = try std.fmt.allocPrint(self.allocator, "{d}", .{self.token_ttl});
        defer self.allocator.free(ttl_str);

        const uri_str = try std.fmt.allocPrint(self.allocator, "{s}/latest/api/token", .{self.endpoint});
        defer self.allocator.free(uri_str);

        const uri = std.Uri.parse(uri_str) catch return error.ImdsRequestFailed;

        var client = std.http.Client{ .allocator = self.allocator };
        defer client.deinit();

        var req = client.request(.PUT, uri, .{
            .extra_headers = &.{
                .{ .name = "X-aws-ec2-metadata-token-ttl-seconds", .value = ttl_str },
            },
        }) catch return error.ImdsConnectionFailed;
        defer req.deinit();

        req.sendBodiless() catch return error.ImdsRequestFailed;

        var redirect_buf: [1024]u8 = undefined;
        var response = req.receiveHead(&redirect_buf) catch return error.ImdsRequestFailed;

        if (response.head.status != .ok) {
            return error.ImdsRequestFailed;
        }

        var transfer_buf: [1024]u8 = undefined;
        const body_reader = response.reader(&transfer_buf);
        const body = body_reader.allocRemaining(self.allocator, std.Io.Limit.limited(4096)) catch return error.ImdsRequestFailed;
        return body;
    }

    /// GET request with session token
    fn doGetRequest(self: *Self, path: []const u8, token: []const u8) ![]const u8 {
        const uri_str = try std.fmt.allocPrint(self.allocator, "{s}{s}", .{ self.endpoint, path });
        defer self.allocator.free(uri_str);

        const uri = std.Uri.parse(uri_str) catch return error.ImdsRequestFailed;

        var client = std.http.Client{ .allocator = self.allocator };
        defer client.deinit();

        var req = client.request(.GET, uri, .{
            .extra_headers = &.{
                .{ .name = "X-aws-ec2-metadata-token", .value = token },
            },
        }) catch return error.ImdsConnectionFailed;
        defer req.deinit();

        req.sendBodiless() catch return error.ImdsRequestFailed;

        var redirect_buf: [1024]u8 = undefined;
        var response = req.receiveHead(&redirect_buf) catch return error.ImdsRequestFailed;

        if (response.head.status == .not_found) {
            return error.ImdsNotFound;
        }
        if (response.head.status != .ok) {
            return error.ImdsRequestFailed;
        }

        var transfer_buf: [4096]u8 = undefined;
        const body_reader = response.reader(&transfer_buf);
        const body = body_reader.allocRemaining(self.allocator, std.Io.Limit.limited(64 * 1024)) catch return error.ImdsRequestFailed;
        return body;
    }
};

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

    const expiration = parseIso8601(expiration_str) catch 0;

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

/// Parse ISO 8601 timestamp to epoch seconds
fn parseIso8601(timestamp: []const u8) !i64 {
    // Format: 2024-01-15T12:00:00Z
    if (timestamp.len < 19) return error.InvalidTimestamp;

    const year = std.fmt.parseInt(u16, timestamp[0..4], 10) catch return error.InvalidTimestamp;
    const month = std.fmt.parseInt(u4, timestamp[5..7], 10) catch return error.InvalidTimestamp;
    const day = std.fmt.parseInt(u5, timestamp[8..10], 10) catch return error.InvalidTimestamp;
    const hour = std.fmt.parseInt(u5, timestamp[11..13], 10) catch return error.InvalidTimestamp;
    const minute = std.fmt.parseInt(u6, timestamp[14..16], 10) catch return error.InvalidTimestamp;
    const second = std.fmt.parseInt(u6, timestamp[17..19], 10) catch return error.InvalidTimestamp;

    // Calculate epoch day manually (days since 1970-01-01)
    const epoch_day = yearDayToEpochDay(year, dayOfYear(year, month, day));

    const day_seconds = @as(i64, hour) * 3600 + @as(i64, minute) * 60 + @as(i64, second);
    return epoch_day * 86400 + day_seconds;
}

/// Convert year and day-of-year to epoch day (days since 1970-01-01)
fn yearDayToEpochDay(year: u16, day_of_year: u9) i64 {
    var days: i64 = day_of_year;

    // Count days from 1970 to target year
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

/// Calculate day of year (0-indexed)
fn dayOfYear(year: u16, month: u4, day: u5) u9 {
    const days_before_month = [_]u16{ 0, 31, 59, 90, 120, 151, 181, 212, 243, 273, 304, 334 };
    var result: u16 = days_before_month[month - 1] + day - 1;

    // Add leap day if applicable
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

test "parseIso8601" {
    // 2024-01-15T12:00:00Z
    const ts = try parseIso8601("2024-01-15T12:00:00Z");
    // Verify it's approximately correct (within a day of expected)
    try std.testing.expect(ts > 1705300000);
    try std.testing.expect(ts < 1705400000);
}

test "dayOfYear" {
    // Jan 1 = day 0
    try std.testing.expectEqual(@as(u9, 0), dayOfYear(2024, 1, 1));
    // Feb 1 = day 31
    try std.testing.expectEqual(@as(u9, 31), dayOfYear(2024, 2, 1));
    // Mar 1 in leap year = day 60
    try std.testing.expectEqual(@as(u9, 60), dayOfYear(2024, 3, 1));
    // Mar 1 in non-leap year = day 59
    try std.testing.expectEqual(@as(u9, 59), dayOfYear(2023, 3, 1));
}

test "isLeapYear" {
    try std.testing.expect(isLeapYear(2024));
    try std.testing.expect(!isLeapYear(2023));
    try std.testing.expect(!isLeapYear(1900));
    try std.testing.expect(isLeapYear(2000));
}
