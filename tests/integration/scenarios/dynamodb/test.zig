const std = @import("std");
const aws = @import("aws");
const dynamodb = @import("dynamodb");

test "CreateTable, DescribeTable, ListTables, DeleteTable" {
    const allocator = std.testing.allocator;

    const endpoint_url = std.posix.getenv("AWS_ENDPOINT_URL") orelse
        return error.MissingEndpoint;

    var cfg = try aws.Config.load(allocator, .{
        .endpoint_url = endpoint_url,
    });
    defer cfg.deinit();

    var client = dynamodb.Client.initWithOptions(allocator, &cfg, .{ .keep_alive = false });
    defer client.deinit();

    const table_name = "sdk-zig-integration-test-table";

    // --- CreateTable ---
    {
        var result = try dynamodb.create_table.execute(
            &client,
            .{
                .table_name = table_name,
                .key_schema = &.{
                    .{ .attribute_name = "pk", .key_type = .hash },
                },
                .attribute_definitions = &.{
                    .{ .attribute_name = "pk", .attribute_type = .s },
                },
                .billing_mode = .pay_per_request,
            },
            .{},
        );
        defer result.deinit();

        const create_desc = result.table_description orelse
            return error.MissingTableDescription;
        try std.testing.expectEqualStrings(table_name, create_desc.table_name orelse
            return error.MissingTableName);
    }

    // --- DescribeTable ---
    {
        var result = try dynamodb.describe_table.execute(
            &client,
            .{ .table_name = table_name },
            .{},
        );
        defer result.deinit();

        const table = result.table orelse
            return error.MissingTable;
        try std.testing.expectEqualStrings(table_name, table.table_name orelse
            return error.MissingTableName);
        try std.testing.expect(table.key_schema != null);
        try std.testing.expect(table.attribute_definitions != null);
    }

    // --- ListTables ---
    {
        var result = try dynamodb.list_tables.execute(
            &client,
            .{},
            .{},
        );
        defer result.deinit();

        const table_names = result.table_names orelse
            return error.MissingTableNames;

        var found = false;
        for (table_names) |name| {
            if (std.mem.eql(u8, name, table_name)) {
                found = true;
                break;
            }
        }
        try std.testing.expect(found);
    }

    // --- DeleteTable ---
    {
        var result = try dynamodb.delete_table.execute(
            &client,
            .{ .table_name = table_name },
            .{},
        );
        defer result.deinit();

        try std.testing.expect(result.table_description != null);
    }
}

test "PutItem and GetItem with map fields" {
    const allocator = std.testing.allocator;

    const endpoint_url = std.posix.getenv("AWS_ENDPOINT_URL") orelse
        return error.MissingEndpoint;

    var cfg = try aws.Config.load(allocator, .{
        .endpoint_url = endpoint_url,
    });
    defer cfg.deinit();

    var client = dynamodb.Client.initWithOptions(allocator, &cfg, .{ .keep_alive = false });
    defer client.deinit();

    const table_name = "sdk-zig-map-test-table";

    // Create table
    {
        var result = try dynamodb.create_table.execute(
            &client,
            .{
                .table_name = table_name,
                .key_schema = &.{
                    .{ .attribute_name = "pk", .key_type = .hash },
                },
                .attribute_definitions = &.{
                    .{ .attribute_name = "pk", .attribute_type = .s },
                },
                .billing_mode = .pay_per_request,
            },
            .{},
        );
        defer result.deinit();
    }

    // --- PutItem with map of AttributeValue ---
    {
        var result = try dynamodb.put_item.execute(
            &client,
            .{
                .table_name = table_name,
                .item = &.{
                    .{ .key = "pk", .value = .{ .s = "test-key-1" } },
                    .{ .key = "name", .value = .{ .s = "Alice" } },
                    .{ .key = "age", .value = .{ .n = "30" } },
                },
            },
            .{},
        );
        defer result.deinit();
    }

    // --- GetItem with map key ---
    {
        var result = try dynamodb.get_item.execute(
            &client,
            .{
                .table_name = table_name,
                .key = &.{
                    .{ .key = "pk", .value = .{ .s = "test-key-1" } },
                },
            },
            .{},
        );
        defer result.deinit();

        const item = result.item orelse return error.MissingItem;

        var found_name = false;
        var found_age = false;
        for (item) |entry| {
            if (std.mem.eql(u8, entry.key, "name")) {
                switch (entry.value) {
                    .s => |v| {
                        try std.testing.expectEqualStrings("Alice", v orelse return error.MissingValue);
                        found_name = true;
                    },
                    else => return error.UnexpectedType,
                }
            } else if (std.mem.eql(u8, entry.key, "age")) {
                switch (entry.value) {
                    .n => |v| {
                        try std.testing.expectEqualStrings("30", v orelse return error.MissingValue);
                        found_age = true;
                    },
                    else => return error.UnexpectedType,
                }
            }
        }
        try std.testing.expect(found_name);
        try std.testing.expect(found_age);
    }

    // Cleanup
    {
        var result = try dynamodb.delete_table.execute(
            &client,
            .{ .table_name = table_name },
            .{},
        );
        defer result.deinit();
    }
}

test "Scan paginator collects all items across pages" {
    const allocator = std.testing.allocator;

    const endpoint_url = std.posix.getenv("AWS_ENDPOINT_URL") orelse
        return error.MissingEndpoint;

    var cfg = try aws.Config.load(allocator, .{
        .endpoint_url = endpoint_url,
    });
    defer cfg.deinit();

    var client = dynamodb.Client.initWithOptions(allocator, &cfg, .{ .keep_alive = false });
    defer client.deinit();

    const table_name = "sdk-zig-paginator-test-table";

    // Create table
    {
        var result = try dynamodb.create_table.execute(
            &client,
            .{
                .table_name = table_name,
                .key_schema = &.{
                    .{ .attribute_name = "pk", .key_type = .hash },
                },
                .attribute_definitions = &.{
                    .{ .attribute_name = "pk", .attribute_type = .s },
                },
                .billing_mode = .pay_per_request,
            },
            .{},
        );
        defer result.deinit();
    }

    // Put 5 items
    for (0..5) |i| {
        var key_buf: [16]u8 = undefined;
        const key = std.fmt.bufPrint(&key_buf, "item-{d}", .{i + 1}) catch unreachable;
        var result = try dynamodb.put_item.execute(
            &client,
            .{
                .table_name = table_name,
                .item = &.{
                    .{ .key = "pk", .value = .{ .s = key } },
                },
            },
            .{},
        );
        defer result.deinit();
    }

    // Scan with limit=2 via paginator
    var pag = client.scanPaginator(.{ .table_name = table_name, .limit = 2 });
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

    // Cleanup
    {
        var result = try dynamodb.delete_table.execute(
            &client,
            .{ .table_name = table_name },
            .{},
        );
        defer result.deinit();
    }
}

test "DescribeTable returns ResourceNotFoundException for missing table" {
    const allocator = std.testing.allocator;

    const endpoint_url = std.posix.getenv("AWS_ENDPOINT_URL") orelse
        return error.MissingEndpoint;

    var cfg = try aws.Config.load(allocator, .{
        .endpoint_url = endpoint_url,
    });
    defer cfg.deinit();

    var client = dynamodb.Client.initWithOptions(allocator, &cfg, .{ .keep_alive = false });
    defer client.deinit();

    var diagnostic: dynamodb.ServiceError = undefined;
    const result = dynamodb.describe_table.execute(
        &client,
        .{ .table_name = "nonexistent-table-12345" },
        .{ .diagnostic = &diagnostic },
    );

    // Should fail with ServiceError
    try std.testing.expectError(error.ServiceError, result);

    // Verify the error was parsed from __type as ResourceNotFoundException
    switch (diagnostic) {
        .resource_not_found_exception => |e| {
            try std.testing.expect(e.message.len > 0);
        },
        else => {
            std.debug.print("Expected ResourceNotFoundException, got: {s}\n", .{diagnostic.code()});
            return error.UnexpectedError;
        },
    }
}

test "Query returns items matching key condition" {
    const allocator = std.testing.allocator;

    const endpoint_url = std.posix.getenv("AWS_ENDPOINT_URL") orelse
        return error.MissingEndpoint;

    var cfg = try aws.Config.load(allocator, .{
        .endpoint_url = endpoint_url,
    });
    defer cfg.deinit();

    var client = dynamodb.Client.initWithOptions(
        allocator,
        &cfg,
        .{ .keep_alive = false },
    );
    defer client.deinit();

    const table_name = "sdk-zig-ddb-query";

    // Create table with composite key (pk + sk)
    {
        var result = try dynamodb.create_table.execute(
            &client,
            .{
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
            },
            .{},
        );
        defer result.deinit();
    }

    // PutItem 3 items with same pk, different sk
    for ([_][]const u8{ "sk-1", "sk-2", "sk-3" }) |sk| {
        var result = try dynamodb.put_item.execute(
            &client,
            .{
                .table_name = table_name,
                .item = &.{
                    .{ .key = "pk", .value = .{ .s = "partition-1" } },
                    .{ .key = "sk", .value = .{ .s = sk } },
                },
            },
            .{},
        );
        defer result.deinit();
    }

    // Query by partition key
    {
        var result = try dynamodb.query.execute(
            &client,
            .{
                .table_name = table_name,
                .key_condition_expression = "pk = :pk_val",
                .expression_attribute_values = &.{
                    .{
                        .key = ":pk_val",
                        .value = .{ .s = "partition-1" },
                    },
                },
            },
            .{},
        );
        defer result.deinit();

        const count = result.count orelse return error.MissingCount;
        try std.testing.expectEqual(@as(i32, 3), count);
    }

    // Cleanup
    {
        var result = try dynamodb.delete_table.execute(
            &client,
            .{ .table_name = table_name },
            .{},
        );
        defer result.deinit();
    }
}

test "UpdateItem modifies existing item attribute" {
    const allocator = std.testing.allocator;

    const endpoint_url = std.posix.getenv("AWS_ENDPOINT_URL") orelse
        return error.MissingEndpoint;

    var cfg = try aws.Config.load(allocator, .{
        .endpoint_url = endpoint_url,
    });
    defer cfg.deinit();

    var client = dynamodb.Client.initWithOptions(
        allocator,
        &cfg,
        .{ .keep_alive = false },
    );
    defer client.deinit();

    const table_name = "sdk-zig-ddb-update";

    // Create table
    {
        var result = try dynamodb.create_table.execute(
            &client,
            .{
                .table_name = table_name,
                .key_schema = &.{
                    .{ .attribute_name = "pk", .key_type = .hash },
                },
                .attribute_definitions = &.{
                    .{ .attribute_name = "pk", .attribute_type = .s },
                },
                .billing_mode = .pay_per_request,
            },
            .{},
        );
        defer result.deinit();
    }

    // PutItem with initial name
    {
        var result = try dynamodb.put_item.execute(
            &client,
            .{
                .table_name = table_name,
                .item = &.{
                    .{ .key = "pk", .value = .{ .s = "key-1" } },
                    .{ .key = "name", .value = .{ .s = "Alice" } },
                },
            },
            .{},
        );
        defer result.deinit();
    }

    // UpdateItem: change name from Alice to Bob
    {
        var result = try dynamodb.update_item.execute(
            &client,
            .{
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
            },
            .{},
        );
        defer result.deinit();
    }

    // GetItem and verify updated value
    {
        var result = try dynamodb.get_item.execute(
            &client,
            .{
                .table_name = table_name,
                .key = &.{
                    .{ .key = "pk", .value = .{ .s = "key-1" } },
                },
            },
            .{},
        );
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

    // Cleanup
    {
        var result = try dynamodb.delete_table.execute(
            &client,
            .{ .table_name = table_name },
            .{},
        );
        defer result.deinit();
    }
}

test "BatchWriteItem writes multiple items" {
    const allocator = std.testing.allocator;

    const endpoint_url = std.posix.getenv("AWS_ENDPOINT_URL") orelse
        return error.MissingEndpoint;

    var cfg = try aws.Config.load(allocator, .{
        .endpoint_url = endpoint_url,
    });
    defer cfg.deinit();

    var client = dynamodb.Client.initWithOptions(
        allocator,
        &cfg,
        .{ .keep_alive = false },
    );
    defer client.deinit();

    const table_name = "sdk-zig-ddb-batch";

    // Create table
    {
        var result = try dynamodb.create_table.execute(
            &client,
            .{
                .table_name = table_name,
                .key_schema = &.{
                    .{ .attribute_name = "pk", .key_type = .hash },
                },
                .attribute_definitions = &.{
                    .{ .attribute_name = "pk", .attribute_type = .s },
                },
                .billing_mode = .pay_per_request,
            },
            .{},
        );
        defer result.deinit();
    }

    // BatchWriteItem: put 3 items at once
    {
        var result = try dynamodb.batch_write_item.execute(
            &client,
            .{
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
            },
            .{},
        );
        defer result.deinit();
    }

    // Scan to verify all 3 items exist
    {
        var result = try dynamodb.scan.execute(
            &client,
            .{ .table_name = table_name },
            .{},
        );
        defer result.deinit();

        const count = result.count orelse return error.MissingCount;
        try std.testing.expectEqual(@as(i32, 3), count);
    }

    // Cleanup
    {
        var result = try dynamodb.delete_table.execute(
            &client,
            .{ .table_name = table_name },
            .{},
        );
        defer result.deinit();
    }
}
