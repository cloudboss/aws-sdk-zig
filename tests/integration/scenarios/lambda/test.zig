const std = @import("std");
const aws = @import("aws");
const lambda = @import("lambda");

var gpa: std.heap.GeneralPurposeAllocator(.{}) = .init;
var shared_client: lambda.Client = undefined;
var shared_cfg: aws.Config = undefined;
var shared_init = false;

test "zest.beforeAll" {
    const allocator = gpa.allocator();
    shared_cfg = try aws.Config.load(allocator, .{});
    shared_client = lambda.Client.initWithOptions(
        allocator,
        &shared_cfg,
        .{ .keep_alive = false },
    );
    shared_init = true;
}

test "zest.afterAll" {
    defer _ = gpa.deinit();
    if (!shared_init) return;
    shared_client.deinit();
    shared_cfg.deinit();
}

test "ListFunctions returns successfully" {
    var result = try lambda.list_functions.execute(&shared_client, .{}, .{});
    defer result.deinit();

    const functions = result.functions orelse return error.MissingFunctions;
    try std.testing.expectEqual(@as(usize, 0), functions.len);
}

test "ListFunctions with max_items returns successfully" {
    var result = try lambda.list_functions.execute(
        &shared_client,
        .{ .max_items = 1 },
        .{},
    );
    defer result.deinit();

    const functions = result.functions orelse return error.MissingFunctions;
    try std.testing.expectEqual(@as(usize, 0), functions.len);
}

test "ListFunctions next_marker is null on empty result" {
    var result = try lambda.list_functions.execute(&shared_client, .{}, .{});
    defer result.deinit();

    try std.testing.expect(result.next_marker == null);
}

test "GetFunction returns ResourceNotFoundException for missing function" {
    var diagnostic: lambda.ServiceError = undefined;
    const result = lambda.get_function.execute(
        &shared_client,
        .{ .function_name = "nonexistent-function-12345" },
        .{ .diagnostic = &diagnostic },
    );

    try std.testing.expectError(error.ServiceError, result);
    defer diagnostic.deinit();

    switch (diagnostic) {
        .resource_not_found_exception => |e| {
            try std.testing.expect(e.message.len > 0);
        },
        else => {
            std.log.err(
                "expected ResourceNotFoundException, got: {s}",
                .{diagnostic.code()},
            );
            return error.UnexpectedError;
        },
    }
}

test "GetFunction error diagnostic has parseable code" {
    var diagnostic: lambda.ServiceError = undefined;
    _ = lambda.get_function.execute(
        &shared_client,
        .{ .function_name = "no-such-fn-abc-789" },
        .{ .diagnostic = &diagnostic },
    ) catch |err| {
        try std.testing.expectEqual(error.ServiceError, err);
        defer diagnostic.deinit();
        const code = diagnostic.code();
        try std.testing.expect(code.len > 0);
        return;
    };
    return error.ExpectedError;
}

test "GetAccountSettings returns Lambda account limits" {
    var result = try lambda.get_account_settings.execute(
        &shared_client,
        .{},
        .{},
    );
    defer result.deinit();

    _ = result.account_limit orelse return error.MissingAccountLimit;
}

test "GetAccountSettings total_code_size is non-negative" {
    var result = try lambda.get_account_settings.execute(
        &shared_client,
        .{},
        .{},
    );
    defer result.deinit();

    const limit = result.account_limit orelse return error.MissingAccountLimit;
    const total_code_size = limit.total_code_size orelse
        return error.MissingTotalCodeSize;
    try std.testing.expect(total_code_size >= 0);
}

test "GetAccountSettings concurrent_executions is positive" {
    var result = try lambda.get_account_settings.execute(
        &shared_client,
        .{},
        .{},
    );
    defer result.deinit();

    const limit = result.account_limit orelse return error.MissingAccountLimit;
    const concurrent = limit.concurrent_executions orelse
        return error.MissingConcurrentExecutions;
    try std.testing.expect(concurrent > 0);
}

test "GetAccountSettings code_size_unzipped is positive" {
    var result = try lambda.get_account_settings.execute(
        &shared_client,
        .{},
        .{},
    );
    defer result.deinit();

    const limit = result.account_limit orelse return error.MissingAccountLimit;
    const unzipped = limit.code_size_unzipped orelse
        return error.MissingCodeSizeUnzipped;
    try std.testing.expect(unzipped > 0);
}

test "GetAccountSettings account_usage is present" {
    var result = try lambda.get_account_settings.execute(
        &shared_client,
        .{},
        .{},
    );
    defer result.deinit();

    const usage = result.account_usage orelse return error.MissingAccountUsage;
    const function_count = usage.function_count orelse
        return error.MissingFunctionCount;
    try std.testing.expect(function_count >= 0);
}

test "GetAccountSettings account_limit has all expected fields" {
    var result = try lambda.get_account_settings.execute(
        &shared_client,
        .{},
        .{},
    );
    defer result.deinit();

    const limit = result.account_limit orelse return error.MissingAccountLimit;
    _ = limit.total_code_size orelse return error.MissingField;
    _ = limit.concurrent_executions orelse return error.MissingField;
    _ = limit.code_size_unzipped orelse return error.MissingField;
    _ = limit.code_size_zipped orelse return error.MissingField;
    _ = limit.unreserved_concurrent_executions orelse return error.MissingField;
}
