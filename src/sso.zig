//! SSO Credentials Provider
//!
//! Reads a cached SSO access token (created by `aws sso login`) and calls
//! the SSO portal GetRoleCredentials API to obtain temporary credentials.

const std = @import("std");
const Allocator = std.mem.Allocator;
const Sha1 = std.crypto.hash.Sha1;

const Credentials = @import("credentials.zig").Credentials;
const http = @import("http.zig");
const url_mod = @import("url.zig");

pub const SsoProvider = struct {
    sso_account_id: []const u8,
    sso_role_name: []const u8,
    sso_region: []const u8,
    cache_key: []const u8,
    cached: ?Credentials = null,

    const Self = @This();

    pub fn getCredentials(self: *Self, allocator: Allocator) !Credentials {
        if (self.cached) |c| if (!c.isExpired()) return c;

        const token = try readSsoCache(allocator, self.cache_key);
        defer allocator.free(token.access_token);

        if (token.isExpired()) return error.SsoTokenExpired;

        const creds = try callGetRoleCredentials(
            allocator,
            self.sso_region,
            self.sso_account_id,
            self.sso_role_name,
            token.access_token,
        );
        self.cached = creds;
        return creds;
    }
};

const SsoToken = struct {
    access_token: []const u8,
    expires_at: i64, // epoch seconds

    fn isExpired(self: SsoToken) bool {
        return std.time.timestamp() >= self.expires_at;
    }
};

/// Read SSO cache file at ~/.aws/sso/cache/{sha1(cache_key)}.json
fn readSsoCache(allocator: Allocator, cache_key: []const u8) !SsoToken {
    const home = std.posix.getenv("HOME") orelse return error.SsoTokenNotFound;

    // SHA1 hash of cache key
    var hash: [Sha1.digest_length]u8 = undefined;
    Sha1.hash(cache_key, &hash, .{});
    const hex = std.fmt.bytesToHex(hash, .lower);

    const path = try std.fmt.allocPrint(allocator, "{s}/.aws/sso/cache/{s}.json", .{ home, hex });
    defer allocator.free(path);

    const file = std.fs.openFileAbsolute(path, .{}) catch return error.SsoTokenNotFound;
    defer file.close();

    const content = file.readToEndAlloc(allocator, 64 * 1024) catch return error.SsoTokenNotFound;
    defer allocator.free(content);

    return parseSsoCacheJson(allocator, content);
}

/// Parse SSO cache JSON: { "accessToken": "...", "expiresAt": "2024-01-01T00:00:00UTC" }
fn parseSsoCacheJson(allocator: Allocator, json: []const u8) !SsoToken {
    const access_token_raw = findJsonStringValue(json, "accessToken") orelse return error.SsoTokenNotFound;
    const access_token = try allocator.dupe(u8, access_token_raw);
    errdefer allocator.free(access_token);

    const expires_at_str = findJsonStringValue(json, "expiresAt") orelse return error.SsoTokenNotFound;

    // Parse the expiresAt timestamp -- can be ISO 8601 with various suffixes
    const expires_at = parseExpiresAt(expires_at_str) catch return error.SsoTokenNotFound;

    return SsoToken{
        .access_token = access_token,
        .expires_at = expires_at,
    };
}

/// Parse SSO expiresAt which may end in "UTC" or "Z"
fn parseExpiresAt(timestamp: []const u8) !i64 {
    // Strip "UTC" suffix if present
    const ts = if (std.mem.endsWith(u8, timestamp, "UTC"))
        timestamp[0 .. timestamp.len - 3]
    else
        timestamp;

    if (ts.len < 19) return error.InvalidTimestamp;

    const year = std.fmt.parseInt(u16, ts[0..4], 10) catch return error.InvalidTimestamp;
    const month = std.fmt.parseInt(u4, ts[5..7], 10) catch return error.InvalidTimestamp;
    const day = std.fmt.parseInt(u5, ts[8..10], 10) catch return error.InvalidTimestamp;
    const hour = std.fmt.parseInt(u5, ts[11..13], 10) catch return error.InvalidTimestamp;
    const minute = std.fmt.parseInt(u6, ts[14..16], 10) catch return error.InvalidTimestamp;
    const second = std.fmt.parseInt(u6, ts[17..19], 10) catch return error.InvalidTimestamp;

    const days_before_month = [_]u16{ 0, 31, 59, 90, 120, 151, 181, 212, 243, 273, 304, 334 };
    if (month == 0 or month > 12 or day == 0) return error.InvalidTimestamp;
    var day_of_year: u16 = days_before_month[month - 1] + day - 1;
    if (month > 2 and isLeapYear(year)) day_of_year += 1;

    var days: i64 = day_of_year;
    if (year >= 1970) {
        var y: u16 = 1970;
        while (y < year) : (y += 1) {
            days += if (isLeapYear(y)) 366 else 365;
        }
    }

    return days * 86400 + @as(i64, hour) * 3600 + @as(i64, minute) * 60 + @as(i64, second);
}

fn isLeapYear(year: u16) bool {
    if (@mod(year, 4) != 0) return false;
    if (@mod(year, 100) != 0) return true;
    return @mod(year, 400) == 0;
}

/// Call SSO GetRoleCredentials API
fn callGetRoleCredentials(
    allocator: Allocator,
    sso_region: []const u8,
    account_id: []const u8,
    role_name: []const u8,
    access_token: []const u8,
) !Credentials {
    const endpoint = try std.fmt.allocPrint(allocator, "https://portal.sso.{s}.amazonaws.com", .{sso_region});
    defer allocator.free(endpoint);

    const host = url_mod.parseHost(endpoint);

    const path = try std.fmt.allocPrint(allocator, "/federation/credentials?role_name={s}&account_id={s}", .{ role_name, account_id });
    defer allocator.free(path);

    var request = http.Request.init(host);
    defer request.deinit(allocator);

    request.method = .GET;
    request.path = path;
    request.tls = true;

    try request.headers.put(allocator, "x-amz-sso_bearer_token", access_token);

    var response = try http.sendRequest(allocator, &request);
    defer response.deinit();

    if (!response.isSuccess()) return error.SsoRequestFailed;

    return parseSsoCredentialsJson(allocator, response.body);
}

/// Parse GetRoleCredentials JSON response
fn parseSsoCredentialsJson(allocator: Allocator, json: []const u8) !Credentials {
    // { "roleCredentials": { "accessKeyId": "...", ... } }
    const access_key_raw = findJsonStringValue(json, "accessKeyId") orelse return error.SsoResponseMissingField;
    const access_key = try allocator.dupe(u8, access_key_raw);
    errdefer allocator.free(access_key);

    const secret_key_raw = findJsonStringValue(json, "secretAccessKey") orelse return error.SsoResponseMissingField;
    const secret_key = try allocator.dupe(u8, secret_key_raw);
    errdefer allocator.free(secret_key);

    const session_token: ?[]const u8 = if (findJsonStringValue(json, "sessionToken")) |t|
        try allocator.dupe(u8, t)
    else
        null;
    errdefer if (session_token) |t| allocator.free(t);

    // expiration is epoch milliseconds (number, not string)
    const expiration: ?i64 = if (findJsonNumberValue(json, "expiration")) |ms|
        @divTrunc(ms, 1000)
    else
        null;

    return Credentials{
        .access_key_id = access_key,
        .secret_access_key = secret_key,
        .session_token = session_token,
        .expiration = expiration,
    };
}

/// Find a JSON string value for a given key. Returns slice borrowing from json.
fn findJsonStringValue(json: []const u8, field: []const u8) ?[]const u8 {
    var pos: usize = 0;
    while (pos < json.len) {
        const field_start = std.mem.indexOfPos(u8, json, pos, "\"") orelse return null;
        const after_quote = field_start + 1;
        if (after_quote + field.len > json.len) return null;

        if (std.mem.eql(u8, json[after_quote .. after_quote + field.len], field)) {
            const end_quote = after_quote + field.len;
            if (end_quote < json.len and json[end_quote] == '"') {
                const after_field = json[end_quote + 1 ..];
                const colon = std.mem.indexOfScalar(u8, after_field, ':') orelse return null;
                const after_colon = std.mem.trimLeft(u8, after_field[colon + 1 ..], " \t\r\n");
                if (after_colon.len > 0 and after_colon[0] == '"') {
                    const value_start = after_colon[1..];
                    const value_end = std.mem.indexOfScalar(u8, value_start, '"') orelse return null;
                    return value_start[0..value_end];
                }
                return null;
            }
        }
        pos = field_start + 1;
    }
    return null;
}

/// Find a JSON number value for a given key.
fn findJsonNumberValue(json: []const u8, field: []const u8) ?i64 {
    var pos: usize = 0;
    while (pos < json.len) {
        const field_start = std.mem.indexOfPos(u8, json, pos, "\"") orelse return null;
        const after_quote = field_start + 1;
        if (after_quote + field.len > json.len) return null;

        if (std.mem.eql(u8, json[after_quote .. after_quote + field.len], field)) {
            const end_quote = after_quote + field.len;
            if (end_quote < json.len and json[end_quote] == '"') {
                const after_field = json[end_quote + 1 ..];
                const colon = std.mem.indexOfScalar(u8, after_field, ':') orelse return null;
                const after_colon = std.mem.trimLeft(u8, after_field[colon + 1 ..], " \t\r\n");
                // Parse number
                var end: usize = 0;
                while (end < after_colon.len and (after_colon[end] >= '0' and after_colon[end] <= '9')) {
                    end += 1;
                }
                if (end == 0) return null;
                return std.fmt.parseInt(i64, after_colon[0..end], 10) catch null;
            }
        }
        pos = field_start + 1;
    }
    return null;
}

/// Compute the SHA1 hex of a cache key (exported for testing)
pub fn ssoCacheFilename(cache_key: []const u8) [Sha1.digest_length * 2]u8 {
    var hash: [Sha1.digest_length]u8 = undefined;
    Sha1.hash(cache_key, &hash, .{});
    return std.fmt.bytesToHex(hash, .lower);
}

// Tests

test "ssoCacheFilename" {
    const hex = ssoCacheFilename("my-sso");
    // SHA1("my-sso") -- just verify it's a valid hex string of correct length
    try std.testing.expectEqual(@as(usize, 40), hex.len);
    for (hex) |c| {
        try std.testing.expect((c >= '0' and c <= '9') or (c >= 'a' and c <= 'f'));
    }
}

test "parseSsoCacheJson valid" {
    const allocator = std.testing.allocator;
    const json =
        \\{
        \\  "accessToken": "eyJtoken",
        \\  "expiresAt": "2030-01-01T00:00:00UTC",
        \\  "region": "us-east-1",
        \\  "startUrl": "https://example.awsapps.com/start"
        \\}
    ;

    const token = try parseSsoCacheJson(allocator, json);
    defer allocator.free(token.access_token);

    try std.testing.expectEqualStrings("eyJtoken", token.access_token);
    try std.testing.expect(!token.isExpired());
}

test "parseSsoCacheJson with Z suffix" {
    const allocator = std.testing.allocator;
    const json =
        \\{
        \\  "accessToken": "eyJtoken2",
        \\  "expiresAt": "2030-01-01T00:00:00Z"
        \\}
    ;

    const token = try parseSsoCacheJson(allocator, json);
    defer allocator.free(token.access_token);

    try std.testing.expectEqualStrings("eyJtoken2", token.access_token);
}

test "parseSsoCacheJson expired" {
    const allocator = std.testing.allocator;
    const json =
        \\{
        \\  "accessToken": "expired-token",
        \\  "expiresAt": "2020-01-01T00:00:00UTC"
        \\}
    ;

    const token = try parseSsoCacheJson(allocator, json);
    defer allocator.free(token.access_token);

    try std.testing.expect(token.isExpired());
}

test "parseSsoCredentialsJson valid" {
    const allocator = std.testing.allocator;
    const json =
        \\{
        \\  "roleCredentials": {
        \\    "accessKeyId": "ASIAXXX",
        \\    "secretAccessKey": "secretXXX",
        \\    "sessionToken": "tokenXXX",
        \\    "expiration": 1704067200000
        \\  }
        \\}
    ;

    const creds = try parseSsoCredentialsJson(allocator, json);
    defer {
        allocator.free(creds.access_key_id);
        allocator.free(creds.secret_access_key);
        if (creds.session_token) |t| allocator.free(t);
    }

    try std.testing.expectEqualStrings("ASIAXXX", creds.access_key_id);
    try std.testing.expectEqualStrings("secretXXX", creds.secret_access_key);
    try std.testing.expectEqualStrings("tokenXXX", creds.session_token.?);
    // 1704067200000ms = 1704067200s
    try std.testing.expectEqual(@as(i64, 1704067200), creds.expiration.?);
}

test "findJsonStringValue" {
    const json =
        \\{ "name": "value", "other": "data" }
    ;

    try std.testing.expectEqualStrings("value", findJsonStringValue(json, "name").?);
    try std.testing.expectEqualStrings("data", findJsonStringValue(json, "other").?);
    try std.testing.expect(findJsonStringValue(json, "missing") == null);
}

test "findJsonNumberValue" {
    const json =
        \\{ "expiration": 1704067200000 }
    ;

    try std.testing.expectEqual(@as(i64, 1704067200000), findJsonNumberValue(json, "expiration").?);
    try std.testing.expect(findJsonNumberValue(json, "missing") == null);
}
