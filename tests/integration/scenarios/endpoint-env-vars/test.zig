const std = @import("std");
const aws = @import("aws");
const sts = @import("sts");

test "Config.load resolves AWS_ENDPOINT_URL from environment" {
    const allocator = std.testing.allocator;

    const endpoint_url = std.posix.getenv("AWS_ENDPOINT_URL") orelse
        return error.MissingEndpoint;
    if (endpoint_url.len == 0) return error.MissingEndpoint;

    // Load config without explicit endpoint_url -- it should resolve
    // from the AWS_ENDPOINT_URL environment variable.
    var cfg = try aws.Config.load(allocator, .{});
    defer cfg.deinit();

    try std.testing.expect(cfg.endpoint_url != null);
    try std.testing.expectEqualStrings(endpoint_url, cfg.endpoint_url.?);

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
