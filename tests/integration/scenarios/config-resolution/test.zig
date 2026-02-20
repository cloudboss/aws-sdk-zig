const std = @import("std");
const aws = @import("aws");
const sts = @import("sts");

test "Config.load resolves settings from config file" {
    const allocator = std.testing.allocator;

    // AWS_CONFIG_FILE points to a temp file with max_attempts=7
    // and retry_mode=adaptive under [default]. These settings
    // have no env-var overrides, so they must come from the file.
    var cfg = try aws.Config.load(allocator, .{});
    defer cfg.deinit();

    try std.testing.expectEqual(@as(u32, 7), cfg.max_attempts);
    try std.testing.expectEqual(
        aws.RetryMode.adaptive,
        cfg.retry_mode,
    );

    try std.testing.expect(cfg.config_file != null);

    var client = sts.Client.initWithOptions(
        allocator,
        &cfg,
        .{ .keep_alive = false },
    );
    defer client.deinit();

    var result = try sts.get_caller_identity.execute(
        &client,
        .{},
        .{},
    );
    defer result.deinit();

    try std.testing.expect(result.account != null);
    try std.testing.expect(result.arn != null);
}
