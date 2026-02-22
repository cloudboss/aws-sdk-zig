const std = @import("std");
const aws = @import("aws");
const dynamodb = @import("dynamodb");

var gpa: std.heap.GeneralPurposeAllocator(.{}) = .init;
var shared_client: dynamodb.Client = undefined;
var shared_cfg: aws.Config = undefined;
var shared_init = false;

test "zest.beforeAll" {
    const allocator = gpa.allocator();
    shared_cfg = try aws.Config.load(allocator, .{});
    shared_client = dynamodb.Client.initWithOptions(
        allocator,
        &shared_cfg,
        .{ .keep_alive = false },
    );

    var r = try dynamodb.create_table.execute(&shared_client, .{
        .table_name = "sdk-zig-ddb-shared",
        .key_schema = &.{
            .{ .attribute_name = "pk", .key_type = .hash },
            .{ .attribute_name = "sk", .key_type = .range },
        },
        .attribute_definitions = &.{
            .{ .attribute_name = "pk", .attribute_type = .s },
            .{ .attribute_name = "sk", .attribute_type = .s },
        },
        .billing_mode = .pay_per_request,
    }, .{});
    defer r.deinit();
    shared_init = true;
}

test "zest.afterAll" {
    if (!shared_init) {
        _ = gpa.deinit();
        return;
    }
    {
        var r = try dynamodb.delete_table.execute(
            &shared_client,
            .{ .table_name = "sdk-zig-ddb-shared" },
            .{},
        );
        defer r.deinit();
    }
    shared_client.deinit();
    shared_cfg.deinit();
    try std.testing.expect(gpa.deinit() == .ok);
}

test "CreateTable returns table description with correct name" {
    const table_name = "sdk-zig-ddb-create-test";

    var result = try dynamodb.create_table.execute(&shared_client, .{
        .table_name = table_name,
        .key_schema = &.{
            .{ .attribute_name = "pk", .key_type = .hash },
        },
        .attribute_definitions = &.{
            .{ .attribute_name = "pk", .attribute_type = .s },
        },
        .billing_mode = .pay_per_request,
    }, .{});
    defer result.deinit();

    const desc = result.table_description orelse return error.MissingTableDescription;
    try std.testing.expectEqualStrings(
        table_name,
        desc.table_name orelse return error.MissingTableName,
    );

    var del = try dynamodb.delete_table.execute(
        &shared_client,
        .{ .table_name = table_name },
        .{},
    );
    defer del.deinit();
}

test "DescribeTable returns key schema with attribute definitions" {
    var result = try dynamodb.describe_table.execute(
        &shared_client,
        .{ .table_name = "sdk-zig-ddb-shared" },
        .{},
    );
    defer result.deinit();

    const table = result.table orelse return error.MissingTable;
    try std.testing.expectEqualStrings(
        "sdk-zig-ddb-shared",
        table.table_name orelse return error.MissingTableName,
    );
    try std.testing.expect(table.key_schema != null);
    try std.testing.expect(table.attribute_definitions != null);
}

test "ListTables includes created table" {
    var result = try dynamodb.list_tables.execute(
        &shared_client,
        .{},
        .{},
    );
    defer result.deinit();

    const table_names = result.table_names orelse return error.MissingTableNames;
    var found = false;
    for (table_names) |name| {
        if (std.mem.eql(u8, name, "sdk-zig-ddb-shared")) {
            found = true;
            break;
        }
    }
    try std.testing.expect(found);
}

test "DeleteTable returns table description" {
    const table_name = "sdk-zig-ddb-delete-test";

    {
        var r = try dynamodb.create_table.execute(&shared_client, .{
            .table_name = table_name,
            .key_schema = &.{
                .{ .attribute_name = "pk", .key_type = .hash },
            },
            .attribute_definitions = &.{
                .{ .attribute_name = "pk", .attribute_type = .s },
            },
            .billing_mode = .pay_per_request,
        }, .{});
        defer r.deinit();
    }

    var result = try dynamodb.delete_table.execute(
        &shared_client,
        .{ .table_name = table_name },
        .{},
    );
    defer result.deinit();

    try std.testing.expect(result.table_description != null);
}

test "PutItem stores item retrievable via GetItem" {
    const table_name = "sdk-zig-ddb-put-get";

    {
        var r = try dynamodb.create_table.execute(&shared_client, .{
            .table_name = table_name,
            .key_schema = &.{
                .{ .attribute_name = "pk", .key_type = .hash },
            },
            .attribute_definitions = &.{
                .{ .attribute_name = "pk", .attribute_type = .s },
            },
            .billing_mode = .pay_per_request,
        }, .{});
        defer r.deinit();
    }
    defer {
        var r = dynamodb.delete_table.execute(
            &shared_client,
            .{ .table_name = table_name },
            .{},
        ) catch unreachable;
        defer r.deinit();
    }

    {
        var r = try dynamodb.put_item.execute(&shared_client, .{
            .table_name = table_name,
            .item = &.{
                .{ .key = "pk", .value = .{ .s = "test-key-1" } },
                .{ .key = "name", .value = .{ .s = "Alice" } },
                .{ .key = "age", .value = .{ .n = "30" } },
            },
        }, .{});
        defer r.deinit();
    }

    var result = try dynamodb.get_item.execute(&shared_client, .{
        .table_name = table_name,
        .key = &.{
            .{ .key = "pk", .value = .{ .s = "test-key-1" } },
        },
    }, .{});
    defer result.deinit();

    const item = result.item orelse return error.MissingItem;
    var found_name = false;
    var found_age = false;
    for (item) |entry| {
        if (std.mem.eql(u8, entry.key, "name")) {
            switch (entry.value) {
                .s => |v| {
                    try std.testing.expectEqualStrings(
                        "Alice",
                        v orelse return error.MissingValue,
                    );
                    found_name = true;
                },
                else => return error.UnexpectedType,
            }
        } else if (std.mem.eql(u8, entry.key, "age")) {
            switch (entry.value) {
                .n => |v| {
                    try std.testing.expectEqualStrings(
                        "30",
                        v orelse return error.MissingValue,
                    );
                    found_age = true;
                },
                else => return error.UnexpectedType,
            }
        }
    }
    try std.testing.expect(found_name);
    try std.testing.expect(found_age);
}

test "Scan paginator collects all items across pages" {
    const table_name = "sdk-zig-ddb-paginator";

    {
        var r = try dynamodb.create_table.execute(&shared_client, .{
            .table_name = table_name,
            .key_schema = &.{
                .{ .attribute_name = "pk", .key_type = .hash },
            },
            .attribute_definitions = &.{
                .{ .attribute_name = "pk", .attribute_type = .s },
            },
            .billing_mode = .pay_per_request,
        }, .{});
        defer r.deinit();
    }
    defer {
        var r = dynamodb.delete_table.execute(
            &shared_client,
            .{ .table_name = table_name },
            .{},
        ) catch unreachable;
        defer r.deinit();
    }

    for (0..5) |i| {
        var key_buf: [16]u8 = undefined;
        const key = std.fmt.bufPrint(&key_buf, "item-{d}", .{i + 1}) catch
            unreachable;
        var r = try dynamodb.put_item.execute(&shared_client, .{
            .table_name = table_name,
            .item = &.{
                .{ .key = "pk", .value = .{ .s = key } },
            },
        }, .{});
        defer r.deinit();
    }

    var pag = shared_client.scanPaginator(
        .{ .table_name = table_name, .limit = 2 },
    );
    defer pag.deinit();

    var total_items: usize = 0;
    var pages: usize = 0;
    while (!pag.done) {
        const output = try pag.next(.{});
        if (output.items) |items| {
            total_items += items.len;
        }
        pages += 1;
    }

    try std.testing.expect(total_items == 5);
    try std.testing.expect(pages >= 3);
}

test "DescribeTable returns ResourceNotFoundException for missing table" {
    var diagnostic: dynamodb.ServiceError = undefined;
    const result = dynamodb.describe_table.execute(
        &shared_client,
        .{ .table_name = "nonexistent-table-12345" },
        .{ .diagnostic = &diagnostic },
    );

    try std.testing.expectError(error.ServiceError, result);
    defer diagnostic.deinit();

    switch (diagnostic.kind) {
        .resource_not_found_exception => |e| {
            try std.testing.expect(e.message.len > 0);
        },
        else => {
            std.debug.print(
                "Expected ResourceNotFoundException, got: {s}\n",
                .{diagnostic.code()},
            );
            return error.UnexpectedError;
        },
    }
}

test "Query returns items matching key condition" {
    const table_name = "sdk-zig-ddb-query";

    {
        var r = try dynamodb.create_table.execute(&shared_client, .{
            .table_name = table_name,
            .key_schema = &.{
                .{ .attribute_name = "pk", .key_type = .hash },
                .{ .attribute_name = "sk", .key_type = .range },
            },
            .attribute_definitions = &.{
                .{ .attribute_name = "pk", .attribute_type = .s },
                .{ .attribute_name = "sk", .attribute_type = .s },
            },
            .billing_mode = .pay_per_request,
        }, .{});
        defer r.deinit();
    }
    defer {
        var r = dynamodb.delete_table.execute(
            &shared_client,
            .{ .table_name = table_name },
            .{},
        ) catch unreachable;
        defer r.deinit();
    }

    for ([_][]const u8{ "sk-1", "sk-2", "sk-3" }) |sk| {
        var r = try dynamodb.put_item.execute(&shared_client, .{
            .table_name = table_name,
            .item = &.{
                .{ .key = "pk", .value = .{ .s = "partition-1" } },
                .{ .key = "sk", .value = .{ .s = sk } },
            },
        }, .{});
        defer r.deinit();
    }

    var result = try dynamodb.query.execute(&shared_client, .{
        .table_name = table_name,
        .key_condition_expression = "pk = :pk_val",
        .expression_attribute_values = &.{
            .{ .key = ":pk_val", .value = .{ .s = "partition-1" } },
        },
    }, .{});
    defer result.deinit();

    const count = result.count orelse return error.MissingCount;
    try std.testing.expectEqual(@as(i32, 3), count);
}

test "UpdateItem modifies existing item attribute" {
    const table_name = "sdk-zig-ddb-update";

    {
        var r = try dynamodb.create_table.execute(&shared_client, .{
            .table_name = table_name,
            .key_schema = &.{
                .{ .attribute_name = "pk", .key_type = .hash },
            },
            .attribute_definitions = &.{
                .{ .attribute_name = "pk", .attribute_type = .s },
            },
            .billing_mode = .pay_per_request,
        }, .{});
        defer r.deinit();
    }
    defer {
        var r = dynamodb.delete_table.execute(
            &shared_client,
            .{ .table_name = table_name },
            .{},
        ) catch unreachable;
        defer r.deinit();
    }

    {
        var r = try dynamodb.put_item.execute(&shared_client, .{
            .table_name = table_name,
            .item = &.{
                .{ .key = "pk", .value = .{ .s = "key-1" } },
                .{ .key = "name", .value = .{ .s = "Alice" } },
            },
        }, .{});
        defer r.deinit();
    }

    {
        var r = try dynamodb.update_item.execute(&shared_client, .{
            .table_name = table_name,
            .key = &.{
                .{ .key = "pk", .value = .{ .s = "key-1" } },
            },
            .update_expression = "SET #n = :val",
            .expression_attribute_names = &.{
                .{ .key = "#n", .value = "name" },
            },
            .expression_attribute_values = &.{
                .{ .key = ":val", .value = .{ .s = "Bob" } },
            },
        }, .{});
        defer r.deinit();
    }

    var result = try dynamodb.get_item.execute(&shared_client, .{
        .table_name = table_name,
        .key = &.{
            .{ .key = "pk", .value = .{ .s = "key-1" } },
        },
    }, .{});
    defer result.deinit();

    const item = result.item orelse return error.MissingItem;
    var found_name = false;
    for (item) |entry| {
        if (std.mem.eql(u8, entry.key, "name")) {
            switch (entry.value) {
                .s => |v| {
                    try std.testing.expectEqualStrings(
                        "Bob",
                        v orelse return error.MissingValue,
                    );
                    found_name = true;
                },
                else => return error.UnexpectedType,
            }
        }
    }
    try std.testing.expect(found_name);
}

test "BatchWriteItem writes multiple items" {
    const table_name = "sdk-zig-ddb-batch";

    {
        var r = try dynamodb.create_table.execute(&shared_client, .{
            .table_name = table_name,
            .key_schema = &.{
                .{ .attribute_name = "pk", .key_type = .hash },
            },
            .attribute_definitions = &.{
                .{ .attribute_name = "pk", .attribute_type = .s },
            },
            .billing_mode = .pay_per_request,
        }, .{});
        defer r.deinit();
    }
    defer {
        var r = dynamodb.delete_table.execute(
            &shared_client,
            .{ .table_name = table_name },
            .{},
        ) catch unreachable;
        defer r.deinit();
    }

    {
        var r = try dynamodb.batch_write_item.execute(&shared_client, .{
            .request_items = &.{
                .{
                    .key = table_name,
                    .value = &.{
                        .{
                            .delete_request = null,
                            .put_request = .{ .item = &.{
                                .{ .key = "pk", .value = .{ .s = "batch-1" } },
                            } },
                        },
                        .{
                            .delete_request = null,
                            .put_request = .{ .item = &.{
                                .{ .key = "pk", .value = .{ .s = "batch-2" } },
                            } },
                        },
                        .{
                            .delete_request = null,
                            .put_request = .{ .item = &.{
                                .{ .key = "pk", .value = .{ .s = "batch-3" } },
                            } },
                        },
                    },
                },
            },
        }, .{});
        defer r.deinit();
    }

    var result = try dynamodb.scan.execute(
        &shared_client,
        .{ .table_name = table_name },
        .{},
    );
    defer result.deinit();

    const count = result.count orelse return error.MissingCount;
    try std.testing.expectEqual(@as(i32, 3), count);
}

test "DeleteItem removes item from table" {
    {
        var r = try dynamodb.put_item.execute(&shared_client, .{
            .table_name = "sdk-zig-ddb-shared",
            .item = &.{
                .{ .key = "pk", .value = .{ .s = "del-test" } },
                .{ .key = "sk", .value = .{ .s = "1" } },
            },
        }, .{});
        defer r.deinit();
    }

    {
        var r = try dynamodb.delete_item.execute(&shared_client, .{
            .table_name = "sdk-zig-ddb-shared",
            .key = &.{
                .{ .key = "pk", .value = .{ .s = "del-test" } },
                .{ .key = "sk", .value = .{ .s = "1" } },
            },
        }, .{});
        defer r.deinit();
    }

    var result = try dynamodb.get_item.execute(&shared_client, .{
        .table_name = "sdk-zig-ddb-shared",
        .key = &.{
            .{ .key = "pk", .value = .{ .s = "del-test" } },
            .{ .key = "sk", .value = .{ .s = "1" } },
        },
    }, .{});
    defer result.deinit();

    try std.testing.expect(result.item == null);
}

test "GetItem returns null for nonexistent key" {
    var result = try dynamodb.get_item.execute(&shared_client, .{
        .table_name = "sdk-zig-ddb-shared",
        .key = &.{
            .{ .key = "pk", .value = .{ .s = "nonexistent" } },
            .{ .key = "sk", .value = .{ .s = "0" } },
        },
    }, .{});
    defer result.deinit();

    try std.testing.expect(result.item == null);
}

test "PutItem with conditional expression succeeds" {
    {
        var r = try dynamodb.put_item.execute(&shared_client, .{
            .table_name = "sdk-zig-ddb-shared",
            .item = &.{
                .{ .key = "pk", .value = .{ .s = "cond-ok" } },
                .{ .key = "sk", .value = .{ .s = "1" } },
            },
            .condition_expression = "attribute_not_exists(pk)",
        }, .{});
        defer r.deinit();
    }

    var result = try dynamodb.get_item.execute(&shared_client, .{
        .table_name = "sdk-zig-ddb-shared",
        .key = &.{
            .{ .key = "pk", .value = .{ .s = "cond-ok" } },
            .{ .key = "sk", .value = .{ .s = "1" } },
        },
    }, .{});
    defer result.deinit();

    try std.testing.expect(result.item != null);
}

test "PutItem with failing condition returns ConditionalCheckFailedException" {
    {
        var r = try dynamodb.put_item.execute(&shared_client, .{
            .table_name = "sdk-zig-ddb-shared",
            .item = &.{
                .{ .key = "pk", .value = .{ .s = "cond-fail" } },
                .{ .key = "sk", .value = .{ .s = "1" } },
            },
        }, .{});
        defer r.deinit();
    }

    var diagnostic: dynamodb.ServiceError = undefined;
    const result = dynamodb.put_item.execute(&shared_client, .{
        .table_name = "sdk-zig-ddb-shared",
        .item = &.{
            .{ .key = "pk", .value = .{ .s = "cond-fail" } },
            .{ .key = "sk", .value = .{ .s = "1" } },
        },
        .condition_expression = "attribute_not_exists(pk)",
    }, .{ .diagnostic = &diagnostic });

    try std.testing.expectError(error.ServiceError, result);
    defer diagnostic.deinit();

    switch (diagnostic.kind) {
        .conditional_check_failed_exception => |e| {
            try std.testing.expect(e.message.len > 0);
        },
        else => {
            std.debug.print(
                "Expected ConditionalCheckFailedException, got: {s}\n",
                .{diagnostic.code()},
            );
            return error.UnexpectedError;
        },
    }
}

test "Scan returns all items without filter" {
    const table_name = "sdk-zig-ddb-scan-all";

    {
        var r = try dynamodb.create_table.execute(&shared_client, .{
            .table_name = table_name,
            .key_schema = &.{
                .{ .attribute_name = "pk", .key_type = .hash },
            },
            .attribute_definitions = &.{
                .{ .attribute_name = "pk", .attribute_type = .s },
            },
            .billing_mode = .pay_per_request,
        }, .{});
        defer r.deinit();
    }
    defer {
        var r = dynamodb.delete_table.execute(
            &shared_client,
            .{ .table_name = table_name },
            .{},
        ) catch unreachable;
        defer r.deinit();
    }

    for ([_][]const u8{ "a", "b", "c" }) |pk| {
        var r = try dynamodb.put_item.execute(&shared_client, .{
            .table_name = table_name,
            .item = &.{
                .{ .key = "pk", .value = .{ .s = pk } },
            },
        }, .{});
        defer r.deinit();
    }

    var result = try dynamodb.scan.execute(
        &shared_client,
        .{ .table_name = table_name },
        .{},
    );
    defer result.deinit();

    const count = result.count orelse return error.MissingCount;
    try std.testing.expectEqual(@as(i32, 3), count);
}

test "Query with sort key begins_with returns filtered results" {
    const table_name = "sdk-zig-ddb-query-bw";

    {
        var r = try dynamodb.create_table.execute(&shared_client, .{
            .table_name = table_name,
            .key_schema = &.{
                .{ .attribute_name = "pk", .key_type = .hash },
                .{ .attribute_name = "sk", .key_type = .range },
            },
            .attribute_definitions = &.{
                .{ .attribute_name = "pk", .attribute_type = .s },
                .{ .attribute_name = "sk", .attribute_type = .s },
            },
            .billing_mode = .pay_per_request,
        }, .{});
        defer r.deinit();
    }
    defer {
        var r = dynamodb.delete_table.execute(
            &shared_client,
            .{ .table_name = table_name },
            .{},
        ) catch unreachable;
        defer r.deinit();
    }

    for ([_][]const u8{ "a-1", "a-2", "b-1" }) |sk| {
        var r = try dynamodb.put_item.execute(&shared_client, .{
            .table_name = table_name,
            .item = &.{
                .{ .key = "pk", .value = .{ .s = "p1" } },
                .{ .key = "sk", .value = .{ .s = sk } },
            },
        }, .{});
        defer r.deinit();
    }

    var result = try dynamodb.query.execute(&shared_client, .{
        .table_name = table_name,
        .key_condition_expression = "pk = :pk_val AND begins_with(sk, :sk_prefix)",
        .expression_attribute_values = &.{
            .{ .key = ":pk_val", .value = .{ .s = "p1" } },
            .{ .key = ":sk_prefix", .value = .{ .s = "a-" } },
        },
    }, .{});
    defer result.deinit();

    const count = result.count orelse return error.MissingCount;
    try std.testing.expectEqual(@as(i32, 2), count);
}

test "BatchGetItem retrieves multiple items" {
    {
        var r = try dynamodb.put_item.execute(&shared_client, .{
            .table_name = "sdk-zig-ddb-shared",
            .item = &.{
                .{ .key = "pk", .value = .{ .s = "bg-1" } },
                .{ .key = "sk", .value = .{ .s = "1" } },
            },
        }, .{});
        defer r.deinit();
    }
    {
        var r = try dynamodb.put_item.execute(&shared_client, .{
            .table_name = "sdk-zig-ddb-shared",
            .item = &.{
                .{ .key = "pk", .value = .{ .s = "bg-2" } },
                .{ .key = "sk", .value = .{ .s = "1" } },
            },
        }, .{});
        defer r.deinit();
    }

    var result = try dynamodb.batch_get_item.execute(&shared_client, .{
        .request_items = &.{
            .{
                .key = "sdk-zig-ddb-shared",
                .value = .{
                    .attributes_to_get = null,
                    .consistent_read = null,
                    .expression_attribute_names = null,
                    .projection_expression = null,
                    .keys = &.{
                        &.{
                            .{ .key = "pk", .value = .{ .s = "bg-1" } },
                            .{ .key = "sk", .value = .{ .s = "1" } },
                        },
                        &.{
                            .{ .key = "pk", .value = .{ .s = "bg-2" } },
                            .{ .key = "sk", .value = .{ .s = "1" } },
                        },
                    },
                },
            },
        },
    }, .{});
    defer result.deinit();

    const responses = result.responses orelse return error.MissingResponses;
    var total: usize = 0;
    for (responses) |entry| {
        total += entry.value.len;
    }
    try std.testing.expectEqual(@as(usize, 2), total);
}

test "UpdateItem with ADD increments number attribute" {
    {
        var r = try dynamodb.put_item.execute(&shared_client, .{
            .table_name = "sdk-zig-ddb-shared",
            .item = &.{
                .{ .key = "pk", .value = .{ .s = "add-test" } },
                .{ .key = "sk", .value = .{ .s = "1" } },
                .{ .key = "count", .value = .{ .n = "5" } },
            },
        }, .{});
        defer r.deinit();
    }

    {
        var r = try dynamodb.update_item.execute(&shared_client, .{
            .table_name = "sdk-zig-ddb-shared",
            .key = &.{
                .{ .key = "pk", .value = .{ .s = "add-test" } },
                .{ .key = "sk", .value = .{ .s = "1" } },
            },
            .update_expression = "ADD #c :inc",
            .expression_attribute_names = &.{
                .{ .key = "#c", .value = "count" },
            },
            .expression_attribute_values = &.{
                .{ .key = ":inc", .value = .{ .n = "1" } },
            },
        }, .{});
        defer r.deinit();
    }

    var result = try dynamodb.get_item.execute(&shared_client, .{
        .table_name = "sdk-zig-ddb-shared",
        .key = &.{
            .{ .key = "pk", .value = .{ .s = "add-test" } },
            .{ .key = "sk", .value = .{ .s = "1" } },
        },
    }, .{});
    defer result.deinit();

    const item = result.item orelse return error.MissingItem;
    var found_count = false;
    for (item) |entry| {
        if (std.mem.eql(u8, entry.key, "count")) {
            switch (entry.value) {
                .n => |v| {
                    try std.testing.expectEqualStrings(
                        "6",
                        v orelse return error.MissingValue,
                    );
                    found_count = true;
                },
                else => return error.UnexpectedType,
            }
        }
    }
    try std.testing.expect(found_count);
}
