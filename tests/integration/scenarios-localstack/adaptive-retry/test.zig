const std = @import("std");
const aws = @import("aws");
const sts = @import("sts");

test "adaptive retry mode propagates to HttpClient" {
    const allocator = std.testing.allocator;

    var cfg = try aws.Config.load(allocator, .{});
    defer cfg.deinit();
    cfg.retry_mode = .adaptive;

    var client = sts.Client.initWithOptions(
        allocator,
        &cfg,
        .{ .keep_alive = false },
    );
    defer client.deinit();

    try std.testing.expectEqual(
        aws.RetryMode.adaptive,
        client.http_client.retry_mode,
    );
}

test "adaptive retry succeeds on valid request" {
    const allocator = std.testing.allocator;

    var cfg = try aws.Config.load(allocator, .{});
    defer cfg.deinit();
    cfg.retry_mode = .adaptive;

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

    try std.testing.expect(result.account != null);
    try std.testing.expect(result.arn != null);
}

test "token bucket at full capacity after success" {
    const allocator = std.testing.allocator;

    var cfg = try aws.Config.load(allocator, .{});
    defer cfg.deinit();
    cfg.retry_mode = .adaptive;

    var client = sts.Client.initWithOptions(
        allocator,
        &cfg,
        .{ .keep_alive = false },
    );
    defer client.deinit();

    var arena = std.heap.ArenaAllocator.init(allocator);
    defer arena.deinit();

    _ = try client.getCallerIdentity(
        arena.allocator(),
        .{},
        .{},
    );

    // After a successful request, onSuccess caps capacity at 500
    try std.testing.expectEqual(
        @as(f64, 500.0),
        client.http_client.token_bucket.current_capacity,
    );
}
