const std = @import("std");
const aws = @import("aws");
const lambda = @import("lambda");

test "listFunctions returns successfully" {
    const allocator = std.testing.allocator;

    const endpoint_url = std.posix.getenv("AWS_ENDPOINT_URL") orelse
        return error.MissingEndpoint;

    var cfg = try aws.Config.load(allocator, .{
        .endpoint_url = endpoint_url,
    });
    defer cfg.deinit();

    var client = lambda.Client.initWithOptions(allocator, &cfg, .{ .keep_alive = false });
    defer client.deinit();

    var result = try lambda.list_functions.execute(
        &client,
        .{},
        .{},
    );
    defer result.deinit();

    // LocalStack returns an empty list by default
    const functions = result.functions orelse return error.MissingFunctions;
    try std.testing.expectEqual(@as(usize, 0), functions.len);
}

test "getFunction returns ResourceNotFoundException for missing function" {
    const allocator = std.testing.allocator;

    const endpoint_url = std.posix.getenv("AWS_ENDPOINT_URL") orelse
        return error.MissingEndpoint;

    var cfg = try aws.Config.load(allocator, .{
        .endpoint_url = endpoint_url,
    });
    defer cfg.deinit();

    var client = lambda.Client.initWithOptions(allocator, &cfg, .{ .keep_alive = false });
    defer client.deinit();

    var diagnostic: lambda.ServiceError = undefined;
    const result = lambda.get_function.execute(
        &client,
        .{ .function_name = "nonexistent-function-12345" },
        .{ .diagnostic = &diagnostic },
    );

    // Should fail with ServiceError
    try std.testing.expectError(error.ServiceError, result);

    // Verify the error was parsed from __type as ResourceNotFoundException
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

test "GetAccountSettings returns Lambda account limits" {
    const allocator = std.testing.allocator;

    const endpoint_url = std.posix.getenv("AWS_ENDPOINT_URL") orelse
        return error.MissingEndpoint;

    var cfg = try aws.Config.load(allocator, .{
        .endpoint_url = endpoint_url,
    });
    defer cfg.deinit();

    var client = lambda.Client.initWithOptions(allocator, &cfg, .{ .keep_alive = false });
    defer client.deinit();

    var result = try lambda.get_account_settings.execute(
        &client,
        .{},
        .{},
    );
    defer result.deinit();

    // Verify account_limit is present
    const account_limit = result.account_limit orelse return error.MissingAccountLimit;

    // Verify required fields are non-null
    _ = account_limit.total_code_size orelse return error.MissingTotalCodeSize;
    _ = account_limit.concurrent_executions orelse return error.MissingConcurrentExecutions;

    try std.testing.expect(true);
}
