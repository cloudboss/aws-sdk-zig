const std = @import("std");
const aws = @import("aws");
const sts = @import("sts");

test "getCallerIdentity returns valid identity" {
    const allocator = std.testing.allocator;

    var cfg = try aws.Config.load(allocator, .{});
    defer cfg.deinit();

    var client = sts.Client.initWithOptions(
        allocator,
        &cfg,
        .{ .keep_alive = false },
    );
    defer client.deinit();

    var arena = std.heap.ArenaAllocator.init(allocator);
    defer arena.deinit();

    const result = try client.getCallerIdentity(
        arena.allocator(),
        .{},
        .{},
    );

    const account = result.account orelse return error.MissingAccount;
    const arn = result.arn orelse return error.MissingArn;
    const user_id = result.user_id orelse return error.MissingUserId;

    try std.testing.expectEqual(@as(usize, 12), account.len);
    try std.testing.expect(std.mem.startsWith(u8, arn, "arn:aws:"));
    try std.testing.expect(std.mem.indexOf(u8, arn, account) != null);
    try std.testing.expect(user_id.len > 0);
}
