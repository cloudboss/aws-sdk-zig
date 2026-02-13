const std = @import("std");

/// Generic map entry for AWS SDK map types.
/// Maps are represented as slices of key-value pairs: `[]const MapEntry(V)`.
/// This avoids hash map complexity and works naturally with arena allocation.
pub fn MapEntry(comptime V: type) type {
    return struct {
        key: []const u8,
        value: V,

        /// Marker for comptime detection in json/xml serde.
        pub const is_map_entry = true;
        pub const ValueType = V;
    };
}

/// Convenience alias for the common case of string-to-string maps.
pub const StringMapEntry = MapEntry([]const u8);

test "MapEntry basic usage" {
    const entries = [_]StringMapEntry{
        .{ .key = "Name", .value = "Alice" },
        .{ .key = "Age", .value = "30" },
    };

    try std.testing.expectEqual(@as(usize, 2), entries.len);
    try std.testing.expectEqualStrings("Name", entries[0].key);
    try std.testing.expectEqualStrings("Alice", entries[0].value);
}

test "MapEntry with struct value" {
    const Inner = struct {
        x: i32,
    };
    const Entry = MapEntry(Inner);

    const entries = [_]Entry{
        .{ .key = "first", .value = .{ .x = 1 } },
        .{ .key = "second", .value = .{ .x = 2 } },
    };

    try std.testing.expectEqual(@as(i32, 1), entries[0].value.x);
    try std.testing.expectEqual(@as(i32, 2), entries[1].value.x);
}

test "MapEntry comptime detection" {
    try std.testing.expect(@hasDecl(StringMapEntry, "is_map_entry"));
    try std.testing.expect(StringMapEntry.is_map_entry);
    try std.testing.expect(StringMapEntry.ValueType == []const u8);
}
