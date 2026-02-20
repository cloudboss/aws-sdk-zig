const std = @import("std");
const aws = @import("aws");
const sts = @import("sts");

test "AWS_PROFILE selects named profile from credentials file" {
    const allocator = std.testing.allocator;

    // env.sh unsets AWS_ACCESS_KEY_ID / AWS_SECRET_ACCESS_KEY and sets
    // AWS_PROFILE=custom-profile plus AWS_SHARED_CREDENTIALS_FILE
    // pointing to a file with [default] and [custom-profile] sections.
    // Config.load must pick up "custom-profile" from the env var.
    var cfg = try aws.Config.load(allocator, .{});
    defer cfg.deinit();

    try std.testing.expectEqualStrings("custom-profile", cfg.profile);

    // Resolve credentials through the chain -- environment provider
    // should fail (vars unset), falling through to file provider
    // which reads the [custom-profile] section.
    const creds = try cfg.credentials.getCredentials(allocator);
    defer {
        allocator.free(creds.access_key_id);
        allocator.free(creds.secret_access_key);
        if (creds.session_token) |t| allocator.free(t);
    }

    try std.testing.expectEqualStrings(
        "AKIACUSTOMPROFILE",
        creds.access_key_id,
    );
    try std.testing.expectEqualStrings(
        "CustomProfileSecretKey",
        creds.secret_access_key,
    );

    // Full STS round-trip with credentials from the named profile.
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
