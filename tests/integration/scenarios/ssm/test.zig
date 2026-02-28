const std = @import("std");
const aws = @import("aws");
const ssm = @import("ssm");

var gpa: std.heap.GeneralPurposeAllocator(.{}) = .init;
var shared_client: ssm.Client = undefined;
var shared_cfg: aws.Config = undefined;
var setup_done: bool = false;

test "zest.beforeAll" {
    const allocator = gpa.allocator();
    shared_cfg = try aws.Config.load(allocator, .{});
    shared_client = ssm.Client.initWithOptions(
        allocator,
        &shared_cfg,
        .{ .keep_alive = false },
    );
    {
        _ = try ssm.put_parameter.execute(
            &shared_client,
            allocator,
            .{
                .name = "/sdk-zig/shared",
                .value = "shared-param-value",
                .type = .string,
                .overwrite = true,
            },
            .{},
        );
    }
    setup_done = true;
}

test "zest.afterAll" {
    if (!setup_done) {
        _ = gpa.deinit();
        return;
    }
    {
        _ = ssm.delete_parameter.execute(
            &shared_client,
            gpa.allocator(),
            .{ .name = "/sdk-zig/shared" },
            .{},
        ) catch |err| {
            std.log.warn("afterAll cleanup: {s}", .{@errorName(err)});
            shared_client.deinit();
            shared_cfg.deinit();
            _ = gpa.deinit();
            return err;
        };
    }
    shared_client.deinit();
    shared_cfg.deinit();
    try std.testing.expect(gpa.deinit() == .ok);
}

test "PutParameter returns version number" {
    var arena = std.heap.ArenaAllocator.init(gpa.allocator());
    defer arena.deinit();

    const put_result = try ssm.put_parameter.execute(
        &shared_client,
        arena.allocator(),
        .{
            .name = "/sdk-zig/put-version",
            .value = "version-test",
            .type = .string,
            .overwrite = true,
        },
        .{},
    );

    try std.testing.expect(put_result.version != null);

    // Cleanup
    {
        _ = try ssm.delete_parameter.execute(
            &shared_client,
            arena.allocator(),
            .{ .name = "/sdk-zig/put-version" },
            .{},
        );
    }
}

test "GetParameter retrieves stored parameter value" {
    var arena = std.heap.ArenaAllocator.init(gpa.allocator());
    defer arena.deinit();

    const get_result = try ssm.get_parameter.execute(
        &shared_client,
        arena.allocator(),
        .{ .name = "/sdk-zig/shared" },
        .{},
    );

    const param = get_result.parameter orelse return error.MissingParameter;
    try std.testing.expectEqualStrings(
        "/sdk-zig/shared",
        param.name orelse return error.MissingName,
    );
    try std.testing.expectEqualStrings(
        "shared-param-value",
        param.value orelse return error.MissingValue,
    );
}

test "DeleteParameter removes parameter" {
    var arena = std.heap.ArenaAllocator.init(gpa.allocator());
    defer arena.deinit();

    // Create own resource
    {
        _ = try ssm.put_parameter.execute(
            &shared_client,
            arena.allocator(),
            .{
                .name = "/sdk-zig/delete-removes",
                .value = "to-be-deleted",
                .type = .string,
                .overwrite = true,
            },
            .{},
        );
    }

    // Delete it
    {
        _ = try ssm.delete_parameter.execute(
            &shared_client,
            arena.allocator(),
            .{ .name = "/sdk-zig/delete-removes" },
            .{},
        );
    }

    // Verify get returns error
    var diagnostic: ssm.ServiceError = undefined;
    const result = ssm.get_parameter.execute(
        &shared_client,
        arena.allocator(),
        .{ .name = "/sdk-zig/delete-removes" },
        .{ .diagnostic = &diagnostic },
    );

    try std.testing.expectError(error.ServiceError, result);
    defer diagnostic.deinit();
    switch (diagnostic.kind) {
        .parameter_not_found => {},
        else => {
            std.log.err(
                "expected parameter_not_found, got: {s}",
                .{diagnostic.code()},
            );
            return error.UnexpectedError;
        },
    }
}

test "GetParameter returns error for missing parameter" {
    var arena = std.heap.ArenaAllocator.init(gpa.allocator());
    defer arena.deinit();

    var diagnostic: ssm.ServiceError = undefined;
    const result = ssm.get_parameter.execute(
        &shared_client,
        arena.allocator(),
        .{ .name = "/nonexistent/param-12345" },
        .{ .diagnostic = &diagnostic },
    );

    try std.testing.expectError(error.ServiceError, result);
    defer diagnostic.deinit();

    switch (diagnostic.kind) {
        .parameter_not_found => |e| {
            try std.testing.expect(e.message.len > 0);
        },
        else => {
            std.log.err(
                "expected parameter_not_found, got: {s}",
                .{diagnostic.code()},
            );
            return error.UnexpectedError;
        },
    }
}

test "GetParametersByPath returns parameters under prefix" {
    var arena = std.heap.ArenaAllocator.init(gpa.allocator());
    defer arena.deinit();

    {
        _ = try ssm.put_parameter.execute(
            &shared_client,
            arena.allocator(),
            .{
                .name = "/sdk-zig/path-test/param-a",
                .value = "value-a",
                .type = .string,
                .overwrite = true,
            },
            .{},
        );
    }
    {
        _ = try ssm.put_parameter.execute(
            &shared_client,
            arena.allocator(),
            .{
                .name = "/sdk-zig/path-test/param-b",
                .value = "value-b",
                .type = .string,
                .overwrite = true,
            },
            .{},
        );
    }

    const result = try ssm.get_parameters_by_path.execute(
        &shared_client,
        arena.allocator(),
        .{ .path = "/sdk-zig/path-test", .recursive = false },
        .{},
    );

    const params = result.parameters orelse return error.MissingParameters;
    try std.testing.expect(params.len >= 2);

    // Cleanup
    {
        _ = try ssm.delete_parameter.execute(
            &shared_client,
            arena.allocator(),
            .{ .name = "/sdk-zig/path-test/param-a" },
            .{},
        );
    }
    {
        _ = try ssm.delete_parameter.execute(
            &shared_client,
            arena.allocator(),
            .{ .name = "/sdk-zig/path-test/param-b" },
            .{},
        );
    }
}

test "PutParameter with SecureString type stores successfully" {
    var arena = std.heap.ArenaAllocator.init(gpa.allocator());
    defer arena.deinit();

    const put_result = try ssm.put_parameter.execute(
        &shared_client,
        arena.allocator(),
        .{
            .name = "/sdk-zig/secure-string-test",
            .value = "secret-value",
            .type = .secure_string,
            .overwrite = true,
        },
        .{},
    );

    try std.testing.expect(put_result.version != null);

    const get_result = try ssm.get_parameter.execute(
        &shared_client,
        arena.allocator(),
        .{ .name = "/sdk-zig/secure-string-test" },
        .{},
    );

    const param = get_result.parameter orelse return error.MissingParameter;
    try std.testing.expectEqualStrings(
        "/sdk-zig/secure-string-test",
        param.name orelse return error.MissingName,
    );
    try std.testing.expect(param.value != null);

    // Cleanup
    {
        _ = try ssm.delete_parameter.execute(
            &shared_client,
            arena.allocator(),
            .{ .name = "/sdk-zig/secure-string-test" },
            .{},
        );
    }
}

test "DescribeParameters includes created parameter" {
    var arena = std.heap.ArenaAllocator.init(gpa.allocator());
    defer arena.deinit();

    {
        _ = try ssm.put_parameter.execute(
            &shared_client,
            arena.allocator(),
            .{
                .name = "/sdk-zig/describe-test",
                .value = "describe-value",
                .type = .string,
                .overwrite = true,
            },
            .{},
        );
    }

    const result = try ssm.describe_parameters.execute(
        &shared_client,
        arena.allocator(),
        .{},
        .{},
    );

    const params = result.parameters orelse return error.MissingParameters;
    try std.testing.expect(params.len > 0);

    // Cleanup
    {
        _ = try ssm.delete_parameter.execute(
            &shared_client,
            arena.allocator(),
            .{ .name = "/sdk-zig/describe-test" },
            .{},
        );
    }
}

test "PutParameter with StringList type stores list value" {
    var arena = std.heap.ArenaAllocator.init(gpa.allocator());
    defer arena.deinit();

    const put_result = try ssm.put_parameter.execute(
        &shared_client,
        arena.allocator(),
        .{
            .name = "/sdk-zig/string-list-test",
            .value = "item1,item2,item3",
            .type = .string_list,
            .overwrite = true,
        },
        .{},
    );

    try std.testing.expect(put_result.version != null);

    // Cleanup
    {
        _ = try ssm.delete_parameter.execute(
            &shared_client,
            arena.allocator(),
            .{ .name = "/sdk-zig/string-list-test" },
            .{},
        );
    }
}

test "GetParameter with decryption returns SecureString value" {
    var arena = std.heap.ArenaAllocator.init(gpa.allocator());
    defer arena.deinit();

    const param_name = "/sdk-zig/decrypt-test";
    const secret_value = "my-secret-value";

    {
        _ = try ssm.put_parameter.execute(
            &shared_client,
            arena.allocator(),
            .{
                .name = param_name,
                .value = secret_value,
                .type = .secure_string,
                .overwrite = true,
            },
            .{},
        );
    }

    const get_result = try ssm.get_parameter.execute(
        &shared_client,
        arena.allocator(),
        .{ .name = param_name, .with_decryption = true },
        .{},
    );

    const param = get_result.parameter orelse return error.MissingParameter;
    try std.testing.expectEqualStrings(
        secret_value,
        param.value orelse return error.MissingValue,
    );

    // Cleanup
    {
        _ = try ssm.delete_parameter.execute(
            &shared_client,
            arena.allocator(),
            .{ .name = param_name },
            .{},
        );
    }
}

test "PutParameter with overwrite updates existing value" {
    var arena = std.heap.ArenaAllocator.init(gpa.allocator());
    defer arena.deinit();

    const param_name = "/sdk-zig/overwrite-test";

    {
        _ = try ssm.put_parameter.execute(
            &shared_client,
            arena.allocator(),
            .{
                .name = param_name,
                .value = "original-value",
                .type = .string,
                .overwrite = true,
            },
            .{},
        );
    }

    {
        _ = try ssm.put_parameter.execute(
            &shared_client,
            arena.allocator(),
            .{
                .name = param_name,
                .value = "updated-value",
                .type = .string,
                .overwrite = true,
            },
            .{},
        );
    }

    const get_result = try ssm.get_parameter.execute(
        &shared_client,
        arena.allocator(),
        .{ .name = param_name },
        .{},
    );

    const param = get_result.parameter orelse return error.MissingParameter;
    try std.testing.expectEqualStrings(
        "updated-value",
        param.value orelse return error.MissingValue,
    );

    // Cleanup
    {
        _ = try ssm.delete_parameter.execute(
            &shared_client,
            arena.allocator(),
            .{ .name = param_name },
            .{},
        );
    }
}

test "GetParametersByPath with recursive flag returns nested params" {
    var arena = std.heap.ArenaAllocator.init(gpa.allocator());
    defer arena.deinit();

    {
        _ = try ssm.put_parameter.execute(
            &shared_client,
            arena.allocator(),
            .{
                .name = "/sdk-zig/recurse/a",
                .value = "val-a",
                .type = .string,
                .overwrite = true,
            },
            .{},
        );
    }
    {
        _ = try ssm.put_parameter.execute(
            &shared_client,
            arena.allocator(),
            .{
                .name = "/sdk-zig/recurse/b/c",
                .value = "val-bc",
                .type = .string,
                .overwrite = true,
            },
            .{},
        );
    }

    const result = try ssm.get_parameters_by_path.execute(
        &shared_client,
        arena.allocator(),
        .{ .path = "/sdk-zig/recurse", .recursive = true },
        .{},
    );

    const params = result.parameters orelse return error.MissingParameters;
    try std.testing.expect(params.len >= 2);

    // Cleanup
    {
        _ = try ssm.delete_parameter.execute(
            &shared_client,
            arena.allocator(),
            .{ .name = "/sdk-zig/recurse/a" },
            .{},
        );
    }
    {
        _ = try ssm.delete_parameter.execute(
            &shared_client,
            arena.allocator(),
            .{ .name = "/sdk-zig/recurse/b/c" },
            .{},
        );
    }
}

test "DescribeParameters returns parameter metadata with type field" {
    var arena = std.heap.ArenaAllocator.init(gpa.allocator());
    defer arena.deinit();

    {
        _ = try ssm.put_parameter.execute(
            &shared_client,
            arena.allocator(),
            .{
                .name = "/sdk-zig/describe-type-test",
                .value = "type-test-value",
                .type = .string,
                .overwrite = true,
            },
            .{},
        );
    }

    const result = try ssm.describe_parameters.execute(
        &shared_client,
        arena.allocator(),
        .{},
        .{},
    );

    const params = result.parameters orelse return error.MissingParameters;
    var found = false;
    for (params) |p| {
        const name = p.name orelse continue;
        if (std.mem.eql(u8, name, "/sdk-zig/describe-type-test")) {
            try std.testing.expect(p.type != null);
            found = true;
            break;
        }
    }
    try std.testing.expect(found);

    // Cleanup
    {
        _ = try ssm.delete_parameter.execute(
            &shared_client,
            arena.allocator(),
            .{ .name = "/sdk-zig/describe-type-test" },
            .{},
        );
    }
}

test "DeleteParameter for nonexistent parameter returns error" {
    var arena = std.heap.ArenaAllocator.init(gpa.allocator());
    defer arena.deinit();

    var diagnostic: ssm.ServiceError = undefined;
    const result = ssm.delete_parameter.execute(
        &shared_client,
        arena.allocator(),
        .{ .name = "/sdk-zig/definitely-does-not-exist" },
        .{ .diagnostic = &diagnostic },
    );

    try std.testing.expectError(error.ServiceError, result);
    defer diagnostic.deinit();
    switch (diagnostic.kind) {
        .parameter_not_found => {},
        else => {
            std.log.err(
                "expected parameter_not_found, got: {s}",
                .{diagnostic.code()},
            );
            return error.UnexpectedError;
        },
    }
}
