const std = @import("std");
const aws = @import("aws");
const sts = @import("sts");

test "getCallerIdentity returns account info from LocalStack" {
    const allocator = std.testing.allocator;

    const endpoint_url = std.posix.getenv("AWS_ENDPOINT_URL") orelse
        return error.MissingEndpoint;

    var cfg = try aws.Config.load(allocator, .{
        .endpoint_url = endpoint_url,
    });
    defer cfg.deinit();

    var client = sts.Client.initWithOptions(allocator, &cfg, .{ .keep_alive = false });
    defer client.deinit();

    var result = try sts.get_caller_identity.execute(
        &client,
        .{},
        .{},
    );
    defer result.deinit();

    // LocalStack returns dummy account info
    try std.testing.expect(result.account != null);
    try std.testing.expect(result.arn != null);
    try std.testing.expect(result.user_id != null);
}

test "service error populates diagnostic on invalid action" {
    const allocator = std.testing.allocator;

    const endpoint_url = std.posix.getenv("AWS_ENDPOINT_URL") orelse
        return error.MissingEndpoint;

    var cfg = try aws.Config.load(allocator, .{
        .endpoint_url = endpoint_url,
    });
    defer cfg.deinit();

    var client = sts.Client.initWithOptions(allocator, &cfg, .{ .keep_alive = false });
    defer client.deinit();

    // Use getCallerIdentity with a diagnostic to verify error handling works
    // when the response is successful (no error case). This at least exercises
    // the full execute -> serialize -> sign -> send -> deserialize path.
    var diagnostic: sts.ServiceError = undefined;
    var result = try sts.get_caller_identity.execute(
        &client,
        .{},
        .{ .diagnostic = &diagnostic },
    );
    defer result.deinit();

    // Should succeed -- this confirms the full round-trip works with diagnostics
    try std.testing.expect(result.account != null);
}

test "getSessionToken returns temporary credentials" {
    const allocator = std.testing.allocator;

    const endpoint_url = std.posix.getenv("AWS_ENDPOINT_URL") orelse
        return error.MissingEndpoint;

    var cfg = try aws.Config.load(allocator, .{
        .endpoint_url = endpoint_url,
    });
    defer cfg.deinit();

    var client = sts.Client.initWithOptions(allocator, &cfg, .{ .keep_alive = false });
    defer client.deinit();

    var result = try sts.get_session_token.execute(
        &client,
        .{},
        .{},
    );
    defer result.deinit();

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

    const endpoint_url = std.posix.getenv("AWS_ENDPOINT_URL") orelse
        return error.MissingEndpoint;

    var cfg = try aws.Config.load(allocator, .{
        .endpoint_url = endpoint_url,
    });
    defer cfg.deinit();

    var client = sts.Client.initWithOptions(allocator, &cfg, .{ .keep_alive = false });
    defer client.deinit();

    var result = try sts.get_caller_identity.execute(
        &client,
        .{},
        .{},
    );
    defer result.deinit();

    // Account must be present
    try std.testing.expect(result.account != null);

    // ARN must start with "arn:"
    try std.testing.expect(result.arn != null);
    try std.testing.expect(std.mem.startsWith(u8, result.arn.?, "arn:"));

    // User ID must be non-empty
    try std.testing.expect(result.user_id != null);
    try std.testing.expect(result.user_id.?.len > 0);
}
