const std = @import("std");
const aws = @import("aws");
const sts = @import("sts");

test "chain caches and reuses credentials" {
    const allocator = std.testing.allocator;

    var cfg = try aws.Config.load(allocator, .{});
    defer cfg.deinit();

    // First call -- populates cache
    const creds1 = try cfg.credentials.getCredentials(allocator);
    // Second call -- should return cached copy
    const creds2 = try cfg.credentials.getCredentials(allocator);

    // Same access key both times (cached)
    try std.testing.expectEqualStrings(creds1.access_key_id, creds2.access_key_id);

    // Confirm cached credentials actually work with a real call
    var client = sts.Client.initWithOptions(allocator, &cfg, .{ .keep_alive = false });
    defer client.deinit();

    var arena = std.heap.ArenaAllocator.init(allocator);
    defer arena.deinit();

    const result = try sts.get_caller_identity.execute(
        &client,
        arena.allocator(),
        .{},
        .{},
    );
    try std.testing.expect(result.account != null);
}

test "config passes expiry_buffer through LoadOptions" {
    const allocator = std.testing.allocator;

    var cfg = try aws.Config.load(allocator, .{ .expiry_buffer = 0 });
    defer cfg.deinit();

    switch (cfg.credentials) {
        .chain => |chain| {
            try std.testing.expectEqual(@as(i64, 0), chain.expiry_buffer);
        },
        else => return error.CredentialsNotFound,
    }
}

test "default expiration applied to permanent credentials" {
    const allocator = std.testing.allocator;

    var cfg = try aws.Config.load(allocator, .{ .default_expiration = 900 });
    defer cfg.deinit();

    // Fetch credentials (env-based credentials have no natural expiration)
    _ = try cfg.credentials.getCredentials(allocator);

    // The chain's cached copy should have a synthetic expiration
    switch (cfg.credentials) {
        .chain => |chain| {
            try std.testing.expect(chain.cached != null);
            try std.testing.expect(chain.cached.?.expiration != null);
        },
        else => return error.CredentialsNotFound,
    }
}
