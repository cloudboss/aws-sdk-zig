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
        var r = try ssm.put_parameter.execute(
            &shared_client,
            .{
                .name = "/sdk-zig/shared",
                .value = "shared-param-value",
                .type = .string,
                .overwrite = true,
            },
            .{},
        );
        defer r.deinit();
    }
    setup_done = true;
}

test "zest.afterAll" {
    if (!setup_done) {
        _ = gpa.deinit();
        return;
    }
    {
        var r = ssm.delete_parameter.execute(
            &shared_client,
            .{ .name = "/sdk-zig/shared" },
            .{},
        ) catch |err| {
            std.log.warn("afterAll cleanup: {s}", .{@errorName(err)});
            shared_client.deinit();
            shared_cfg.deinit();
            _ = gpa.deinit();
            return err;
        };
        r.deinit();
    }
    shared_client.deinit();
    shared_cfg.deinit();
    try std.testing.expect(gpa.deinit() == .ok);
}

test "PutParameter returns version number" {
    var put_result = try ssm.put_parameter.execute(
        &shared_client,
        .{
            .name = "/sdk-zig/put-version",
            .value = "version-test",
            .type = .string,
            .overwrite = true,
        },
        .{},
    );
    defer put_result.deinit();

    try std.testing.expect(put_result.version != null);

    // Cleanup
    {
        var r = try ssm.delete_parameter.execute(
            &shared_client,
            .{ .name = "/sdk-zig/put-version" },
            .{},
        );
        defer r.deinit();
    }
}

test "GetParameter retrieves stored parameter value" {
    var get_result = try ssm.get_parameter.execute(
        &shared_client,
        .{ .name = "/sdk-zig/shared" },
        .{},
    );
    defer get_result.deinit();

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
    // Create own resource
    {
        var r = try ssm.put_parameter.execute(
            &shared_client,
            .{
                .name = "/sdk-zig/delete-removes",
                .value = "to-be-deleted",
                .type = .string,
                .overwrite = true,
            },
            .{},
        );
        defer r.deinit();
    }

    // Delete it
    {
        var r = try ssm.delete_parameter.execute(
            &shared_client,
            .{ .name = "/sdk-zig/delete-removes" },
            .{},
        );
        defer r.deinit();
    }

    // Verify get returns error
    var diagnostic: ssm.ServiceError = undefined;
    const result = ssm.get_parameter.execute(
        &shared_client,
        .{ .name = "/sdk-zig/delete-removes" },
        .{ .diagnostic = &diagnostic },
    );

    try std.testing.expectError(error.ServiceError, result);
    defer diagnostic.deinit();
    switch (diagnostic) {
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
    var diagnostic: ssm.ServiceError = undefined;
    const result = ssm.get_parameter.execute(
        &shared_client,
        .{ .name = "/nonexistent/param-12345" },
        .{ .diagnostic = &diagnostic },
    );

    try std.testing.expectError(error.ServiceError, result);
    defer diagnostic.deinit();

    switch (diagnostic) {
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
    {
        var r = try ssm.put_parameter.execute(
            &shared_client,
            .{
                .name = "/sdk-zig/path-test/param-a",
                .value = "value-a",
                .type = .string,
                .overwrite = true,
            },
            .{},
        );
        defer r.deinit();
    }
    {
        var r = try ssm.put_parameter.execute(
            &shared_client,
            .{
                .name = "/sdk-zig/path-test/param-b",
                .value = "value-b",
                .type = .string,
                .overwrite = true,
            },
            .{},
        );
        defer r.deinit();
    }

    var result = try ssm.get_parameters_by_path.execute(
        &shared_client,
        .{ .path = "/sdk-zig/path-test", .recursive = false },
        .{},
    );
    defer result.deinit();

    const params = result.parameters orelse return error.MissingParameters;
    try std.testing.expect(params.len >= 2);

    // Cleanup
    {
        var r = try ssm.delete_parameter.execute(
            &shared_client,
            .{ .name = "/sdk-zig/path-test/param-a" },
            .{},
        );
        defer r.deinit();
    }
    {
        var r = try ssm.delete_parameter.execute(
            &shared_client,
            .{ .name = "/sdk-zig/path-test/param-b" },
            .{},
        );
        defer r.deinit();
    }
}

test "PutParameter with SecureString type stores successfully" {
    var put_result = try ssm.put_parameter.execute(
        &shared_client,
        .{
            .name = "/sdk-zig/secure-string-test",
            .value = "secret-value",
            .type = .secure_string,
            .overwrite = true,
        },
        .{},
    );
    defer put_result.deinit();

    try std.testing.expect(put_result.version != null);

    var get_result = try ssm.get_parameter.execute(
        &shared_client,
        .{ .name = "/sdk-zig/secure-string-test" },
        .{},
    );
    defer get_result.deinit();

    const param = get_result.parameter orelse return error.MissingParameter;
    try std.testing.expectEqualStrings(
        "/sdk-zig/secure-string-test",
        param.name orelse return error.MissingName,
    );
    try std.testing.expect(param.value != null);

    // Cleanup
    {
        var r = try ssm.delete_parameter.execute(
            &shared_client,
            .{ .name = "/sdk-zig/secure-string-test" },
            .{},
        );
        defer r.deinit();
    }
}

test "DescribeParameters includes created parameter" {
    {
        var r = try ssm.put_parameter.execute(
            &shared_client,
            .{
                .name = "/sdk-zig/describe-test",
                .value = "describe-value",
                .type = .string,
                .overwrite = true,
            },
            .{},
        );
        defer r.deinit();
    }

    var result = try ssm.describe_parameters.execute(
        &shared_client,
        .{},
        .{},
    );
    defer result.deinit();

    const params = result.parameters orelse return error.MissingParameters;
    try std.testing.expect(params.len > 0);

    // Cleanup
    {
        var r = try ssm.delete_parameter.execute(
            &shared_client,
            .{ .name = "/sdk-zig/describe-test" },
            .{},
        );
        defer r.deinit();
    }
}

test "PutParameter with StringList type stores list value" {
    var put_result = try ssm.put_parameter.execute(
        &shared_client,
        .{
            .name = "/sdk-zig/string-list-test",
            .value = "item1,item2,item3",
            .type = .string_list,
            .overwrite = true,
        },
        .{},
    );
    defer put_result.deinit();

    try std.testing.expect(put_result.version != null);

    // Cleanup
    {
        var r = try ssm.delete_parameter.execute(
            &shared_client,
            .{ .name = "/sdk-zig/string-list-test" },
            .{},
        );
        defer r.deinit();
    }
}

test "GetParameter with decryption returns SecureString value" {
    const param_name = "/sdk-zig/decrypt-test";
    const secret_value = "my-secret-value";

    {
        var r = try ssm.put_parameter.execute(
            &shared_client,
            .{
                .name = param_name,
                .value = secret_value,
                .type = .secure_string,
                .overwrite = true,
            },
            .{},
        );
        defer r.deinit();
    }

    var get_result = try ssm.get_parameter.execute(
        &shared_client,
        .{ .name = param_name, .with_decryption = true },
        .{},
    );
    defer get_result.deinit();

    const param = get_result.parameter orelse return error.MissingParameter;
    try std.testing.expectEqualStrings(
        secret_value,
        param.value orelse return error.MissingValue,
    );

    // Cleanup
    {
        var r = try ssm.delete_parameter.execute(
            &shared_client,
            .{ .name = param_name },
            .{},
        );
        defer r.deinit();
    }
}

test "PutParameter with overwrite updates existing value" {
    const param_name = "/sdk-zig/overwrite-test";

    {
        var r = try ssm.put_parameter.execute(
            &shared_client,
            .{
                .name = param_name,
                .value = "original-value",
                .type = .string,
                .overwrite = true,
            },
            .{},
        );
        defer r.deinit();
    }

    {
        var r = try ssm.put_parameter.execute(
            &shared_client,
            .{
                .name = param_name,
                .value = "updated-value",
                .type = .string,
                .overwrite = true,
            },
            .{},
        );
        defer r.deinit();
    }

    var get_result = try ssm.get_parameter.execute(
        &shared_client,
        .{ .name = param_name },
        .{},
    );
    defer get_result.deinit();

    const param = get_result.parameter orelse return error.MissingParameter;
    try std.testing.expectEqualStrings(
        "updated-value",
        param.value orelse return error.MissingValue,
    );

    // Cleanup
    {
        var r = try ssm.delete_parameter.execute(
            &shared_client,
            .{ .name = param_name },
            .{},
        );
        defer r.deinit();
    }
}

test "GetParametersByPath with recursive flag returns nested params" {
    {
        var r = try ssm.put_parameter.execute(
            &shared_client,
            .{
                .name = "/sdk-zig/recurse/a",
                .value = "val-a",
                .type = .string,
                .overwrite = true,
            },
            .{},
        );
        defer r.deinit();
    }
    {
        var r = try ssm.put_parameter.execute(
            &shared_client,
            .{
                .name = "/sdk-zig/recurse/b/c",
                .value = "val-bc",
                .type = .string,
                .overwrite = true,
            },
            .{},
        );
        defer r.deinit();
    }

    var result = try ssm.get_parameters_by_path.execute(
        &shared_client,
        .{ .path = "/sdk-zig/recurse", .recursive = true },
        .{},
    );
    defer result.deinit();

    const params = result.parameters orelse return error.MissingParameters;
    try std.testing.expect(params.len >= 2);

    // Cleanup
    {
        var r = try ssm.delete_parameter.execute(
            &shared_client,
            .{ .name = "/sdk-zig/recurse/a" },
            .{},
        );
        defer r.deinit();
    }
    {
        var r = try ssm.delete_parameter.execute(
            &shared_client,
            .{ .name = "/sdk-zig/recurse/b/c" },
            .{},
        );
        defer r.deinit();
    }
}

test "DescribeParameters returns parameter metadata with type field" {
    {
        var r = try ssm.put_parameter.execute(
            &shared_client,
            .{
                .name = "/sdk-zig/describe-type-test",
                .value = "type-test-value",
                .type = .string,
                .overwrite = true,
            },
            .{},
        );
        defer r.deinit();
    }

    var result = try ssm.describe_parameters.execute(
        &shared_client,
        .{},
        .{},
    );
    defer result.deinit();

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
        var r = try ssm.delete_parameter.execute(
            &shared_client,
            .{ .name = "/sdk-zig/describe-type-test" },
            .{},
        );
        defer r.deinit();
    }
}

test "DeleteParameter for nonexistent parameter returns error" {
    var diagnostic: ssm.ServiceError = undefined;
    const result = ssm.delete_parameter.execute(
        &shared_client,
        .{ .name = "/sdk-zig/definitely-does-not-exist" },
        .{ .diagnostic = &diagnostic },
    );

    try std.testing.expectError(error.ServiceError, result);
    defer diagnostic.deinit();
    switch (diagnostic) {
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
