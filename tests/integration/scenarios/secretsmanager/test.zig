const std = @import("std");
const aws = @import("aws");
const secretsmanager = @import("secretsmanager");

var gpa: std.heap.GeneralPurposeAllocator(.{}) = .init;
var shared_client: ?secretsmanager.Client = null;
var shared_cfg: ?aws.Config = null;

test "zest.beforeAll" {
    const allocator = gpa.allocator();
    shared_cfg = try aws.Config.load(allocator, .{});
    shared_client = secretsmanager.Client.initWithOptions(
        allocator,
        &shared_cfg.?,
        .{ .keep_alive = false },
    );
    var result = try secretsmanager.create_secret.execute(
        &shared_client.?,
        .{
            .name = "sdk-zig-sm-shared",
            .secret_string = "shared-secret-value",
            .client_request_token = "a1b2c3d4-e5f6-7890-abcd-ef1234567890",
        },
        .{},
    );
    defer result.deinit();
}

test "zest.afterAll" {
    if (shared_client) |*c| {
        defer c.deinit();
        var r = secretsmanager.delete_secret.execute(c, .{
            .secret_id = "sdk-zig-sm-shared",
            .force_delete_without_recovery = true,
        }, .{}) catch |err| {
            std.log.warn(
                "afterAll: failed to delete shared secret: {s}",
                .{@errorName(err)},
            );
            if (shared_cfg) |*cfg| cfg.deinit();
            _ = gpa.deinit();
            return;
        };
        r.deinit();
    }
    if (shared_cfg) |*cfg| cfg.deinit();
    try std.testing.expect(gpa.deinit() == .ok);
}

test "CreateSecret returns valid response fields" {
    const client = &(shared_client orelse return error.TestSetupFailed);
    var result = try secretsmanager.create_secret.execute(
        client,
        .{
            .name = "sdk-zig-sm-create-test",
            .secret_string = "create-test-value",
            .client_request_token = "b1c2d3e4-f5a6-7890-bcde-f01234567890",
        },
        .{},
    );
    defer result.deinit();

    try std.testing.expect(result.arn != null);
    try std.testing.expectEqualStrings(
        "sdk-zig-sm-create-test",
        result.name orelse return error.MissingName,
    );

    var del = try secretsmanager.delete_secret.execute(
        client,
        .{
            .secret_id = "sdk-zig-sm-create-test",
            .force_delete_without_recovery = true,
        },
        .{},
    );
    defer del.deinit();
}

test "GetSecretValue returns stored secret string" {
    const client = &(shared_client orelse return error.TestSetupFailed);
    var result = try secretsmanager.get_secret_value.execute(
        client,
        .{ .secret_id = "sdk-zig-sm-shared" },
        .{},
    );
    defer result.deinit();

    try std.testing.expectEqualStrings(
        "shared-secret-value",
        result.secret_string orelse return error.MissingSecretString,
    );
}

test "DeleteSecret with force removes secret" {
    const client = &(shared_client orelse return error.TestSetupFailed);
    {
        var result = try secretsmanager.create_secret.execute(
            client,
            .{
                .name = "sdk-zig-sm-delete-test",
                .secret_string = "delete-me",
                .client_request_token = "c2d3e4f5-a6b7-8901-cdef-012345678901",
            },
            .{},
        );
        defer result.deinit();
    }

    var result = try secretsmanager.delete_secret.execute(
        client,
        .{
            .secret_id = "sdk-zig-sm-delete-test",
            .force_delete_without_recovery = true,
        },
        .{},
    );
    defer result.deinit();

    try std.testing.expectEqualStrings(
        "sdk-zig-sm-delete-test",
        result.name orelse return error.MissingName,
    );
}

test "GetSecretValue returns error for missing secret" {
    const client = &(shared_client orelse return error.TestSetupFailed);
    var diagnostic: secretsmanager.ServiceError = undefined;
    const result = secretsmanager.get_secret_value.execute(
        client,
        .{ .secret_id = "nonexistent-secret-12345" },
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

test "UpdateSecret changes stored value" {
    const client = &(shared_client orelse return error.TestSetupFailed);
    {
        var result = try secretsmanager.create_secret.execute(
            client,
            .{
                .name = "sdk-zig-sm-update",
                .secret_string = "original-value",
                .client_request_token = "d3e4f5a6-b7c8-9012-defa-123456789012",
            },
            .{},
        );
        defer result.deinit();
    }

    {
        var result = try secretsmanager.update_secret.execute(
            client,
            .{
                .secret_id = "sdk-zig-sm-update",
                .secret_string = "updated-value",
                .client_request_token = "e4f5a6b7-c8d9-0123-efab-234567890123",
            },
            .{},
        );
        defer result.deinit();
    }

    {
        var result = try secretsmanager.get_secret_value.execute(
            client,
            .{ .secret_id = "sdk-zig-sm-update" },
            .{},
        );
        defer result.deinit();

        try std.testing.expectEqualStrings(
            "updated-value",
            result.secret_string orelse return error.MissingSecretString,
        );
    }

    var del = try secretsmanager.delete_secret.execute(
        client,
        .{
            .secret_id = "sdk-zig-sm-update",
            .force_delete_without_recovery = true,
        },
        .{},
    );
    defer del.deinit();
}

test "ListSecrets returns created secret" {
    const client = &(shared_client orelse return error.TestSetupFailed);
    {
        var result = try secretsmanager.create_secret.execute(
            client,
            .{
                .name = "sdk-zig-sm-list",
                .secret_string = "list-test-value",
                .client_request_token = "f5a6b7c8-d9e0-1234-fabc-345678901234",
            },
            .{},
        );
        defer result.deinit();
    }

    var list_result = try secretsmanager.list_secrets.execute(
        client,
        .{},
        .{},
    );
    defer list_result.deinit();

    const secret_list = list_result.secret_list orelse
        return error.MissingSecretList;
    var found = false;
    for (secret_list) |entry| {
        if (entry.name) |name| {
            if (std.mem.eql(u8, name, "sdk-zig-sm-list")) {
                found = true;
                break;
            }
        }
    }
    try std.testing.expect(found);

    var del = try secretsmanager.delete_secret.execute(
        client,
        .{
            .secret_id = "sdk-zig-sm-list",
            .force_delete_without_recovery = true,
        },
        .{},
    );
    defer del.deinit();
}

test "DescribeSecret returns secret metadata" {
    const client = &(shared_client orelse return error.TestSetupFailed);
    {
        var result = try secretsmanager.create_secret.execute(
            client,
            .{
                .name = "sdk-zig-sm-describe",
                .secret_string = "describe-test-value",
                .client_request_token = "a6b7c8d9-e0f1-2345-abcd-456789012345",
            },
            .{},
        );
        defer result.deinit();
    }

    {
        var result = try secretsmanager.describe_secret.execute(
            client,
            .{ .secret_id = "sdk-zig-sm-describe" },
            .{},
        );
        defer result.deinit();

        try std.testing.expectEqualStrings(
            "sdk-zig-sm-describe",
            result.name orelse return error.MissingName,
        );
        try std.testing.expect(result.arn != null);
    }

    var del = try secretsmanager.delete_secret.execute(
        client,
        .{
            .secret_id = "sdk-zig-sm-describe",
            .force_delete_without_recovery = true,
        },
        .{},
    );
    defer del.deinit();
}

test "PutSecretValue updates secret with new version" {
    const client = &(shared_client orelse return error.TestSetupFailed);
    {
        var result = try secretsmanager.create_secret.execute(
            client,
            .{
                .name = "sdk-zig-sm-put-version",
                .secret_string = "version-one",
                .client_request_token = "b7c8d9e0-f1a2-3456-bcde-567890123456",
            },
            .{},
        );
        defer result.deinit();
    }

    {
        var result = try secretsmanager.put_secret_value.execute(
            client,
            .{
                .secret_id = "sdk-zig-sm-put-version",
                .secret_string = "version-two",
                .client_request_token = "c8d9e0f1-a2b3-4567-cdef-678901234567",
            },
            .{},
        );
        defer result.deinit();

        try std.testing.expect(result.version_id != null);
    }

    {
        var result = try secretsmanager.get_secret_value.execute(
            client,
            .{ .secret_id = "sdk-zig-sm-put-version" },
            .{},
        );
        defer result.deinit();

        try std.testing.expectEqualStrings(
            "version-two",
            result.secret_string orelse return error.MissingSecretString,
        );
    }

    var del = try secretsmanager.delete_secret.execute(
        client,
        .{
            .secret_id = "sdk-zig-sm-put-version",
            .force_delete_without_recovery = true,
        },
        .{},
    );
    defer del.deinit();
}

test "DescribeSecret returns metadata for shared secret" {
    const client = &(shared_client orelse return error.TestSetupFailed);
    var result = try secretsmanager.describe_secret.execute(
        client,
        .{ .secret_id = "sdk-zig-sm-shared" },
        .{},
    );
    defer result.deinit();

    try std.testing.expect(result.arn != null);
    try std.testing.expectEqualStrings(
        "sdk-zig-sm-shared",
        result.name orelse return error.MissingName,
    );
}

test "GetSecretValue for deleted secret returns error" {
    const client = &(shared_client orelse return error.TestSetupFailed);
    {
        var result = try secretsmanager.create_secret.execute(
            client,
            .{
                .name = "sdk-zig-sm-get-deleted",
                .secret_string = "soon-to-be-deleted",
                .client_request_token = "e0f1a2b3-c4d5-6789-efab-890123456789",
            },
            .{},
        );
        defer result.deinit();
    }

    {
        var result = try secretsmanager.delete_secret.execute(
            client,
            .{
                .secret_id = "sdk-zig-sm-get-deleted",
                .force_delete_without_recovery = true,
            },
            .{},
        );
        defer result.deinit();
    }

    var diagnostic: secretsmanager.ServiceError = undefined;
    const result = secretsmanager.get_secret_value.execute(
        client,
        .{ .secret_id = "sdk-zig-sm-get-deleted" },
        .{ .diagnostic = &diagnostic },
    );

    try std.testing.expectError(error.ServiceError, result);
    defer diagnostic.deinit();

    switch (diagnostic.kind) {
        .resource_not_found_exception => {},
        else => {
            std.log.err(
                "expected ResourceNotFoundException, got: {s}",
                .{diagnostic.code()},
            );
            return error.UnexpectedError;
        },
    }
}

test "TagResource adds tags to secret" {
    const client = &(shared_client orelse return error.TestSetupFailed);
    {
        var result = try secretsmanager.create_secret.execute(
            client,
            .{
                .name = "sdk-zig-sm-tag",
                .secret_string = "tag-test-value",
                .client_request_token = "f1a2b3c4-d5e6-7890-fabc-901234567890",
            },
            .{},
        );
        defer result.deinit();
    }

    {
        var result = try secretsmanager.tag_resource.execute(
            client,
            .{
                .secret_id = "sdk-zig-sm-tag",
                .tags = &.{
                    .{ .key = "env", .value = "test" },
                    .{ .key = "project", .value = "sdk-zig" },
                },
            },
            .{},
        );
        defer result.deinit();
    }

    {
        var result = try secretsmanager.describe_secret.execute(
            client,
            .{ .secret_id = "sdk-zig-sm-tag" },
            .{},
        );
        defer result.deinit();

        try std.testing.expectEqualStrings(
            "sdk-zig-sm-tag",
            result.name orelse return error.MissingName,
        );
    }

    var del = try secretsmanager.delete_secret.execute(
        client,
        .{
            .secret_id = "sdk-zig-sm-tag",
            .force_delete_without_recovery = true,
        },
        .{},
    );
    defer del.deinit();
}

test "ListSecrets includes shared secret from beforeAll" {
    const client = &(shared_client orelse return error.TestSetupFailed);
    var result = try secretsmanager.list_secrets.execute(
        client,
        .{},
        .{},
    );
    defer result.deinit();

    const secret_list = result.secret_list orelse
        return error.MissingSecretList;
    var found = false;
    for (secret_list) |entry| {
        if (entry.name) |name| {
            if (std.mem.eql(u8, name, "sdk-zig-sm-shared")) {
                found = true;
                break;
            }
        }
    }
    try std.testing.expect(found);
}
