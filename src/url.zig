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

/// Extract the host from an endpoint URL, stripping scheme, port, and path.
pub fn parseHost(endpoint: []const u8) []const u8 {
    // Strip scheme
    const after_scheme = if (std.mem.indexOf(u8, endpoint, "://")) |idx| endpoint[idx + 3 ..] else endpoint;
    // Strip port and path
    const end = std.mem.indexOfAny(u8, after_scheme, ":/") orelse after_scheme.len;
    return after_scheme[0..end];
}

/// Extract the port from an endpoint URL, or null if none is specified.
pub fn parsePort(endpoint: []const u8) ?u16 {
    const after_scheme = if (std.mem.indexOf(u8, endpoint, "://")) |idx| endpoint[idx + 3 ..] else endpoint;
    const colon = std.mem.indexOfScalar(u8, after_scheme, ':') orelse return null;
    const port_end = std.mem.indexOfScalarPos(u8, after_scheme, colon + 1, '/') orelse after_scheme.len;
    return std.fmt.parseInt(u16, after_scheme[colon + 1 .. port_end], 10) catch null;
}

// ---- Tests ----

test "appendUrlEncoded passes through unreserved characters" {
    const alloc = std.testing.allocator;
    var buf: std.ArrayList(u8) = .{};
    defer buf.deinit(alloc);

    try appendUrlEncoded(alloc, &buf, "hello-world_test.value~ok");
    try std.testing.expectEqualStrings("hello-world_test.value~ok", buf.items);
}

test "appendUrlEncoded encodes spaces as +" {
    const alloc = std.testing.allocator;
    var buf: std.ArrayList(u8) = .{};
    defer buf.deinit(alloc);

    try appendUrlEncoded(alloc, &buf, "hello world");
    try std.testing.expectEqualStrings("hello+world", buf.items);
}

test "appendUrlEncoded percent-encodes special characters" {
    const alloc = std.testing.allocator;
    var buf: std.ArrayList(u8) = .{};
    defer buf.deinit(alloc);

    try appendUrlEncoded(alloc, &buf, "a=b&c");
    try std.testing.expectEqualStrings("a%3Db%26c", buf.items);
}

test "parseHost with scheme and port" {
    try std.testing.expectEqualStrings("localhost", parseHost("http://localhost:4566"));
}

test "parseHost with scheme and path" {
    try std.testing.expectEqualStrings("example.com", parseHost("https://example.com/path"));
}

test "parseHost without scheme" {
    try std.testing.expectEqualStrings("myhost", parseHost("myhost:8080"));
}

test "parseHost plain hostname" {
    try std.testing.expectEqualStrings("example.com", parseHost("example.com"));
}

test "parsePort with scheme and port" {
    try std.testing.expectEqual(@as(u16, 4566), parsePort("http://localhost:4566").?);
}

test "parsePort no port" {
    try std.testing.expect(parsePort("https://example.com") == null);
}

test "parsePort with trailing path" {
    try std.testing.expectEqual(@as(u16, 8080), parsePort("http://host:8080/path").?);
}
