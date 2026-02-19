const std = @import("std");
const aws = @import("aws");
const sts = @import("sts");

test "credential_process from profile resolves credentials" {
    const allocator = std.testing.allocator;

    const endpoint_url = std.posix.getenv("AWS_ENDPOINT_URL") orelse
        return error.MissingEndpoint;

    // AWS_CONFIG_FILE points to a config with [profile test-process]
    // containing credential_process = /tmp/cred-process.sh.
    var cfg = try aws.Config.load(allocator, .{
        .profile = "test-process",
        .endpoint_url = endpoint_url,
    });
    defer cfg.deinit();

    // Extract credential_process from the parsed config file
    const cf = cfg.config_file orelse return error.MissingConfigFile;
    const profile = cf.getProfile("test-process") orelse
        return error.MissingProfile;
    const command = profile.credential_process orelse
        return error.MissingCredentialProcess;

    try std.testing.expectEqualStrings(
        "/tmp/cred-process.sh",
        command,
    );

    // Invoke the process provider directly
    var pp = aws.process_creds.ProcessProvider{ .command = command };
    const creds = try pp.getCredentials(allocator);
    defer {
        allocator.free(creds.access_key_id);
        allocator.free(creds.secret_access_key);
        if (creds.session_token) |t| allocator.free(t);
    }

    try std.testing.expectEqualStrings(
        "AKIAPROCESSTEST",
        creds.access_key_id,
    );
    try std.testing.expect(creds.secret_access_key.len > 0);
    try std.testing.expect(creds.expiration != null);

    // Verify the full STS round-trip still works
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
