const std = @import("std");

const BitWriter = struct {
    buf: std.ArrayList(u8),
    allocator: std.mem.Allocator,
    bits: u32,
    nbits: u5,

    fn writeBits(self: *BitWriter, val: u32, n: u5) !void {
        self.bits |= val << self.nbits;
        self.nbits += n;
        while (self.nbits >= 8) {
            try self.buf.append(self.allocator, @truncate(self.bits));
            self.bits >>= 8;
            self.nbits -= 8;
        }
    }

    fn flush(self: *BitWriter) !void {
        if (self.nbits > 0) {
            try self.buf.append(self.allocator, @truncate(self.bits));
            self.bits = 0;
            self.nbits = 0;
        }
    }
};

const LengthInfo = struct {
    code: u16,
    extra_bits: u5,
    extra_value: u16,
};

fn reverseBits(val: u16, n: u5) u16 {
    var v: u16 = val;
    var out: u16 = 0;
    var i: u5 = 0;
    while (i < n) : (i += 1) {
        out = (out << 1) | (v & 1);
        v >>= 1;
    }
    return out;
}

fn getLengthInfo(len: usize) LengthInfo {
    if (len == 258) {
        return .{ .code = 285, .extra_bits = 0, .extra_value = 0 };
    }
    if (len >= 3 and len <= 10) {
        return .{
            .code = @as(u16, @intCast(257 + (len - 3))),
            .extra_bits = 0,
            .extra_value = 0,
        };
    }
    if (len <= 12) {
        return .{ .code = 265, .extra_bits = 1, .extra_value = @as(u16, @intCast(len - 11)) };
    }
    if (len <= 14) {
        return .{ .code = 266, .extra_bits = 1, .extra_value = @as(u16, @intCast(len - 13)) };
    }
    if (len <= 16) {
        return .{ .code = 267, .extra_bits = 1, .extra_value = @as(u16, @intCast(len - 15)) };
    }
    if (len <= 18) {
        return .{ .code = 268, .extra_bits = 1, .extra_value = @as(u16, @intCast(len - 17)) };
    }
    if (len <= 22) {
        return .{ .code = 269, .extra_bits = 2, .extra_value = @as(u16, @intCast(len - 19)) };
    }
    if (len <= 26) {
        return .{ .code = 270, .extra_bits = 2, .extra_value = @as(u16, @intCast(len - 23)) };
    }
    if (len <= 30) {
        return .{ .code = 271, .extra_bits = 2, .extra_value = @as(u16, @intCast(len - 27)) };
    }
    if (len <= 34) {
        return .{ .code = 272, .extra_bits = 2, .extra_value = @as(u16, @intCast(len - 31)) };
    }
    if (len <= 42) {
        return .{ .code = 273, .extra_bits = 3, .extra_value = @as(u16, @intCast(len - 35)) };
    }
    if (len <= 50) {
        return .{ .code = 274, .extra_bits = 3, .extra_value = @as(u16, @intCast(len - 43)) };
    }
    if (len <= 58) {
        return .{ .code = 275, .extra_bits = 3, .extra_value = @as(u16, @intCast(len - 51)) };
    }
    if (len <= 66) {
        return .{ .code = 276, .extra_bits = 3, .extra_value = @as(u16, @intCast(len - 59)) };
    }
    if (len <= 82) {
        return .{ .code = 277, .extra_bits = 4, .extra_value = @as(u16, @intCast(len - 67)) };
    }
    if (len <= 98) {
        return .{ .code = 278, .extra_bits = 4, .extra_value = @as(u16, @intCast(len - 83)) };
    }
    if (len <= 114) {
        return .{ .code = 279, .extra_bits = 4, .extra_value = @as(u16, @intCast(len - 99)) };
    }
    if (len <= 130) {
        return .{ .code = 280, .extra_bits = 4, .extra_value = @as(u16, @intCast(len - 115)) };
    }
    if (len <= 162) {
        return .{ .code = 281, .extra_bits = 5, .extra_value = @as(u16, @intCast(len - 131)) };
    }
    if (len <= 194) {
        return .{ .code = 282, .extra_bits = 5, .extra_value = @as(u16, @intCast(len - 163)) };
    }
    if (len <= 226) {
        return .{ .code = 283, .extra_bits = 5, .extra_value = @as(u16, @intCast(len - 195)) };
    }
    return .{ .code = 284, .extra_bits = 5, .extra_value = @as(u16, @intCast(len - 227)) };
}

fn writeFixedLiteral(bw: *BitWriter, literal: u8) !void {
    if (literal <= 143) {
        const code: u16 = 0x30 + literal;
        const rev = reverseBits(code, 8);
        try bw.writeBits(rev, 8);
        return;
    }
    const code: u16 = 0x190 + @as(u16, literal) - 144;
    const rev = reverseBits(code, 9);
    try bw.writeBits(rev, 9);
}

fn writeFixedLength(bw: *BitWriter, code: u16) !void {
    if (code <= 279) {
        const raw: u16 = code - 256;
        const rev = reverseBits(raw, 7);
        try bw.writeBits(rev, 7);
        return;
    }
    const raw: u16 = 0xC0 + (code - 280);
    const rev = reverseBits(raw, 8);
    try bw.writeBits(rev, 8);
}

fn writeFixedDistance(bw: *BitWriter, code: u16) !void {
    const rev = reverseBits(code, 5);
    try bw.writeBits(rev, 5);
}

fn writeLengthDistance(bw: *BitWriter, len: usize) !void {
    const info = getLengthInfo(len);
    try writeFixedLength(bw, info.code);
    if (info.extra_bits > 0) {
        try bw.writeBits(info.extra_value, info.extra_bits);
    }
    try writeFixedDistance(bw, 0);
}

pub fn compress(allocator: std.mem.Allocator, input: []const u8) ![]u8 {
    var out: std.ArrayList(u8) = .{};
    errdefer out.deinit(allocator);

    const header = [_]u8{ 0x1f, 0x8b, 0x08, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x03 };
    try out.appendSlice(allocator, &header);

    var bw = BitWriter{
        .buf = out,
        .allocator = allocator,
        .bits = 0,
        .nbits = 0,
    };

    try bw.writeBits(1, 1);
    try bw.writeBits(1, 1);
    try bw.writeBits(0, 1);

    var pos: usize = 0;
    while (pos < input.len) {
        if (pos > 0 and input[pos] == input[pos - 1]) {
            var run: usize = 1;
            while (pos + run < input.len and run < 258) {
                if (input[pos + run] != input[pos - 1]) {
                    break;
                }
                run += 1;
            }
            if (run >= 3) {
                try writeLengthDistance(&bw, run);
                pos += run;
                continue;
            }
        }
        try writeFixedLiteral(&bw, input[pos]);
        pos += 1;
    }

    try bw.writeBits(0, 7);
    try bw.flush();

    const crc = std.hash.crc.Crc32IsoHdlc.hash(input);
    const size = @as(u32, @intCast(input.len));
    var footer: [8]u8 = undefined;
    std.mem.writeInt(u32, footer[0..4], crc, .little);
    std.mem.writeInt(u32, footer[4..8], size, .little);
    try bw.buf.appendSlice(allocator, &footer);

    return bw.buf.toOwnedSlice(allocator);
}

test "gzip compress empty input" {
    const allocator = std.testing.allocator;
    const output = try compress(allocator, "");
    defer allocator.free(output);
    try std.testing.expectEqual(@as(u8, 0x1f), output[0]);
    try std.testing.expectEqual(@as(u8, 0x8b), output[1]);
}

test "gzip compress repetitive data" {
    var input: [2000]u8 = undefined;
    @memset(&input, 'a');
    const allocator = std.testing.allocator;
    const output = try compress(allocator, &input);
    defer allocator.free(output);
    try std.testing.expect(output.len < input.len);
}
