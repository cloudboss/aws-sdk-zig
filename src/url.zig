const std = @import("std");

/// URL-encode a value into a buffer using application/x-www-form-urlencoded encoding.
/// RFC 3986 unreserved characters (A-Z, a-z, 0-9, -, _, ., ~) pass through;
/// spaces become '+'; everything else is percent-encoded.
pub fn appendUrlEncoded(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const u8) !void {
    for (value) |c| {
        switch (c) {
            'A'...'Z', 'a'...'z', '0'...'9', '-', '_', '.', '~' => try buf.append(alloc, c),
            ' ' => try buf.append(alloc, '+'),
            else => {
                const hex = "0123456789ABCDEF";
                try buf.append(alloc, '%');
                try buf.append(alloc, hex[c >> 4]);
                try buf.append(alloc, hex[c & 0x0F]);
            },
        }
    }
}

/// Host, port, and TLS flag pulled out of an endpoint URL by parseEndpoint.
pub const EndpointInfo = struct {
    host: []const u8,
    port: ?u16,
    tls: bool,
};

/// Parse an endpoint URL into its host, port, and scheme via std.Uri so that
/// IPv6 literals (e.g. http://[fd00:ec2::254]/...) and userinfo
/// (https://user:pass@host) are handled correctly. AWS endpoint resolution
/// can yield scheme-less hostnames (e.g. iam.amazonaws.com) -- those are
/// treated as https. The returned host slice borrows from the input.
pub fn parseEndpoint(endpoint: []const u8) !EndpointInfo {
    // AWS endpoint resolution can yield a bare hostname (no scheme),
    // which std.Uri.parse rejects. Default such inputs to https and split
    // host/port directly without going through std.Uri.
    if (std.mem.find(u8, endpoint, "://") == null) {
        return parseHostPort(endpoint, true);
    }
    const uri = std.Uri.parse(endpoint) catch return error.InvalidEndpoint;
    const host_component = uri.host orelse return error.InvalidEndpoint;
    const host = switch (host_component) {
        .raw => |r| r,
        .percent_encoded => |p| p,
    };
    return .{
        .host = host,
        .port = uri.port,
        .tls = std.mem.eql(u8, uri.scheme, "https"),
    };
}

/// Parse a "host" or "host:port" string with no scheme. IPv6 literals must
/// be bracketed ("[fd00::1]:443"); a bare colon in an IPv6 address is
/// ambiguous without brackets and is rejected.
fn parseHostPort(input: []const u8, tls: bool) !EndpointInfo {
    if (input.len == 0) return error.InvalidEndpoint;
    if (input[0] == '[') {
        const end = std.mem.findScalar(u8, input, ']') orelse return error.InvalidEndpoint;
        const host = input[0 .. end + 1];
        if (end + 1 == input.len) return .{ .host = host, .port = null, .tls = tls };
        if (input[end + 1] != ':') return error.InvalidEndpoint;
        const port = std.fmt.parseInt(u16, input[end + 2 ..], 10) catch return error.InvalidEndpoint;
        return .{ .host = host, .port = port, .tls = tls };
    }
    if (std.mem.findScalar(u8, input, ':')) |colon| {
        if (std.mem.findScalarPos(u8, input, colon + 1, ':') != null) return error.InvalidEndpoint;
        const port = std.fmt.parseInt(u16, input[colon + 1 ..], 10) catch return error.InvalidEndpoint;
        return .{ .host = input[0..colon], .port = port, .tls = tls };
    }
    return .{ .host = input, .port = null, .tls = tls };
}

// ---- Tests ----

test "appendUrlEncoded passes through unreserved characters" {
    const alloc = std.testing.allocator;
    var buf: std.ArrayList(u8) = .empty;
    defer buf.deinit(alloc);

    try appendUrlEncoded(alloc, &buf, "hello-world_test.value~ok");
    try std.testing.expectEqualStrings("hello-world_test.value~ok", buf.items);
}

test "appendUrlEncoded encodes spaces as +" {
    const alloc = std.testing.allocator;
    var buf: std.ArrayList(u8) = .empty;
    defer buf.deinit(alloc);

    try appendUrlEncoded(alloc, &buf, "hello world");
    try std.testing.expectEqualStrings("hello+world", buf.items);
}

test "appendUrlEncoded percent-encodes special characters" {
    const alloc = std.testing.allocator;
    var buf: std.ArrayList(u8) = .empty;
    defer buf.deinit(alloc);

    try appendUrlEncoded(alloc, &buf, "a=b&c");
    try std.testing.expectEqualStrings("a%3Db%26c", buf.items);
}

test "parseEndpoint with scheme and port" {
    const ep = try parseEndpoint("http://localhost:4566");
    try std.testing.expectEqualStrings("localhost", ep.host);
    try std.testing.expectEqual(@as(?u16, 4566), ep.port);
    try std.testing.expectEqual(false, ep.tls);
}

test "parseEndpoint with https and path" {
    const ep = try parseEndpoint("https://example.com/path");
    try std.testing.expectEqualStrings("example.com", ep.host);
    try std.testing.expectEqual(@as(?u16, null), ep.port);
    try std.testing.expectEqual(true, ep.tls);
}

test "parseEndpoint with bracketed IPv6 host" {
    const ep = try parseEndpoint("http://[fd00:ec2::254]/latest/meta-data/");
    try std.testing.expectEqualStrings("[fd00:ec2::254]", ep.host);
    try std.testing.expectEqual(@as(?u16, null), ep.port);
    try std.testing.expectEqual(false, ep.tls);
}

test "parseEndpoint with userinfo" {
    const ep = try parseEndpoint("https://user:pass@example.com:8443/path");
    try std.testing.expectEqualStrings("example.com", ep.host);
    try std.testing.expectEqual(@as(?u16, 8443), ep.port);
    try std.testing.expectEqual(true, ep.tls);
}

test "parseEndpoint accepts scheme-less hostname as https" {
    const ep = try parseEndpoint("sts.us-east-1.amazonaws.com");
    try std.testing.expectEqualStrings("sts.us-east-1.amazonaws.com", ep.host);
    try std.testing.expectEqual(@as(?u16, null), ep.port);
    try std.testing.expectEqual(true, ep.tls);
}
