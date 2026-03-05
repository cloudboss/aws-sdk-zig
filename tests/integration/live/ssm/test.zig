const std = @import("std");

const aws = @import("aws");
const ssm = @import("ssm");

var gpa: std.heap.GeneralPurposeAllocator(.{}) = .init;
var shared_client: ssm.Client = undefined;
var shared_cfg: aws.Config = undefined;
var setup_done: bool = false;
var shared_param_buf: [64]u8 = undefined;
var shared_param: []const u8 = "";
var shared_secure_buf: [64]u8 = undefined;
var shared_secure: []const u8 = "";

test "zest.beforeAll" {
    const allocator = gpa.allocator();
    shared_cfg = try aws.Config.load(allocator, .{});
    shared_client = ssm.Client.initWithOptions(
        allocator,
        &shared_cfg,
        .{ .keep_alive = false },
    );

    const ts = std.time.timestamp();
    shared_param = try std.fmt.bufPrint(
        &shared_param_buf,
        "/sdk-zig-live/param-{d}",
        .{ts},
    );
    shared_secure = try std.fmt.bufPrint(
        &shared_secure_buf,
        "/sdk-zig-live/secure-{d}",
        .{ts},
    );

    setup_done = true;
}

test "zest.afterAll" {
    if (!setup_done) {
        _ = gpa.deinit();
        return;
    }
    const allocator = gpa.allocator();
    var arena = std.heap.ArenaAllocator.init(allocator);
    defer arena.deinit();

    _ = shared_client.deleteParameter(
        arena.allocator(),
        .{ .name = shared_param },
        .{},
    ) catch {};
    _ = shared_client.deleteParameter(
        arena.allocator(),
        .{ .name = shared_secure },
        .{},
    ) catch {};

    shared_client.deinit();
    shared_cfg.deinit();
    try std.testing.expect(gpa.deinit() == .ok);
}

test "putParameter creates a String parameter" {
    var arena = std.heap.ArenaAllocator.init(gpa.allocator());
    defer arena.deinit();

    const result = try shared_client.putParameter(
        arena.allocator(),
        .{
            .name = shared_param,
            .value = "hello-ssm",
            .type = .string,
            .tags = &.{
                .{
                    .key = "aws-sdk-zig-test",
                    .value = "true",
                },
                .{
                    .key = "created-by",
                    .value = "live-test",
                },
            },
        },
        .{},
    );

    try std.testing.expect(result.version != null);
}

test "getParameter retrieves correct value" {
    var arena = std.heap.ArenaAllocator.init(gpa.allocator());
    defer arena.deinit();

    const result = try shared_client.getParameter(
        arena.allocator(),
        .{ .name = shared_param },
        .{},
    );

    const param = result.parameter orelse
        return error.MissingParameter;
    try std.testing.expectEqualStrings(
        "hello-ssm",
        param.value orelse return error.MissingValue,
    );
    try std.testing.expectEqual(
        .string,
        param.type orelse return error.MissingType,
    );
}

test "getParametersByPath returns parameters under prefix" {
    var arena = std.heap.ArenaAllocator.init(gpa.allocator());
    defer arena.deinit();

    const result = try shared_client.getParametersByPath(
        arena.allocator(),
        .{
            .path = "/sdk-zig-live/",
            .recursive = false,
        },
        .{},
    );

    const params = result.parameters orelse
        return error.MissingParameters;
    try std.testing.expect(params.len >= 1);
}

test "putParameter with overwrite updates value" {
    var arena = std.heap.ArenaAllocator.init(gpa.allocator());
    defer arena.deinit();

    _ = try shared_client.putParameter(
        arena.allocator(),
        .{
            .name = shared_param,
            .value = "updated-ssm",
            .type = .string,
            .overwrite = true,
        },
        .{},
    );

    const result = try shared_client.getParameter(
        arena.allocator(),
        .{ .name = shared_param },
        .{},
    );

    const param = result.parameter orelse
        return error.MissingParameter;
    try std.testing.expectEqualStrings(
        "updated-ssm",
        param.value orelse return error.MissingValue,
    );
}

test "describeParameters finds parameter by name" {
    var arena = std.heap.ArenaAllocator.init(gpa.allocator());
    defer arena.deinit();

    const result = try shared_client.describeParameters(
        arena.allocator(),
        .{
            .parameter_filters = &.{
                .{
                    .key = "Name",
                    .option = "Equals",
                    .values = &.{shared_param},
                },
            },
        },
        .{},
    );

    const params = result.parameters orelse
        return error.MissingParameters;
    try std.testing.expect(params.len >= 1);

    var found = false;
    for (params) |p| {
        const name = p.name orelse continue;
        if (std.mem.eql(u8, name, shared_param)) {
            found = true;
            break;
        }
    }
    try std.testing.expect(found);
}

test "deleteParameter removes parameter" {
    var arena = std.heap.ArenaAllocator.init(gpa.allocator());
    defer arena.deinit();

    _ = try shared_client.deleteParameter(
        arena.allocator(),
        .{ .name = shared_param },
        .{},
    );

    var diagnostic: ssm.ServiceError = undefined;
    const result = shared_client.getParameter(
        arena.allocator(),
        .{ .name = shared_param },
        .{ .diagnostic = &diagnostic },
    );

    try std.testing.expectError(
        error.ServiceError,
        result,
    );
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

test "putParameter creates a SecureString parameter" {
    var arena = std.heap.ArenaAllocator.init(gpa.allocator());
    defer arena.deinit();

    const put_result = try shared_client.putParameter(
        arena.allocator(),
        .{
            .name = shared_secure,
            .value = "secret-value",
            .type = .secure_string,
        },
        .{},
    );
    try std.testing.expect(put_result.version != null);

    const get_result = try shared_client.getParameter(
        arena.allocator(),
        .{
            .name = shared_secure,
            .with_decryption = true,
        },
        .{},
    );

    const param = get_result.parameter orelse
        return error.MissingParameter;
    try std.testing.expectEqualStrings(
        "secret-value",
        param.value orelse return error.MissingValue,
    );
    try std.testing.expectEqual(
        .secure_string,
        param.type orelse return error.MissingType,
    );
}
