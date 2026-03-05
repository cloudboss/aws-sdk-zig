const std = @import("std");
const aws = @import("aws");
const dynamodb = @import("dynamodb");

var gpa: std.heap.GeneralPurposeAllocator(.{}) = .init;
var shared_client: dynamodb.Client = undefined;
var shared_cfg: aws.Config = undefined;
var shared_init = false;
var shared_table_name_buf: [64]u8 = undefined;
var shared_table: []const u8 = "";

test "zest.beforeAll" {
    const allocator = gpa.allocator();
    shared_cfg = try aws.Config.load(allocator, .{});
    shared_client = dynamodb.Client.initWithOptions(
        allocator,
        &shared_cfg,
        .{ .keep_alive = false },
    );

    var arena = std.heap.ArenaAllocator.init(allocator);
    defer arena.deinit();

    shared_table = try std.fmt.bufPrint(
        &shared_table_name_buf,
        "sdk-zig-live-ddb-{d}",
        .{std.time.timestamp()},
    );

    const create_result = try shared_client.createTable(
        arena.allocator(),
        .{
            .table_name = shared_table,
            .key_schema = &.{
                .{
                    .attribute_name = "pk",
                    .key_type = .hash,
                },
            },
            .attribute_definitions = &.{
                .{
                    .attribute_name = "pk",
                    .attribute_type = .s,
                },
            },
            .billing_mode = .pay_per_request,
        },
        .{},
    );

    const desc = create_result.table_description orelse
        return error.MissingTableDescription;
    const table_arn = desc.table_arn orelse
        return error.MissingTableArn;

    _ = try shared_client.tagResource(
        arena.allocator(),
        .{
            .resource_arn = table_arn,
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
        .{},
    );

    shared_init = true;
}

test "zest.afterAll" {
    if (!shared_init) {
        _ = gpa.deinit();
        return;
    }
    {
        var arena = std.heap.ArenaAllocator.init(gpa.allocator());
        defer arena.deinit();
        _ = shared_client.deleteTable(
            arena.allocator(),
            .{ .table_name = shared_table },
            .{},
        ) catch {};
    }
    shared_client.deinit();
    shared_cfg.deinit();
    try std.testing.expect(gpa.deinit() == .ok);
}

test "describeTable returns table metadata" {
    var arena = std.heap.ArenaAllocator.init(gpa.allocator());
    defer arena.deinit();

    const result = try shared_client.describeTable(
        arena.allocator(),
        .{ .table_name = shared_table },
        .{},
    );

    const table = result.table orelse
        return error.MissingTable;
    try std.testing.expectEqualStrings(
        shared_table,
        table.table_name orelse
            return error.MissingTableName,
    );
}

test "listTables includes created table" {
    var arena = std.heap.ArenaAllocator.init(gpa.allocator());
    defer arena.deinit();

    const result = try shared_client.listTables(
        arena.allocator(),
        .{},
        .{},
    );

    const table_names = result.table_names orelse
        return error.MissingTableNames;
    var found = false;
    for (table_names) |name| {
        if (std.mem.eql(u8, name, shared_table)) {
            found = true;
            break;
        }
    }
    try std.testing.expect(found);
}

test "putItem stores an item" {
    var arena = std.heap.ArenaAllocator.init(gpa.allocator());
    defer arena.deinit();

    _ = try shared_client.putItem(arena.allocator(), .{
        .table_name = shared_table,
        .item = &.{
            .{ .key = "pk", .value = .{ .s = "test-pk-1" } },
            .{ .key = "data", .value = .{ .s = "hello" } },
        },
    }, .{});
}

test "getItem retrieves the stored item" {
    var arena = std.heap.ArenaAllocator.init(gpa.allocator());
    defer arena.deinit();

    const result = try shared_client.getItem(
        arena.allocator(),
        .{
            .table_name = shared_table,
            .key = &.{
                .{
                    .key = "pk",
                    .value = .{ .s = "test-pk-1" },
                },
            },
        },
        .{},
    );

    const item = result.item orelse
        return error.MissingItem;
    var found_data = false;
    for (item) |entry| {
        if (std.mem.eql(u8, entry.key, "data")) {
            switch (entry.value) {
                .s => |v| {
                    try std.testing.expectEqualStrings(
                        "hello",
                        v orelse
                            return error.MissingValue,
                    );
                    found_data = true;
                },
                else => return error.UnexpectedType,
            }
        }
    }
    try std.testing.expect(found_data);
}

test "updateItem modifies an attribute" {
    var arena = std.heap.ArenaAllocator.init(gpa.allocator());
    defer arena.deinit();

    _ = try shared_client.updateItem(arena.allocator(), .{
        .table_name = shared_table,
        .key = &.{
            .{
                .key = "pk",
                .value = .{ .s = "test-pk-1" },
            },
        },
        .update_expression = "SET #d = :val",
        .expression_attribute_names = &.{
            .{ .key = "#d", .value = "data" },
        },
        .expression_attribute_values = &.{
            .{ .key = ":val", .value = .{ .s = "updated" } },
        },
    }, .{});

    const result = try shared_client.getItem(
        arena.allocator(),
        .{
            .table_name = shared_table,
            .key = &.{
                .{
                    .key = "pk",
                    .value = .{ .s = "test-pk-1" },
                },
            },
        },
        .{},
    );

    const item = result.item orelse
        return error.MissingItem;
    var found_data = false;
    for (item) |entry| {
        if (std.mem.eql(u8, entry.key, "data")) {
            switch (entry.value) {
                .s => |v| {
                    try std.testing.expectEqualStrings(
                        "updated",
                        v orelse
                            return error.MissingValue,
                    );
                    found_data = true;
                },
                else => return error.UnexpectedType,
            }
        }
    }
    try std.testing.expect(found_data);
}

test "deleteItem removes an item" {
    var arena = std.heap.ArenaAllocator.init(gpa.allocator());
    defer arena.deinit();

    _ = try shared_client.putItem(arena.allocator(), .{
        .table_name = shared_table,
        .item = &.{
            .{
                .key = "pk",
                .value = .{ .s = "del-test" },
            },
            .{
                .key = "data",
                .value = .{ .s = "to-delete" },
            },
        },
    }, .{});

    _ = try shared_client.deleteItem(arena.allocator(), .{
        .table_name = shared_table,
        .key = &.{
            .{
                .key = "pk",
                .value = .{ .s = "del-test" },
            },
        },
    }, .{});

    const result = try shared_client.getItem(
        arena.allocator(),
        .{
            .table_name = shared_table,
            .key = &.{
                .{
                    .key = "pk",
                    .value = .{ .s = "del-test" },
                },
            },
        },
        .{},
    );

    try std.testing.expect(result.item == null);
}

test "scan returns items" {
    var arena = std.heap.ArenaAllocator.init(gpa.allocator());
    defer arena.deinit();

    _ = try shared_client.putItem(arena.allocator(), .{
        .table_name = shared_table,
        .item = &.{
            .{
                .key = "pk",
                .value = .{ .s = "scan-item-1" },
            },
        },
    }, .{});
    _ = try shared_client.putItem(arena.allocator(), .{
        .table_name = shared_table,
        .item = &.{
            .{
                .key = "pk",
                .value = .{ .s = "scan-item-2" },
            },
        },
    }, .{});

    const result = try shared_client.scan(
        arena.allocator(),
        .{ .table_name = shared_table },
        .{},
    );

    try std.testing.expect(result.count >= 2);
}

test "batchWriteItem puts multiple items" {
    var arena = std.heap.ArenaAllocator.init(gpa.allocator());
    defer arena.deinit();

    _ = try shared_client.batchWriteItem(
        arena.allocator(),
        .{
            .request_items = &.{
                .{
                    .key = shared_table,
                    .value = &.{
                        .{
                            .delete_request = null,
                            .put_request = .{
                                .item = &.{
                                    .{
                                        .key = "pk",
                                        .value = .{
                                            .s = "batch-1",
                                        },
                                    },
                                },
                            },
                        },
                        .{
                            .delete_request = null,
                            .put_request = .{
                                .item = &.{
                                    .{
                                        .key = "pk",
                                        .value = .{
                                            .s = "batch-2",
                                        },
                                    },
                                },
                            },
                        },
                        .{
                            .delete_request = null,
                            .put_request = .{
                                .item = &.{
                                    .{
                                        .key = "pk",
                                        .value = .{
                                            .s = "batch-3",
                                        },
                                    },
                                },
                            },
                        },
                    },
                },
            },
        },
        .{},
    );

    const result = try shared_client.scan(
        arena.allocator(),
        .{
            .table_name = shared_table,
            .filter_expression = "begins_with(pk, :p)",
            .expression_attribute_values = &.{
                .{
                    .key = ":p",
                    .value = .{ .s = "batch-" },
                },
            },
        },
        .{},
    );

    try std.testing.expectEqual(@as(i32, 3), result.count);
}
