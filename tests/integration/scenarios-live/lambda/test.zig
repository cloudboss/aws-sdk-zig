const std = @import("std");
const aws = @import("aws");
const iam = @import("iam");
const lambda = @import("lambda");

var gpa: std.heap.GeneralPurposeAllocator(.{}) = .init;
var lambda_client: lambda.Client = undefined;
var iam_client: iam.Client = undefined;
var shared_cfg: aws.Config = undefined;
var shared_init = false;

var fn_name_buf: [64]u8 = undefined;
var fn_name: []const u8 = "";
var fn_arn_buf: [256]u8 = undefined;
var fn_arn: []const u8 = "";
var role_name_buf: [64]u8 = undefined;
var role_name: []const u8 = "";
var role_arn_buf: [256]u8 = undefined;
var role_arn: []const u8 = "";

const lambda_trust_policy =
    \\{"Version":"2012-10-17","Statement":
    \\[{"Effect":"Allow","Principal":
    \\{"Service":"lambda.amazonaws.com"},
    \\"Action":"sts:AssumeRole"}]}
;

const managed_policy_arn =
    "arn:aws:iam::aws:policy/service-role/" ++
    "AWSLambdaBasicExecutionRole";

test "zest.beforeAll" {
    const allocator = gpa.allocator();
    var arena = std.heap.ArenaAllocator.init(allocator);
    defer arena.deinit();

    shared_cfg = try aws.Config.load(allocator, .{});
    iam_client = iam.Client.init(allocator, &shared_cfg);
    lambda_client = lambda.Client.init(allocator, &shared_cfg);

    const ts = std.time.timestamp();

    // 1. Create IAM execution role
    role_name = try std.fmt.bufPrint(
        &role_name_buf,
        "sdk-zig-live-lambda-role-{d}",
        .{ts},
    );

    var role_diagnostic: iam.ServiceError = undefined;
    const role_result = iam_client.createRole(
        arena.allocator(),
        .{
            .role_name = role_name,
            .path = "/sdk-zig-live/",
            .assume_role_policy_document = lambda_trust_policy,
        },
        .{ .diagnostic = &role_diagnostic },
    ) catch |err| {
        if (err == error.ServiceError) {
            defer role_diagnostic.deinit();
            std.log.err(
                "createRole failed: {s}: {s}",
                .{ role_diagnostic.code(), role_diagnostic.message() },
            );
        }
        return err;
    };
    const role = role_result.role orelse
        return error.MissingRole;
    const r_arn = role.arn;
    @memcpy(role_arn_buf[0..r_arn.len], r_arn);
    role_arn = role_arn_buf[0..r_arn.len];

    // 2. Attach managed policy
    _ = try iam_client.attachRolePolicy(
        arena.allocator(),
        .{
            .role_name = role_name,
            .policy_arn = managed_policy_arn,
        },
        .{},
    );

    // 3. Wait for IAM propagation
    std.Thread.sleep(10 * std.time.ns_per_s);

    // 4. Read ZIP from setup.sh output
    const zip_bytes = try std.fs.cwd().readFileAlloc(
        allocator,
        "_output/lambda-function.zip",
        10 * 1024 * 1024,
    );
    defer allocator.free(zip_bytes);

    const zip_b64_len = std.base64.standard.Encoder.calcSize(zip_bytes.len);
    const zip_b64_buf = try arena.allocator().alloc(u8, zip_b64_len);
    const zip_b64 = std.base64.standard.Encoder.encode(zip_b64_buf, zip_bytes);

    // 5. Create Lambda function
    fn_name = try std.fmt.bufPrint(
        &fn_name_buf,
        "sdk-zig-live-lambda-{d}",
        .{ts},
    );

    var create: lambda.CreateFunctionOutput = undefined;
    var create_attempts: usize = 0;
    while (true) : (create_attempts += 1) {
        var create_diagnostic: lambda.ServiceError = undefined;
        create = lambda_client.createFunction(
            arena.allocator(),
            .{
                .function_name = fn_name,
                .runtime = .python_312,
                .role = role_arn,
                .handler = "index.handler",
                .code = .{ .zip_file = zip_b64 },
                .tags = &.{
                    .{
                        .key = "aws-sdk-zig-test",
                        .value = "true",
                    },
                    .{
                        .key = "created-by",
                        .value = "integration-test",
                    },
                },
            },
            .{ .diagnostic = &create_diagnostic },
        ) catch |err| {
            if (err != error.ServiceError) return err;
            defer create_diagnostic.deinit();

            switch (create_diagnostic.kind) {
                .invalid_parameter_value_exception,
                .resource_conflict_exception,
                .resource_not_found_exception,
                => {
                    if (create_attempts < 20) {
                        std.Thread.sleep(3 * std.time.ns_per_s);
                        continue;
                    }
                },
                else => {},
            }

            std.log.err(
                "createFunction failed: {s}: {s}",
                .{ create_diagnostic.code(), create_diagnostic.message() },
            );
            return err;
        };
        break;
    }
    const f_arn = create.function_arn orelse
        return error.MissingFunctionArn;
    @memcpy(fn_arn_buf[0..f_arn.len], f_arn);
    fn_arn = fn_arn_buf[0..f_arn.len];

    // 6. Wait for function to become Active
    var attempts: usize = 0;
    while (attempts < 15) : (attempts += 1) {
        std.Thread.sleep(2 * std.time.ns_per_s);
        const cfg_result =
            try lambda_client.getFunctionConfiguration(
                arena.allocator(),
                .{ .function_name = fn_name },
                .{},
            );
        if (cfg_result.state) |state| {
            if (state == .active) break;
        }
    }

    shared_init = true;
}

test "zest.afterAll" {
    if (!shared_init) {
        _ = gpa.deinit();
        return;
    }

    const allocator = gpa.allocator();
    var arena = std.heap.ArenaAllocator.init(allocator);
    defer arena.deinit();

    if (fn_name.len > 0) {
        _ = lambda_client.deleteFunction(
            arena.allocator(),
            .{ .function_name = fn_name },
            .{},
        ) catch {};
    }

    if (role_name.len > 0) {
        _ = iam_client.detachRolePolicy(
            arena.allocator(),
            .{
                .role_name = role_name,
                .policy_arn = managed_policy_arn,
            },
            .{},
        ) catch {};

        _ = iam_client.deleteRole(
            arena.allocator(),
            .{ .role_name = role_name },
            .{},
        ) catch {};
    }

    lambda_client.deinit();
    iam_client.deinit();
    shared_cfg.deinit();
    try std.testing.expect(gpa.deinit() == .ok);
}

test "getFunction returns function metadata" {
    var arena = std.heap.ArenaAllocator.init(std.testing.allocator);
    defer arena.deinit();

    const result = try lambda_client.getFunction(
        arena.allocator(),
        .{ .function_name = fn_name },
        .{},
    );

    const config = result.configuration orelse
        return error.MissingConfiguration;
    const name = config.function_name orelse
        return error.MissingFunctionName;
    try std.testing.expectEqualStrings(fn_name, name);
}

test "listFunctions includes created function" {
    var arena = std.heap.ArenaAllocator.init(std.testing.allocator);
    defer arena.deinit();

    const result = try lambda_client.listFunctions(
        arena.allocator(),
        .{},
        .{},
    );

    const functions = result.functions orelse
        return error.MissingFunctions;
    var found = false;
    for (functions) |f| {
        const name = f.function_name orelse continue;
        if (std.mem.eql(u8, name, fn_name)) {
            found = true;
            break;
        }
    }
    try std.testing.expect(found);
}

test "getAccountSettings returns account limits" {
    var arena = std.heap.ArenaAllocator.init(std.testing.allocator);
    defer arena.deinit();

    const result = try lambda_client.getAccountSettings(
        arena.allocator(),
        .{},
        .{},
    );

    const limit = result.account_limit orelse
        return error.MissingAccountLimit;
    try std.testing.expect(limit.total_code_size > 0);
}

test "invoke returns expected response" {
    var arena = std.heap.ArenaAllocator.init(std.testing.allocator);
    defer arena.deinit();

    const result = try lambda_client.invoke(
        arena.allocator(),
        .{
            .function_name = fn_name,
            .payload = "{}",
        },
        .{},
    );

    const payload = result.payload orelse
        return error.MissingPayload;
    try std.testing.expect(
        std.mem.indexOf(
            u8,
            payload,
            "hello from sdk-zig",
        ) != null,
    );
}

test "getFunctionConfiguration returns runtime" {
    var arena = std.heap.ArenaAllocator.init(std.testing.allocator);
    defer arena.deinit();

    const result =
        try lambda_client.getFunctionConfiguration(
            arena.allocator(),
            .{ .function_name = fn_name },
            .{},
        );

    const runtime = result.runtime orelse
        return error.MissingRuntime;
    try std.testing.expectEqual(
        lambda.types.Runtime.python_312,
        runtime,
    );
}

test "updateFunctionConfiguration changes description" {
    var arena = std.heap.ArenaAllocator.init(std.testing.allocator);
    defer arena.deinit();

    const desc = "updated by sdk-zig live test";

    _ = try lambda_client.updateFunctionConfiguration(
        arena.allocator(),
        .{
            .function_name = fn_name,
            .description = desc,
        },
        .{},
    );

    // Wait briefly for the update to propagate
    std.Thread.sleep(2 * std.time.ns_per_s);

    const result =
        try lambda_client.getFunctionConfiguration(
            arena.allocator(),
            .{ .function_name = fn_name },
            .{},
        );

    const got_desc = result.description orelse
        return error.MissingDescription;
    try std.testing.expectEqualStrings(desc, got_desc);
}

test "listTags returns function tags" {
    var arena = std.heap.ArenaAllocator.init(std.testing.allocator);
    defer arena.deinit();

    const result = try lambda_client.listTags(
        arena.allocator(),
        .{ .resource = fn_arn },
        .{},
    );

    const tags = result.tags orelse
        return error.MissingTags;
    var found = false;
    for (tags) |tag| {
        if (std.mem.eql(u8, tag.key, "aws-sdk-zig-test")) {
            found = true;
            break;
        }
    }
    try std.testing.expect(found);
}
