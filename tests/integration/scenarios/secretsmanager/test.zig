const std = @import("std");
const aws = @import("aws");
const secretsmanager = @import("secretsmanager");

test "CreateSecret, GetSecretValue, DeleteSecret" {
    const allocator = std.testing.allocator;

    const endpoint_url = std.posix.getenv("AWS_ENDPOINT_URL") orelse
        return error.MissingEndpoint;

    var cfg = try aws.Config.load(allocator, .{
        .endpoint_url = endpoint_url,
    });
    defer cfg.deinit();

    var client = secretsmanager.Client.initWithOptions(allocator, &cfg, .{ .keep_alive = false });
    defer client.deinit();

    const secret_name = "sdk-zig-test-secret";
    const secret_value = "super-secret-value-42";

    // --- CreateSecret ---
    // LocalStack requires a UUID-format ClientRequestToken
    var create_result = try secretsmanager.create_secret.execute(
        &client,
        .{
            .name = secret_name,
            .secret_string = secret_value,
            .client_request_token = "a1b2c3d4-e5f6-7890-abcd-ef1234567890",
        },
        .{},
    );
    defer create_result.deinit();

    try std.testing.expect(create_result.arn != null);
    try std.testing.expectEqualStrings(secret_name, create_result.name orelse
        return error.MissingName);

    // --- GetSecretValue ---
    var get_result = try secretsmanager.get_secret_value.execute(
        &client,
        .{ .secret_id = secret_name },
        .{},
    );
    defer get_result.deinit();

    try std.testing.expectEqualStrings(secret_value, get_result.secret_string orelse
        return error.MissingSecretString);

    // --- DeleteSecret ---
    var delete_result = try secretsmanager.delete_secret.execute(
        &client,
        .{ .secret_id = secret_name, .force_delete_without_recovery = true },
        .{},
    );
    defer delete_result.deinit();

    try std.testing.expectEqualStrings(secret_name, delete_result.name orelse
        return error.MissingName);
}

test "GetSecretValue returns error for missing secret" {
    const allocator = std.testing.allocator;

    const endpoint_url = std.posix.getenv("AWS_ENDPOINT_URL") orelse
        return error.MissingEndpoint;

    var cfg = try aws.Config.load(allocator, .{
        .endpoint_url = endpoint_url,
    });
    defer cfg.deinit();

    var client = secretsmanager.Client.initWithOptions(allocator, &cfg, .{ .keep_alive = false });
    defer client.deinit();

    var diagnostic: secretsmanager.ServiceError = undefined;
    const result = secretsmanager.get_secret_value.execute(
        &client,
        .{ .secret_id = "nonexistent-secret-12345" },
        .{ .diagnostic = &diagnostic },
    );

    try std.testing.expectError(error.ServiceError, result);

    switch (diagnostic) {
        .resource_not_found_exception => |e| {
            try std.testing.expect(e.message.len > 0);
        },
        else => {
            std.debug.print("Expected ResourceNotFoundException, got: {s}\n", .{diagnostic.code()});
            return error.UnexpectedError;
        },
    }
}
