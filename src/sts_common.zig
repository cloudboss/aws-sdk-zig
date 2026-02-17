//! STS Common Helpers
//!
//! Shared HTTP helpers for credential providers that call STS directly.
//! Used by WebIdentityProvider (unsigned) and AssumeRoleProvider (signed).

const std = @import("std");
const Allocator = std.mem.Allocator;

const Credentials = @import("credentials.zig").Credentials;
const imds = @import("imds.zig");
const signing = @import("signing.zig");
const http = @import("http.zig");
const url_mod = @import("url.zig");
const xml = @import("xml.zig");

/// Build the STS endpoint URL for a region.
/// If endpoint_url is provided (e.g. LocalStack), returns a dupe of that.
/// Otherwise returns https://sts.{region}.amazonaws.com
pub fn stsEndpoint(allocator: Allocator, region: []const u8, endpoint_url: ?[]const u8) ![]const u8 {
    if (endpoint_url) |u| {
        return try allocator.dupe(u8, u);
    }
    return std.fmt.allocPrint(allocator, "https://sts.{s}.amazonaws.com", .{region});
}

/// Build a URL-encoded STS POST body from action name and key-value params.
pub fn buildStsRequestBody(allocator: Allocator, action: []const u8, params: []const [2][]const u8) ![]const u8 {
    var buf: std.ArrayList(u8) = .{};
    errdefer buf.deinit(allocator);

    try buf.appendSlice(allocator, "Action=");
    try url_mod.appendUrlEncoded(allocator, &buf, action);
    try buf.appendSlice(allocator, "&Version=2011-06-15");

    for (params) |param| {
        try buf.append(allocator, '&');
        try url_mod.appendUrlEncoded(allocator, &buf, param[0]);
        try buf.append(allocator, '=');
        try url_mod.appendUrlEncoded(allocator, &buf, param[1]);
    }

    return buf.toOwnedSlice(allocator);
}

/// POST to STS without SigV4 signing (for AssumeRoleWithWebIdentity).
pub fn callStsUnsigned(allocator: Allocator, endpoint: []const u8, body: []const u8) ![]const u8 {
    const host = url_mod.parseHost(endpoint);
    const port = url_mod.parsePort(endpoint);
    const tls = if (std.mem.indexOf(u8, endpoint, "https://")) |_| true else false;

    var request = http.Request.init(host);
    defer request.deinit(allocator);

    request.method = .POST;
    request.path = "/";
    request.port = port;
    request.tls = tls;
    request.body = body;

    try request.headers.put(allocator, "Content-Type", "application/x-www-form-urlencoded");

    var response = try http.sendRequest(allocator, &request);
    defer response.deinit();

    if (!response.isSuccess()) {
        return error.StsRequestFailed;
    }

    return try allocator.dupe(u8, response.body);
}

/// POST to STS with SigV4 signing (for AssumeRole).
/// Uses a local arena for request construction and signing so that all
/// heap-allocated header values (x-amz-date, authorization, etc.) are
/// freed automatically.
pub fn callStsSigned(allocator: Allocator, endpoint: []const u8, body: []const u8, creds: Credentials, region: []const u8) ![]const u8 {
    const host = url_mod.parseHost(endpoint);
    const port = url_mod.parsePort(endpoint);
    const tls = if (std.mem.indexOf(u8, endpoint, "https://")) |_| true else false;

    // Arena for request + signing allocations (header values, canonical request, etc.)
    var arena = std.heap.ArenaAllocator.init(allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = http.Request.init(host);

    request.method = .POST;
    request.path = "/";
    request.port = port;
    request.tls = tls;
    request.body = body;

    try request.headers.put(alloc, "Content-Type", "application/x-www-form-urlencoded");

    // Add host header for signing (with port if non-default)
    if (port) |p| {
        const host_with_port = try std.fmt.allocPrint(alloc, "{s}:{d}", .{ host, p });
        try request.headers.put(alloc, "host", host_with_port);
    } else {
        try request.headers.put(alloc, "host", host);
    }

    try signing.signRequest(alloc, &request, creds, region, "sts");

    var response = try http.sendRequest(allocator, &request);
    defer response.deinit();

    if (!response.isSuccess()) {
        return error.StsRequestFailed;
    }

    return try allocator.dupe(u8, response.body);
}

/// Parse <Credentials> block from STS XML response body.
pub fn parseStsCredentials(allocator: Allocator, body: []const u8) !Credentials {
    var reader = xml.Reader.init(body);

    var access_key: ?[]const u8 = null;
    errdefer if (access_key) |k| allocator.free(k);
    var secret_key: ?[]const u8 = null;
    errdefer if (secret_key) |k| allocator.free(k);
    var session_token: ?[]const u8 = null;
    errdefer if (session_token) |t| allocator.free(t);
    var expiration: ?i64 = null;

    var in_credentials = false;

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |start| {
                const name = start.local;
                if (std.mem.eql(u8, name, "Credentials")) {
                    in_credentials = true;
                } else if (in_credentials) {
                    if (std.mem.eql(u8, name, "AccessKeyId")) {
                        const text = try reader.readElementText();
                        access_key = try allocator.dupe(u8, text);
                    } else if (std.mem.eql(u8, name, "SecretAccessKey")) {
                        const text = try reader.readElementText();
                        secret_key = try allocator.dupe(u8, text);
                    } else if (std.mem.eql(u8, name, "SessionToken")) {
                        const text = try reader.readElementText();
                        session_token = try allocator.dupe(u8, text);
                    } else if (std.mem.eql(u8, name, "Expiration")) {
                        const text = try reader.readElementText();
                        expiration = imds.parseIso8601(text) catch null;
                    }
                }
            },
            else => {},
        }
    }

    const ak = access_key orelse return error.StsResponseMissingField;
    const sk = secret_key orelse return error.StsResponseMissingField;

    return Credentials{
        .access_key_id = ak,
        .secret_access_key = sk,
        .session_token = session_token,
        .expiration = expiration,
    };
}

// Tests

test "buildStsRequestBody basic" {
    const allocator = std.testing.allocator;
    const body = try buildStsRequestBody(allocator, "AssumeRoleWithWebIdentity", &.{
        .{ "RoleArn", "arn:aws:iam::123:role/Test" },
        .{ "RoleSessionName", "my-session" },
    });
    defer allocator.free(body);

    try std.testing.expect(std.mem.indexOf(u8, body, "Action=AssumeRoleWithWebIdentity") != null);
    try std.testing.expect(std.mem.indexOf(u8, body, "Version=2011-06-15") != null);
    try std.testing.expect(std.mem.indexOf(u8, body, "RoleArn=") != null);
    try std.testing.expect(std.mem.indexOf(u8, body, "RoleSessionName=my-session") != null);
}

test "buildStsRequestBody url encodes special characters" {
    const allocator = std.testing.allocator;
    const body = try buildStsRequestBody(allocator, "AssumeRole", &.{
        .{ "RoleArn", "arn:aws:iam::123:role/Test Role" },
    });
    defer allocator.free(body);

    // Space should be encoded as +
    try std.testing.expect(std.mem.indexOf(u8, body, "Test+Role") != null);
}

test "stsEndpoint with region" {
    const allocator = std.testing.allocator;
    const ep = try stsEndpoint(allocator, "us-east-1", null);
    defer allocator.free(ep);

    try std.testing.expectEqualStrings("https://sts.us-east-1.amazonaws.com", ep);
}

test "stsEndpoint with custom endpoint" {
    const allocator = std.testing.allocator;
    const ep = try stsEndpoint(allocator, "us-east-1", "http://localhost:4566");
    defer allocator.free(ep);

    try std.testing.expectEqualStrings("http://localhost:4566", ep);
}

test "parseStsCredentials valid XML" {
    const allocator = std.testing.allocator;
    const body =
        \\<AssumeRoleWithWebIdentityResponse>
        \\  <AssumeRoleWithWebIdentityResult>
        \\    <Credentials>
        \\      <AccessKeyId>ASIAXXX</AccessKeyId>
        \\      <SecretAccessKey>secretXXX</SecretAccessKey>
        \\      <SessionToken>tokenXXX</SessionToken>
        \\      <Expiration>2024-01-15T12:00:00Z</Expiration>
        \\    </Credentials>
        \\  </AssumeRoleWithWebIdentityResult>
        \\</AssumeRoleWithWebIdentityResponse>
    ;

    const creds = try parseStsCredentials(allocator, body);
    defer {
        allocator.free(creds.access_key_id);
        allocator.free(creds.secret_access_key);
        if (creds.session_token) |t| allocator.free(t);
    }

    try std.testing.expectEqualStrings("ASIAXXX", creds.access_key_id);
    try std.testing.expectEqualStrings("secretXXX", creds.secret_access_key);
    try std.testing.expectEqualStrings("tokenXXX", creds.session_token.?);
    try std.testing.expect(creds.expiration.? > 1705300000);
}

test "parseStsCredentials with extra elements" {
    const allocator = std.testing.allocator;
    const body =
        \\<AssumeRoleResponse>
        \\  <AssumeRoleResult>
        \\    <AssumedRoleUser>
        \\      <Arn>arn:aws:sts::123:assumed-role/Test/session</Arn>
        \\      <AssumedRoleId>AROA:session</AssumedRoleId>
        \\    </AssumedRoleUser>
        \\    <Credentials>
        \\      <AccessKeyId>ASIAXXX</AccessKeyId>
        \\      <SecretAccessKey>secretXXX</SecretAccessKey>
        \\      <SessionToken>tokenXXX</SessionToken>
        \\      <Expiration>2024-01-15T12:00:00Z</Expiration>
        \\    </Credentials>
        \\  </AssumeRoleResult>
        \\</AssumeRoleResponse>
    ;

    const creds = try parseStsCredentials(allocator, body);
    defer {
        allocator.free(creds.access_key_id);
        allocator.free(creds.secret_access_key);
        if (creds.session_token) |t| allocator.free(t);
    }

    try std.testing.expectEqualStrings("ASIAXXX", creds.access_key_id);
}

test "parseStsCredentials missing fields" {
    const allocator = std.testing.allocator;
    const body =
        \\<Response>
        \\  <Error>
        \\    <Code>AccessDenied</Code>
        \\  </Error>
        \\</Response>
    ;

    try std.testing.expectError(error.StsResponseMissingField, parseStsCredentials(allocator, body));
}
