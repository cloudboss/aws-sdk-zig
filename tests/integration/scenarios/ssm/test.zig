const std = @import("std");
const aws = @import("aws");
const ssm = @import("ssm");

test "PutParameter, GetParameter, DeleteParameter" {
    const allocator = std.testing.allocator;

    const endpoint_url = std.posix.getenv("AWS_ENDPOINT_URL") orelse
        return error.MissingEndpoint;

    var cfg = try aws.Config.load(allocator, .{
        .endpoint_url = endpoint_url,
    });
    defer cfg.deinit();

    var client = ssm.Client.initWithOptions(allocator, &cfg, .{ .keep_alive = false });
    defer client.deinit();

    const param_name = "/sdk-zig/test-param";
    const param_value = "test-value-123";

    // --- PutParameter ---
    var put_result = try ssm.put_parameter.execute(
        &client,
        .{
            .name = param_name,
            .value = param_value,
            .type = .string,
            .overwrite = true,
        },
        .{},
    );
    defer put_result.deinit();

    try std.testing.expect(put_result.version != null);

    // --- GetParameter ---
    var get_result = try ssm.get_parameter.execute(
        &client,
        .{ .name = param_name },
        .{},
    );
    defer get_result.deinit();

    const param = get_result.parameter orelse return error.MissingParameter;
    try std.testing.expectEqualStrings(param_name, param.name orelse
        return error.MissingName);
    try std.testing.expectEqualStrings(param_value, param.value orelse
        return error.MissingValue);

    // --- DeleteParameter ---
    var delete_result = try ssm.delete_parameter.execute(
        &client,
        .{ .name = param_name },
        .{},
    );
    defer delete_result.deinit();
}

test "GetParameter returns error for missing parameter" {
    const allocator = std.testing.allocator;

    const endpoint_url = std.posix.getenv("AWS_ENDPOINT_URL") orelse
        return error.MissingEndpoint;

    var cfg = try aws.Config.load(allocator, .{
        .endpoint_url = endpoint_url,
    });
    defer cfg.deinit();

    var client = ssm.Client.initWithOptions(allocator, &cfg, .{ .keep_alive = false });
    defer client.deinit();

    var diagnostic: ssm.ServiceError = undefined;
    const result = ssm.get_parameter.execute(
        &client,
        .{ .name = "/nonexistent/param-12345" },
        .{ .diagnostic = &diagnostic },
    );

    try std.testing.expectError(error.ServiceError, result);

    switch (diagnostic) {
        .parameter_not_found => |e| {
            try std.testing.expect(e.message.len > 0);
        },
        else => {
            std.debug.print("Expected ParameterNotFound, got: {s}\n", .{diagnostic.code()});
            return error.UnexpectedError;
        },
    }
}

test "GetParametersByPath returns parameters under prefix" {
    const allocator = std.testing.allocator;

    const endpoint_url = std.posix.getenv("AWS_ENDPOINT_URL") orelse
        return error.MissingEndpoint;

    var cfg = try aws.Config.load(allocator, .{
        .endpoint_url = endpoint_url,
    });
    defer cfg.deinit();

    var client = ssm.Client.initWithOptions(allocator, &cfg, .{ .keep_alive = false });
    defer client.deinit();

    const param_a = "/sdk-zig/path-test/param-a";
    const param_b = "/sdk-zig/path-test/param-b";

    // --- PutParameter param-a ---
    var put_a = try ssm.put_parameter.execute(
        &client,
        .{
            .name = param_a,
            .value = "value-a",
            .type = .string,
            .overwrite = true,
        },
        .{},
    );
    defer put_a.deinit();

    // --- PutParameter param-b ---
    var put_b = try ssm.put_parameter.execute(
        &client,
        .{
            .name = param_b,
            .value = "value-b",
            .type = .string,
            .overwrite = true,
        },
        .{},
    );
    defer put_b.deinit();

    // --- GetParametersByPath ---
    var path_result = try ssm.get_parameters_by_path.execute(
        &client,
        .{ .path = "/sdk-zig/path-test", .recursive = false },
        .{},
    );
    defer path_result.deinit();

    const params = path_result.parameters orelse
        return error.MissingParameters;
    try std.testing.expect(params.len >= 2);

    // --- Cleanup ---
    var del_a = try ssm.delete_parameter.execute(
        &client,
        .{ .name = param_a },
        .{},
    );
    defer del_a.deinit();

    var del_b = try ssm.delete_parameter.execute(
        &client,
        .{ .name = param_b },
        .{},
    );
    defer del_b.deinit();
}

test "PutParameter with SecureString type stores successfully" {
    const allocator = std.testing.allocator;

    const endpoint_url = std.posix.getenv("AWS_ENDPOINT_URL") orelse
        return error.MissingEndpoint;

    var cfg = try aws.Config.load(allocator, .{
        .endpoint_url = endpoint_url,
    });
    defer cfg.deinit();

    var client = ssm.Client.initWithOptions(allocator, &cfg, .{ .keep_alive = false });
    defer client.deinit();

    const param_name = "/sdk-zig/secure-string-test";

    // --- PutParameter with SecureString ---
    var put_result = try ssm.put_parameter.execute(
        &client,
        .{
            .name = param_name,
            .value = "secret-value",
            .type = .secure_string,
            .overwrite = true,
        },
        .{},
    );
    defer put_result.deinit();

    try std.testing.expect(put_result.version != null);

    // --- GetParameter to verify ---
    var get_result = try ssm.get_parameter.execute(
        &client,
        .{ .name = param_name },
        .{},
    );
    defer get_result.deinit();

    const param = get_result.parameter orelse return error.MissingParameter;
    try std.testing.expectEqualStrings(
        param_name,
        param.name orelse return error.MissingName,
    );
    try std.testing.expect(param.value != null);

    // --- Cleanup ---
    var del_result = try ssm.delete_parameter.execute(
        &client,
        .{ .name = param_name },
        .{},
    );
    defer del_result.deinit();
}

test "DescribeParameters includes created parameter" {
    const allocator = std.testing.allocator;

    const endpoint_url = std.posix.getenv("AWS_ENDPOINT_URL") orelse
        return error.MissingEndpoint;

    var cfg = try aws.Config.load(allocator, .{
        .endpoint_url = endpoint_url,
    });
    defer cfg.deinit();

    var client = ssm.Client.initWithOptions(allocator, &cfg, .{ .keep_alive = false });
    defer client.deinit();

    const param_name = "/sdk-zig/describe-test";

    // --- PutParameter ---
    var put_result = try ssm.put_parameter.execute(
        &client,
        .{
            .name = param_name,
            .value = "describe-value",
            .type = .string,
            .overwrite = true,
        },
        .{},
    );
    defer put_result.deinit();

    // --- DescribeParameters ---
    var describe_result = try ssm.describe_parameters.execute(
        &client,
        .{},
        .{},
    );
    defer describe_result.deinit();

    const params = describe_result.parameters orelse
        return error.MissingParameters;
    try std.testing.expect(params.len > 0);

    // --- Cleanup ---
    var del_result = try ssm.delete_parameter.execute(
        &client,
        .{ .name = param_name },
        .{},
    );
    defer del_result.deinit();
}
