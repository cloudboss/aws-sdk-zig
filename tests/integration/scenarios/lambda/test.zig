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

    var client = lambda.Client.init(allocator, &cfg);
    defer client.deinit();

    var result = try lambda.list_functions.execute(
        &client,
        .{},
        .{},
    );
    defer result.deinit();

    // LocalStack returns an empty list by default -- success means
    // the full REST-JSON serialize -> sign -> send -> deserialize round-trip works.
}

test "getFunction returns ResourceNotFoundException for missing function" {
    const allocator = std.testing.allocator;

    const endpoint_url = std.posix.getenv("AWS_ENDPOINT_URL") orelse
        return error.MissingEndpoint;

    var cfg = try aws.Config.load(allocator, .{
        .endpoint_url = endpoint_url,
    });
    defer cfg.deinit();

    var client = lambda.Client.init(allocator, &cfg);
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
