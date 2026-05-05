const std = @import("std");
const flate = std.compress.flate;

/// Compress `input` as a gzip stream at the default deflate level.
/// Caller owns the returned slice.
pub fn compress(allocator: std.mem.Allocator, input: []const u8) ![]u8 {
    var allocating: std.Io.Writer.Allocating = try .initCapacity(allocator, 4096);
    errdefer allocating.deinit();

    const window = try allocator.alloc(u8, flate.max_window_len);
    defer allocator.free(window);

    var c: flate.Compress = try .init(&allocating.writer, window, .gzip, .default);
    try c.writer.writeAll(input);
    try c.finish();

    return allocating.toOwnedSlice();
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
