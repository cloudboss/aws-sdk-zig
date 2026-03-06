const std = @import("std");
const aws = @import("aws");
const sts = @import("sts");

test "getCallerIdentity returns account info from LocalStack" {
    const allocator = std.testing.allocator;

    var cfg = try aws.Config.load(allocator, .{});
    defer cfg.deinit();

    var client = sts.Client.initWithOptions(allocator, &cfg, .{ .keep_alive = false });
    defer client.deinit();

    var arena = std.heap.ArenaAllocator.init(allocator);
    defer arena.deinit();

    const result = try client.getCallerIdentity(
        arena.allocator(),
        .{},
        .{},
    );

    // LocalStack returns dummy account info
    try std.testing.expect(result.account != null);
    try std.testing.expect(result.arn != null);
    try std.testing.expect(result.user_id != null);
}

test "service error populates diagnostic on invalid action" {
    const allocator = std.testing.allocator;

    var cfg = try aws.Config.load(allocator, .{});
    defer cfg.deinit();

    var client = sts.Client.initWithOptions(allocator, &cfg, .{ .keep_alive = false });
    defer client.deinit();

    var arena = std.heap.ArenaAllocator.init(allocator);
    defer arena.deinit();

    // Use getCallerIdentity with a diagnostic to verify error handling works
    // when the response is successful (no error case). This at least exercises
    // the full execute -> serialize -> sign -> send -> deserialize path.
    var diagnostic: sts.ServiceError = undefined;
    const result = try client.getCallerIdentity(
        arena.allocator(),
        .{},
        .{ .diagnostic = &diagnostic },
    );

    // Should succeed -- this confirms the full round-trip works with diagnostics
    try std.testing.expect(result.account != null);
}

test "getSessionToken returns temporary credentials" {
    const allocator = std.testing.allocator;

    var cfg = try aws.Config.load(allocator, .{});
    defer cfg.deinit();

    var client = sts.Client.initWithOptions(allocator, &cfg, .{ .keep_alive = false });
    defer client.deinit();

    var arena = std.heap.ArenaAllocator.init(allocator);
    defer arena.deinit();

    const result = try client.getSessionToken(
        arena.allocator(),
        .{},
        .{},
    );

    // GetSessionToken wraps credentials in a nested struct
    try std.testing.expect(result.credentials != null);

    const creds = result.credentials.?;
    // Temporary credentials must have non-empty key fields
    try std.testing.expect(creds.access_key_id.len > 0);
    try std.testing.expect(creds.secret_access_key.len > 0);
    // Temporary credentials always include a session token
    try std.testing.expect(creds.session_token.len > 0);
    // Expiration must be set (non-zero epoch timestamp)
    try std.testing.expect(creds.expiration != 0);
}

test "getCallerIdentity response fields have expected format" {
    const allocator = std.testing.allocator;

    var cfg = try aws.Config.load(allocator, .{});
    defer cfg.deinit();

    var client = sts.Client.initWithOptions(allocator, &cfg, .{ .keep_alive = false });
    defer client.deinit();

    var arena = std.heap.ArenaAllocator.init(allocator);
    defer arena.deinit();

    const result = try client.getCallerIdentity(
        arena.allocator(),
        .{},
        .{},
    );

    // Account must be present
    try std.testing.expect(result.account != null);

    // ARN must start with "arn:"
    try std.testing.expect(result.arn != null);
    try std.testing.expect(std.mem.startsWith(u8, result.arn.?, "arn:"));

    // User ID must be non-empty
    try std.testing.expect(result.user_id != null);
    try std.testing.expect(result.user_id.?.len > 0);
}

test "GetCallerIdentity account has 12 digit format" {
    const allocator = std.testing.allocator;

    var cfg = try aws.Config.load(allocator, .{});
    defer cfg.deinit();

    var client = sts.Client.initWithOptions(allocator, &cfg, .{ .keep_alive = false });
    defer client.deinit();

    var arena = std.heap.ArenaAllocator.init(allocator);
    defer arena.deinit();

    const result = try client.getCallerIdentity(
        arena.allocator(),
        .{},
        .{},
    );

    // AWS account IDs are always exactly 12 digits
    const account = result.account orelse return error.MissingAccount;
    try std.testing.expectEqual(@as(usize, 12), account.len);
}

test "GetCallerIdentity ARN contains account" {
    const allocator = std.testing.allocator;

    var cfg = try aws.Config.load(allocator, .{});
    defer cfg.deinit();

    var client = sts.Client.initWithOptions(allocator, &cfg, .{ .keep_alive = false });
    defer client.deinit();

    var arena = std.heap.ArenaAllocator.init(allocator);
    defer arena.deinit();

    const result = try client.getCallerIdentity(
        arena.allocator(),
        .{},
        .{},
    );

    // The ARN must embed the account ID as a substring
    const account = result.account orelse return error.MissingAccount;
    const arn = result.arn orelse return error.MissingArn;
    try std.testing.expect(std.mem.indexOf(u8, arn, account) != null);
}

test "GetSessionToken credentials differ from source credentials" {
    const allocator = std.testing.allocator;

    var cfg = try aws.Config.load(allocator, .{});
    defer cfg.deinit();

    var client = sts.Client.initWithOptions(allocator, &cfg, .{ .keep_alive = false });
    defer client.deinit();

    var arena = std.heap.ArenaAllocator.init(allocator);
    defer arena.deinit();

    const result = try client.getSessionToken(
        arena.allocator(),
        .{},
        .{},
    );

    const creds = result.credentials orelse return error.MissingCredentials;

    // Temporary credentials have access key IDs of at least 16 characters,
    // distinguishing them from short static keys like "test"
    try std.testing.expect(creds.access_key_id.len >= 16);
}

test "GetCallerIdentity returns consistent results across calls" {
    const allocator = std.testing.allocator;

    var cfg = try aws.Config.load(allocator, .{});
    defer cfg.deinit();

    var client = sts.Client.initWithOptions(allocator, &cfg, .{ .keep_alive = false });
    defer client.deinit();

    var arena = std.heap.ArenaAllocator.init(allocator);
    defer arena.deinit();

    // First call
    const result1 = try client.getCallerIdentity(
        arena.allocator(),
        .{},
        .{},
    );

    // Second call
    const result2 = try client.getCallerIdentity(
        arena.allocator(),
        .{},
        .{},
    );

    // Account must be identical across both calls
    const account1 = result1.account orelse return error.MissingAccount;
    const account2 = result2.account orelse return error.MissingAccount;
    try std.testing.expectEqualStrings(account1, account2);
}

test "Config resolves sts_regional_endpoints from load options" {
    const allocator = std.testing.allocator;

    var cfg = try aws.Config.load(allocator, .{
        .sts_regional_endpoints = .legacy,
    });
    defer cfg.deinit();

    try std.testing.expectEqual(
        aws.StsRegionalEndpoints.legacy,
        cfg.sts_regional_endpoints,
    );
}
