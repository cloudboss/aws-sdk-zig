const std = @import("std");
const aws = @import("aws");

test "event stream encodes and decodes a message with all header types" {
    var arena = std.heap.ArenaAllocator.init(std.testing.allocator);
    defer arena.deinit();

    var uuid: [16]u8 = undefined;
    for (&uuid, 0..) |*value, index| {
        value.* = @intCast(index);
    }

    const headers = [_]aws.event_stream.Header{
        .{ .name = "bool_header", .value = .{ .bool_true = {} } },
        .{ .name = "byte_header", .value = .{ .byte = 42 } },
        .{ .name = "short_header", .value = .{ .short = 1000 } },
        .{ .name = "int_header", .value = .{ .int = 100000 } },
        .{ .name = "long_header", .value = .{ .long = 9999999999 } },
        .{
            .name = "bytes_header",
            .value = .{ .bytes = &.{ 0xDE, 0xAD, 0xBE, 0xEF } },
        },
        .{ .name = "string_header", .value = .{ .string = "hello-world" } },
        .{ .name = "timestamp_header", .value = .{ .timestamp = 1234567890123 } },
        .{ .name = "uuid_header", .value = .{ .uuid = uuid } },
    };

    const msg = aws.event_stream.Message{
        .headers = &headers,
        .payload = "integration test payload",
    };

    const encoded = try aws.event_stream.encodeMessage(arena.allocator(), msg);
    var decoded = try aws.event_stream.decodeMessage(arena.allocator(), encoded);
    defer aws.event_stream.deinitMessage(arena.allocator(), &decoded);

    try expectHeadersEqual(&headers, decoded.headers);
    try std.testing.expectEqualStrings(msg.payload, decoded.payload);
}

test "event stream AWS spec test vector: known message" {
    var arena = std.heap.ArenaAllocator.init(std.testing.allocator);
    defer arena.deinit();

    const headers = [_]aws.event_stream.Header{
        .{ .name = ":message-type", .value = .{ .string = "event" } },
        .{ .name = ":event-type", .value = .{ .string = "Records" } },
    };

    const msg = aws.event_stream.Message{
        .headers = &headers,
        .payload = "arbitrary payload",
    };

    const encoded = try aws.event_stream.encodeMessage(arena.allocator(), msg);
    defer arena.allocator().free(encoded);

    try std.testing.expect(encoded.len >= 16);
    const total_len = std.mem.readInt(u32, encoded[0..4], .big);
    const header_len = std.mem.readInt(u32, encoded[4..8], .big);
    try std.testing.expectEqual(@as(u32, @intCast(encoded.len)), total_len);
    const payload_len: u32 = @intCast(msg.payload.len);
    const expected_header_len = total_len - 16 - payload_len;
    try std.testing.expectEqual(expected_header_len, header_len);

    var decoded = try aws.event_stream.decodeMessage(arena.allocator(), encoded);
    defer aws.event_stream.deinitMessage(arena.allocator(), &decoded);
    try expectHeadersEqual(&headers, decoded.headers);
    try std.testing.expectEqualStrings("arbitrary payload", decoded.payload);
}

test "event stream rejects corrupt prelude CRC" {
    var arena = std.heap.ArenaAllocator.init(std.testing.allocator);
    defer arena.deinit();

    const msg = aws.event_stream.Message{ .headers = &.{}, .payload = "crc" };
    const encoded = try aws.event_stream.encodeMessage(arena.allocator(), msg);
    defer arena.allocator().free(encoded);

    const corrupted = try arena.allocator().dupe(u8, encoded);
    const mutable = @constCast(corrupted);
    mutable[8] ^= 0xFF;

    try std.testing.expectError(
        error.InvalidPreludeCrc,
        aws.event_stream.decodeMessage(arena.allocator(), corrupted),
    );
}

test "event stream rejects corrupt message CRC" {
    var arena = std.heap.ArenaAllocator.init(std.testing.allocator);
    defer arena.deinit();

    const msg = aws.event_stream.Message{ .headers = &.{}, .payload = "crc" };
    const encoded = try aws.event_stream.encodeMessage(arena.allocator(), msg);
    defer arena.allocator().free(encoded);

    const corrupted = try arena.allocator().dupe(u8, encoded);
    const mutable = @constCast(corrupted);
    mutable[mutable.len - 1] ^= 0xFF;

    try std.testing.expectError(
        error.InvalidMessageCrc,
        aws.event_stream.decodeMessage(arena.allocator(), corrupted),
    );
}

test "event stream encodes empty payload correctly" {
    var arena = std.heap.ArenaAllocator.init(std.testing.allocator);
    defer arena.deinit();

    const headers = [_]aws.event_stream.Header{
        .{ .name = "content-type", .value = .{ .string = "application/json" } },
    };

    const msg = aws.event_stream.Message{ .headers = &headers, .payload = "" };
    const encoded = try aws.event_stream.encodeMessage(arena.allocator(), msg);
    var decoded = try aws.event_stream.decodeMessage(arena.allocator(), encoded);
    defer aws.event_stream.deinitMessage(arena.allocator(), &decoded);

    try expectHeadersEqual(&headers, decoded.headers);
    try std.testing.expectEqual(@as(usize, 0), decoded.payload.len);
}

test "event stream handles large payload" {
    var arena = std.heap.ArenaAllocator.init(std.testing.allocator);
    defer arena.deinit();

    const payload = try arena.allocator().alloc(u8, 10 * 1024);
    @memset(payload, 'z');

    const headers = [_]aws.event_stream.Header{
        .{ .name = "content-length", .value = .{ .int = 10 * 1024 } },
    };

    const msg = aws.event_stream.Message{ .headers = &headers, .payload = payload };
    const encoded = try aws.event_stream.encodeMessage(arena.allocator(), msg);
    var decoded = try aws.event_stream.decodeMessage(arena.allocator(), encoded);
    defer aws.event_stream.deinitMessage(arena.allocator(), &decoded);

    try expectHeadersEqual(&headers, decoded.headers);
    try std.testing.expectEqualSlices(u8, payload, decoded.payload);
}

fn expectHeadersEqual(
    expected: []const aws.event_stream.Header,
    actual: []const aws.event_stream.Header,
) !void {
    try std.testing.expectEqual(expected.len, actual.len);
    for (expected, 0..) |header, index| {
        const current = actual[index];
        try std.testing.expectEqualStrings(header.name, current.name);
        try std.testing.expect(
            @intFromEnum(header.value) == @intFromEnum(current.value),
        );
        switch (header.value) {
            .bool_true, .bool_false => {},
            .byte => |value| try std.testing.expectEqual(value, current.value.byte),
            .short => |value| try std.testing.expectEqual(value, current.value.short),
            .int => |value| try std.testing.expectEqual(value, current.value.int),
            .long => |value| try std.testing.expectEqual(value, current.value.long),
            .timestamp => |value| try std.testing.expectEqual(value, current.value.timestamp),
            .uuid => |value| try std.testing.expectEqual(value, current.value.uuid),
            .bytes => |value| try std.testing.expectEqualSlices(
                u8,
                value,
                current.value.bytes,
            ),
            .string => |value| try std.testing.expectEqualStrings(
                value,
                current.value.string,
            ),
        }
    }
}
