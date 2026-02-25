//! AWS event stream binary message codec.

const std = @import("std");

const checksum = @import("checksum.zig");

const Allocator = std.mem.Allocator;

pub const HeaderValueType = enum(u8) {
    bool_true = 0,
    bool_false = 1,
    byte = 2,
    short = 3,
    int = 4,
    long = 5,
    bytes = 6,
    string = 7,
    timestamp = 8,
    uuid = 9,
};

pub const HeaderValue = union(HeaderValueType) {
    bool_true: void,
    bool_false: void,
    byte: u8,
    short: i16,
    int: i32,
    long: i64,
    bytes: []const u8,
    string: []const u8,
    timestamp: i64,
    uuid: [16]u8,
};

pub const Header = struct {
    name: []const u8,
    value: HeaderValue,
};

pub const Message = struct {
    headers: []const Header,
    payload: []const u8,
};

pub const DecodeError = error{
    InvalidPreludeCrc,
    InvalidMessageCrc,
    TruncatedData,
    InvalidHeaderType,
    HeaderNameTooLong,
    OutOfMemory,
};

pub fn encodeMessage(allocator: Allocator, msg: Message) ![]const u8 {
    var headers_length: usize = 0;
    for (msg.headers) |header| {
        headers_length += try headerEncodedLength(header);
    }

    const total_length_usize = 12 + headers_length + msg.payload.len + 4;
    if (total_length_usize > std.math.maxInt(u32)) {
        return error.ValueTooLong;
    }
    if (headers_length > std.math.maxInt(u32)) {
        return error.ValueTooLong;
    }

    const total_length: u32 = @intCast(total_length_usize);
    const headers_length_u32: u32 = @intCast(headers_length);

    const buffer = try allocator.alloc(u8, total_length_usize);
    errdefer allocator.free(buffer);

    writeU32(buffer[0..4], total_length);
    writeU32(buffer[4..8], headers_length_u32);
    const prelude_crc = checksum.computeCrc32(buffer[0..8]);
    writeU32(buffer[8..12], prelude_crc);

    var offset: usize = 12;
    for (msg.headers) |header| {
        offset = try writeHeader(buffer, offset, header);
    }

    std.mem.copyForwards(u8, buffer[offset .. offset + msg.payload.len], msg.payload);
    offset += msg.payload.len;

    const message_crc = checksum.computeCrc32(buffer[0 .. total_length_usize - 4]);
    writeU32(buffer[offset .. offset + 4], message_crc);

    return buffer;
}

pub fn decodeMessage(allocator: Allocator, data: []const u8) DecodeError!Message {
    if (data.len < 16) {
        return error.TruncatedData;
    }

    const total_length = readU32(data[0..4]);
    const headers_length = readU32(data[4..8]);
    const prelude_crc = readU32(data[8..12]);

    if (total_length < 16) {
        return error.TruncatedData;
    }

    const total_len: usize = @intCast(total_length);
    const headers_len: usize = @intCast(headers_length);
    if (data.len < total_len) {
        return error.TruncatedData;
    }

    if (headers_len > total_len - 16) {
        return error.TruncatedData;
    }

    const computed_prelude_crc = checksum.computeCrc32(data[0..8]);
    if (computed_prelude_crc != prelude_crc) {
        return error.InvalidPreludeCrc;
    }

    const expected_message_crc = readU32(data[total_len - 4 .. total_len]);
    const computed_message_crc = checksum.computeCrc32(data[0 .. total_len - 4]);
    if (computed_message_crc != expected_message_crc) {
        return error.InvalidMessageCrc;
    }

    const headers_bytes = data[12 .. 12 + headers_len];
    const payload_len = total_len - 16 - headers_len;
    const payload_bytes = data[12 + headers_len .. 12 + headers_len + payload_len];

    var headers_list: std.ArrayList(Header) = .{};
    errdefer deinitHeaderList(allocator, &headers_list);

    var index: usize = 0;
    while (index < headers_bytes.len) {
        if (headers_bytes.len - index < 2) {
            return error.TruncatedData;
        }

        const name_len: usize = headers_bytes[index];
        index += 1;

        if (headers_bytes.len - index < name_len + 1) {
            return error.TruncatedData;
        }

        const name_slice = headers_bytes[index .. index + name_len];
        index += name_len;

        const type_code = headers_bytes[index];
        index += 1;

        const name_copy = try allocator.dupe(u8, name_slice);
        const header_value = try parseHeaderValue(
            allocator,
            type_code,
            headers_bytes,
            &index,
        );

        headers_list.append(allocator, .{
            .name = name_copy,
            .value = header_value,
        }) catch |err| {
            deinitHeaderValue(allocator, header_value);
            allocator.free(name_copy);
            return err;
        };
    }

    const headers = try headers_list.toOwnedSlice(allocator);
    errdefer {
        deinitHeaders(allocator, headers);
        allocator.free(headers);
    }

    const payload_copy = try allocator.dupe(u8, payload_bytes);
    errdefer allocator.free(payload_copy);

    return .{ .headers = headers, .payload = payload_copy };
}

pub fn deinitMessage(allocator: Allocator, msg: *Message) void {
    deinitHeaders(allocator, msg.headers);
    allocator.free(msg.headers);
    allocator.free(msg.payload);
    msg.* = .{ .headers = &.{}, .payload = &.{} };
}

fn deinitHeaders(allocator: Allocator, headers: []const Header) void {
    for (headers) |header| {
        allocator.free(header.name);
        deinitHeaderValue(allocator, header.value);
    }
}

fn deinitHeaderList(allocator: Allocator, list: *std.ArrayList(Header)) void {
    deinitHeaders(allocator, list.items);
    list.deinit(allocator);
}

fn deinitHeaderValue(allocator: Allocator, value: HeaderValue) void {
    switch (value) {
        .bytes => |bytes| allocator.free(bytes),
        .string => |string| allocator.free(string),
        else => {},
    }
}

fn headerEncodedLength(header: Header) !usize {
    if (header.name.len > std.math.maxInt(u8)) {
        return error.HeaderNameTooLong;
    }

    var length: usize = 1 + header.name.len + 1;
    switch (header.value) {
        .bool_true, .bool_false => {},
        .byte => length += 1,
        .short => length += 2,
        .int => length += 4,
        .long => length += 8,
        .timestamp => length += 8,
        .uuid => length += 16,
        .bytes => |bytes| {
            if (bytes.len > std.math.maxInt(u16)) {
                return error.ValueTooLong;
            }
            length += 2 + bytes.len;
        },
        .string => |string| {
            if (string.len > std.math.maxInt(u16)) {
                return error.ValueTooLong;
            }
            length += 2 + string.len;
        },
    }
    return length;
}

fn writeHeader(buffer: []u8, offset: usize, header: Header) !usize {
    if (header.name.len > std.math.maxInt(u8)) {
        return error.HeaderNameTooLong;
    }

    var cursor = offset;
    buffer[cursor] = @intCast(header.name.len);
    cursor += 1;

    std.mem.copyForwards(u8, buffer[cursor .. cursor + header.name.len], header.name);
    cursor += header.name.len;

    buffer[cursor] = @intFromEnum(header.value);
    cursor += 1;

    switch (header.value) {
        .bool_true, .bool_false => {},
        .byte => |value| {
            buffer[cursor] = value;
            cursor += 1;
        },
        .short => |value| {
            writeI16(buffer[cursor .. cursor + 2], value);
            cursor += 2;
        },
        .int => |value| {
            writeI32(buffer[cursor .. cursor + 4], value);
            cursor += 4;
        },
        .long => |value| {
            writeI64(buffer[cursor .. cursor + 8], value);
            cursor += 8;
        },
        .timestamp => |value| {
            writeI64(buffer[cursor .. cursor + 8], value);
            cursor += 8;
        },
        .uuid => |value| {
            std.mem.copyForwards(u8, buffer[cursor .. cursor + 16], &value);
            cursor += 16;
        },
        .bytes => |bytes| {
            if (bytes.len > std.math.maxInt(u16)) {
                return error.ValueTooLong;
            }
            writeU16(buffer[cursor .. cursor + 2], @intCast(bytes.len));
            cursor += 2;
            std.mem.copyForwards(u8, buffer[cursor .. cursor + bytes.len], bytes);
            cursor += bytes.len;
        },
        .string => |string| {
            if (string.len > std.math.maxInt(u16)) {
                return error.ValueTooLong;
            }
            writeU16(buffer[cursor .. cursor + 2], @intCast(string.len));
            cursor += 2;
            std.mem.copyForwards(u8, buffer[cursor .. cursor + string.len], string);
            cursor += string.len;
        },
    }

    return cursor;
}

fn parseHeaderValue(
    allocator: Allocator,
    type_code: u8,
    data: []const u8,
    index: *usize,
) DecodeError!HeaderValue {
    switch (type_code) {
        0 => return .{ .bool_true = {} },
        1 => return .{ .bool_false = {} },
        2 => {
            if (data.len - index.* < 1) {
                return error.TruncatedData;
            }
            const value = data[index.*];
            index.* += 1;
            return .{ .byte = value };
        },
        3 => {
            if (data.len - index.* < 2) {
                return error.TruncatedData;
            }
            const value = readI16(data[index.* .. index.* + 2]);
            index.* += 2;
            return .{ .short = value };
        },
        4 => {
            if (data.len - index.* < 4) {
                return error.TruncatedData;
            }
            const value = readI32(data[index.* .. index.* + 4]);
            index.* += 4;
            return .{ .int = value };
        },
        5 => {
            if (data.len - index.* < 8) {
                return error.TruncatedData;
            }
            const value = readI64(data[index.* .. index.* + 8]);
            index.* += 8;
            return .{ .long = value };
        },
        6 => {
            const bytes = try parseLengthPrefixed(allocator, data, index);
            return .{ .bytes = bytes };
        },
        7 => {
            const string = try parseLengthPrefixed(allocator, data, index);
            return .{ .string = string };
        },
        8 => {
            if (data.len - index.* < 8) {
                return error.TruncatedData;
            }
            const value = readI64(data[index.* .. index.* + 8]);
            index.* += 8;
            return .{ .timestamp = value };
        },
        9 => {
            if (data.len - index.* < 16) {
                return error.TruncatedData;
            }
            var value: [16]u8 = undefined;
            std.mem.copyForwards(u8, &value, data[index.* .. index.* + 16]);
            index.* += 16;
            return .{ .uuid = value };
        },
        else => return error.InvalidHeaderType,
    }
}

fn parseLengthPrefixed(
    allocator: Allocator,
    data: []const u8,
    index: *usize,
) DecodeError![]const u8 {
    if (data.len - index.* < 2) {
        return error.TruncatedData;
    }

    const length = readU16(data[index.* .. index.* + 2]);
    index.* += 2;

    const length_usize: usize = @intCast(length);
    if (data.len - index.* < length_usize) {
        return error.TruncatedData;
    }

    const slice = data[index.* .. index.* + length_usize];
    index.* += length_usize;

    return allocator.dupe(u8, slice) catch error.OutOfMemory;
}

fn readU16(data: []const u8) u16 {
    return std.mem.readInt(u16, data[0..2], .big);
}

fn readU32(data: []const u8) u32 {
    return std.mem.readInt(u32, data[0..4], .big);
}

fn readI16(data: []const u8) i16 {
    return std.mem.readInt(i16, data[0..2], .big);
}

fn readI32(data: []const u8) i32 {
    return std.mem.readInt(i32, data[0..4], .big);
}

fn readI64(data: []const u8) i64 {
    return std.mem.readInt(i64, data[0..8], .big);
}

fn writeU16(data: []u8, value: u16) void {
    std.mem.writeInt(u16, data[0..2], value, .big);
}

fn writeU32(data: []u8, value: u32) void {
    std.mem.writeInt(u32, data[0..4], value, .big);
}

fn writeI16(data: []u8, value: i16) void {
    std.mem.writeInt(i16, data[0..2], value, .big);
}

fn writeI32(data: []u8, value: i32) void {
    std.mem.writeInt(i32, data[0..4], value, .big);
}

fn writeI64(data: []u8, value: i64) void {
    std.mem.writeInt(i64, data[0..8], value, .big);
}

const testing = std.testing;

fn expectHeaderEqual(expected: Header, actual: Header) !void {
    try testing.expectEqualStrings(expected.name, actual.name);
    try testing.expect(@intFromEnum(expected.value) == @intFromEnum(actual.value));
    switch (expected.value) {
        .bool_true, .bool_false => {},
        .byte => |value| try testing.expectEqual(value, actual.value.byte),
        .short => |value| try testing.expectEqual(value, actual.value.short),
        .int => |value| try testing.expectEqual(value, actual.value.int),
        .long => |value| try testing.expectEqual(value, actual.value.long),
        .timestamp => |value| try testing.expectEqual(value, actual.value.timestamp),
        .uuid => |value| try testing.expectEqual(value, actual.value.uuid),
        .bytes => |value| try testing.expectEqualSlices(u8, value, actual.value.bytes),
        .string => |value| try testing.expectEqualStrings(value, actual.value.string),
    }
}

test "event stream round trip" {
    const headers = [_]Header{
        .{ .name = "bool-true", .value = .{ .bool_true = {} } },
        .{ .name = "bool-false", .value = .{ .bool_false = {} } },
        .{ .name = "byte", .value = .{ .byte = 0x7f } },
        .{ .name = "short", .value = .{ .short = -1234 } },
        .{ .name = "int", .value = .{ .int = 123456 } },
        .{ .name = "long", .value = .{ .long = 9876543210 } },
        .{ .name = "bytes", .value = .{ .bytes = "blob" } },
        .{ .name = "string", .value = .{ .string = "hello" } },
        .{ .name = "timestamp", .value = .{ .timestamp = 1730000000000 } },
        .{
            .name = "uuid",
            .value = .{ .uuid = .{ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15 } },
        },
    };

    const msg = Message{ .headers = &headers, .payload = "payload" };
    const encoded = try encodeMessage(testing.allocator, msg);
    defer testing.allocator.free(encoded);

    var decoded = try decodeMessage(testing.allocator, encoded);
    defer deinitMessage(testing.allocator, &decoded);

    try testing.expectEqual(@as(usize, headers.len), decoded.headers.len);
    for (headers, 0..) |header, i| {
        try expectHeaderEqual(header, decoded.headers[i]);
    }
    try testing.expectEqualSlices(u8, msg.payload, decoded.payload);
}

test "event stream invalid message crc" {
    const msg = Message{ .headers = &.{}, .payload = "data" };
    const encoded = try encodeMessage(testing.allocator, msg);
    defer testing.allocator.free(encoded);

    const corrupted = try testing.allocator.dupe(u8, encoded);
    defer testing.allocator.free(corrupted);

    const mutable = @constCast(corrupted);
    mutable[mutable.len - 5] ^= 0xFF;

    try testing.expectError(
        error.InvalidMessageCrc,
        decodeMessage(testing.allocator, corrupted),
    );
}

test "event stream empty message" {
    const msg = Message{ .headers = &.{}, .payload = "" };
    const encoded = try encodeMessage(testing.allocator, msg);
    defer testing.allocator.free(encoded);

    var decoded = try decodeMessage(testing.allocator, encoded);
    defer deinitMessage(testing.allocator, &decoded);

    try testing.expectEqual(@as(usize, 0), decoded.headers.len);
    try testing.expectEqualSlices(u8, "", decoded.payload);
}
