const std = @import("std");
const aws = @import("aws");
const secretsmanager = @import("secretsmanager");

var gpa: std.heap.GeneralPurposeAllocator(.{}) = .init;
var shared_client: ?secretsmanager.Client = null;
var shared_cfg: ?aws.Config = null;
var shared_secret_arn_buf: [2048]u8 = undefined;
var shared_secret_arn: []const u8 = "";
var shared_secret_name_buf: [128]u8 = undefined;
var shared_secret_name: []const u8 = "";
var shared_create_token_buf: [64]u8 = undefined;

test "zest.beforeAll" {
    const allocator = gpa.allocator();
    shared_cfg = try aws.Config.load(allocator, .{});
    shared_client = secretsmanager.Client.init(allocator, &shared_cfg.?);
    {
        var arena = std.heap.ArenaAllocator.init(allocator);
        defer arena.deinit();

        const name = try std.fmt.bufPrint(
            &shared_secret_name_buf,
            "sdk-zig-live-secret-{d}-{x}",
            .{ std.time.milliTimestamp(), std.crypto.random.int(u32) },
        );
        const create_token = try std.fmt.bufPrint(
            &shared_create_token_buf,
            "{x}-{x}-{x}-{x}",
            .{
                std.crypto.random.int(u32),
                std.crypto.random.int(u32),
                std.crypto.random.int(u32),
                std.crypto.random.int(u32),
            },
        );
        shared_secret_name = name;

        var diagnostic: secretsmanager.ServiceError = undefined;
        const r = shared_client.?.createSecret(
            arena.allocator(),
            .{
                .name = name,
                .client_request_token = create_token,
                .secret_string = "initial-secret-value",
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
            .{ .diagnostic = &diagnostic },
        ) catch |err| {
            if (err == error.ServiceError) {
                defer diagnostic.deinit();
                std.log.err(
                    "beforeAll: createSecret failed: {s}: {s}",
                    .{ diagnostic.code(), diagnostic.message() },
                );
            }
            return err;
        };

        const arn = r.arn orelse
            return error.MissingArn;
        @memcpy(
            shared_secret_arn_buf[0..arn.len],
            arn,
        );
        shared_secret_arn = shared_secret_arn_buf[0..arn.len];
    }
}

test "zest.afterAll" {
    if (shared_client) |*c| {
        defer c.deinit();
        if (shared_secret_name.len > 0) {
            var arena = std.heap.ArenaAllocator.init(gpa.allocator());
            defer arena.deinit();
            _ = c.deleteSecret(arena.allocator(), .{
                .secret_id = shared_secret_name,
                .force_delete_without_recovery = true,
            }, .{}) catch |err| {
                std.log.warn(
                    "afterAll: failed to delete secret: {s}",
                    .{@errorName(err)},
                );
            };
        }
    }
    if (shared_cfg) |*cfg| cfg.deinit();
    try std.testing.expect(gpa.deinit() == .ok);
}

test "getSecretValue returns initial value" {
    const client =
        &(shared_client orelse return error.TestSetupFailed);
    var arena = std.heap.ArenaAllocator.init(std.testing.allocator);
    defer arena.deinit();

    const result = try client.getSecretValue(
        arena.allocator(),
        .{ .secret_id = shared_secret_name },
        .{},
    );

    try std.testing.expectEqualStrings(
        "initial-secret-value",
        result.secret_string orelse
            return error.MissingSecretString,
    );
}

test "describeSecret returns metadata" {
    const client =
        &(shared_client orelse return error.TestSetupFailed);
    var arena = std.heap.ArenaAllocator.init(std.testing.allocator);
    defer arena.deinit();

    const result = try client.describeSecret(
        arena.allocator(),
        .{ .secret_id = shared_secret_name },
        .{},
    );

    try std.testing.expectEqualStrings(
        shared_secret_name,
        result.name orelse return error.MissingName,
    );
    try std.testing.expect(result.arn != null);
}

test "listSecrets includes created secret" {
    const client =
        &(shared_client orelse return error.TestSetupFailed);
    var arena = std.heap.ArenaAllocator.init(std.testing.allocator);
    defer arena.deinit();

    var found = false;
    var retries: usize = 0;
    while (retries < 10 and !found) : (retries += 1) {
        const list_result = try client.listSecrets(
            arena.allocator(),
            .{
                .filters = &.{
                    .{
                        .key = .name,
                        .values = &.{shared_secret_name},
                    },
                },
            },
            .{},
        );

        const secret_list = list_result.secret_list orelse continue;
        for (secret_list) |entry| {
            if (entry.name) |name| {
                if (std.mem.eql(u8, name, shared_secret_name)) {
                    found = true;
                    break;
                }
            }
        }

        if (!found) {
            std.Thread.sleep(300 * std.time.ns_per_ms);
        }
    }

    try std.testing.expect(found);
}

test "putSecretValue updates the secret" {
    const client =
        &(shared_client orelse return error.TestSetupFailed);
    var arena = std.heap.ArenaAllocator.init(std.testing.allocator);
    defer arena.deinit();

    {
        var token_buf: [64]u8 = undefined;
        const put_token = try std.fmt.bufPrint(
            &token_buf,
            "{x}-{x}-{x}-{x}",
            .{
                std.crypto.random.int(u32),
                std.crypto.random.int(u32),
                std.crypto.random.int(u32),
                std.crypto.random.int(u32),
            },
        );
        const put = try client.putSecretValue(
            arena.allocator(),
            .{
                .secret_id = shared_secret_name,
                .secret_string = "updated-secret-value",
                .client_request_token = put_token,
            },
            .{},
        );
        try std.testing.expect(put.version_id != null);
    }

    {
        const result = try client.getSecretValue(
            arena.allocator(),
            .{ .secret_id = shared_secret_name },
            .{},
        );

        try std.testing.expectEqualStrings(
            "updated-secret-value",
            result.secret_string orelse
                return error.MissingSecretString,
        );
    }
}

test "listSecretVersionIds returns versions" {
    const client =
        &(shared_client orelse return error.TestSetupFailed);
    var arena = std.heap.ArenaAllocator.init(std.testing.allocator);
    defer arena.deinit();

    const result = try client.listSecretVersionIds(
        arena.allocator(),
        .{ .secret_id = shared_secret_name },
        .{},
    );

    const versions = result.versions orelse
        return error.MissingVersions;
    try std.testing.expect(versions.len >= 1);
}

test "tagResource adds a tag" {
    const client =
        &(shared_client orelse return error.TestSetupFailed);
    var arena = std.heap.ArenaAllocator.init(std.testing.allocator);
    defer arena.deinit();

    {
        _ = try client.tagResource(
            arena.allocator(),
            .{
                .secret_id = shared_secret_name,
                .tags = &.{
                    .{
                        .key = "test-tag",
                        .value = "live",
                    },
                },
            },
            .{},
        );
    }

    {
        const result = try client.describeSecret(
            arena.allocator(),
            .{ .secret_id = shared_secret_name },
            .{},
        );

        const tags = result.tags orelse
            return error.MissingTags;
        var found = false;
        for (tags) |tag| {
            const k = tag.key orelse continue;
            const v = tag.value orelse continue;
            if (std.mem.eql(u8, k, "test-tag") and
                std.mem.eql(u8, v, "live"))
            {
                found = true;
                break;
            }
        }
        try std.testing.expect(found);
    }
}
