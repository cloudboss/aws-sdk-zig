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
    if (!shared_init) {
        _ = gpa.deinit();
        return;
    }
    shared_client.deinit();
    shared_cfg.deinit();
    try std.testing.expect(gpa.deinit() == .ok);
}

test "ListFunctions returns successfully" {
    var arena = std.heap.ArenaAllocator.init(gpa.allocator());
    defer arena.deinit();

    const result = try shared_client.listFunctions(arena.allocator(), .{}, .{});

    const functions = result.functions orelse return error.MissingFunctions;
    try std.testing.expectEqual(@as(usize, 0), functions.len);
}

test "ListFunctions with max_items returns successfully" {
    var arena = std.heap.ArenaAllocator.init(gpa.allocator());
    defer arena.deinit();

    const result = try shared_client.listFunctions(
        arena.allocator(),
        .{ .max_items = 1 },
        .{},
    );

    const functions = result.functions orelse return error.MissingFunctions;
    try std.testing.expectEqual(@as(usize, 0), functions.len);
}

test "ListFunctions next_marker is null on empty result" {
    var arena = std.heap.ArenaAllocator.init(gpa.allocator());
    defer arena.deinit();

    const result = try shared_client.listFunctions(arena.allocator(), .{}, .{});

    try std.testing.expect(result.next_marker == null);
}

test "GetFunction returns ResourceNotFoundException for missing function" {
    var arena = std.heap.ArenaAllocator.init(gpa.allocator());
    defer arena.deinit();

    var diagnostic: lambda.ServiceError = undefined;
    const result = shared_client.getFunction(
        arena.allocator(),
        .{ .function_name = "nonexistent-function-12345" },
        .{ .diagnostic = &diagnostic },
    );

    try std.testing.expectError(error.ServiceError, result);
    defer diagnostic.deinit();

    switch (diagnostic.kind) {
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
    var arena = std.heap.ArenaAllocator.init(gpa.allocator());
    defer arena.deinit();

    var diagnostic: lambda.ServiceError = undefined;
    _ = shared_client.getFunction(
        arena.allocator(),
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

test "Runtime enum type is accessible" {
    // Verify that the Runtime enum is exported and usable
    const rt: lambda.types.Runtime = .python_39;
    try std.testing.expect(rt == .python_39);

    const rt2: lambda.types.Runtime = .nodejs_18_x;
    try std.testing.expect(rt2 != rt);
}

test "GetAccountSettings returns Lambda account limits" {
    var arena = std.heap.ArenaAllocator.init(gpa.allocator());
    defer arena.deinit();

    const result = try shared_client.getAccountSettings(
        arena.allocator(),
        .{},
        .{},
    );

    _ = result.account_limit orelse return error.MissingAccountLimit;
}

test "GetAccountSettings total_code_size is non-negative" {
    var arena = std.heap.ArenaAllocator.init(gpa.allocator());
    defer arena.deinit();

    const result = try shared_client.getAccountSettings(
        arena.allocator(),
        .{},
        .{},
    );

    const limit = result.account_limit orelse return error.MissingAccountLimit;
    const total_code_size = limit.total_code_size;
    try std.testing.expect(total_code_size >= 0);
}

test "GetAccountSettings concurrent_executions is positive" {
    var arena = std.heap.ArenaAllocator.init(gpa.allocator());
    defer arena.deinit();

    const result = try shared_client.getAccountSettings(
        arena.allocator(),
        .{},
        .{},
    );

    const limit = result.account_limit orelse return error.MissingAccountLimit;
    const concurrent = limit.concurrent_executions;
    try std.testing.expect(concurrent > 0);
}

test "GetAccountSettings code_size_unzipped is positive" {
    var arena = std.heap.ArenaAllocator.init(gpa.allocator());
    defer arena.deinit();

    const result = try shared_client.getAccountSettings(
        arena.allocator(),
        .{},
        .{},
    );

    const limit = result.account_limit orelse return error.MissingAccountLimit;
    const unzipped = limit.code_size_unzipped;
    try std.testing.expect(unzipped > 0);
}

test "GetAccountSettings account_usage is present" {
    var arena = std.heap.ArenaAllocator.init(gpa.allocator());
    defer arena.deinit();

    const result = try shared_client.getAccountSettings(
        arena.allocator(),
        .{},
        .{},
    );

    const usage = result.account_usage orelse return error.MissingAccountUsage;
    const function_count = usage.function_count;
    try std.testing.expect(function_count >= 0);
}

test "GetAccountSettings account_limit has all expected fields" {
    var arena = std.heap.ArenaAllocator.init(gpa.allocator());
    defer arena.deinit();

    const result = try shared_client.getAccountSettings(
        arena.allocator(),
        .{},
        .{},
    );

    const limit = result.account_limit orelse return error.MissingAccountLimit;
    _ = limit.total_code_size;
    _ = limit.concurrent_executions;
    _ = limit.code_size_unzipped;
    _ = limit.code_size_zipped;
    _ = limit.unreserved_concurrent_executions orelse return error.MissingField;
}
