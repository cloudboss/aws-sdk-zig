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

    // Use an arena for the client: generated deinit is shallow, so the arena
    // ensures all nested JSON-parsed allocations are freed in one shot.
    var arena_state = std.heap.ArenaAllocator.init(allocator);
    defer arena_state.deinit();
    const arena = arena_state.allocator();

    var client = dynamodb.Client.init(arena, &cfg);
    defer client.deinit();

    const table_name = "sdk-zig-integration-test-table";

    // --- CreateTable ---
    // Exercises: list-of-structs serialization, enum serialization
    const create_result = try dynamodb.create_table.execute(
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

    // Verify CreateTable response has table description with matching name
    const create_desc = create_result.table_description orelse
        return error.MissingTableDescription;
    try std.testing.expectEqualStrings(table_name, create_desc.table_name orelse
        return error.MissingTableName);

    // --- DescribeTable ---
    // Exercises: nested struct deserialization, list-of-structs deserialization
    const describe_result = try dynamodb.describe_table.execute(
        &client,
        .{ .table_name = table_name },
        .{},
    );

    const table = describe_result.table orelse
        return error.MissingTable;
    try std.testing.expectEqualStrings(table_name, table.table_name orelse
        return error.MissingTableName);
    try std.testing.expect(table.key_schema != null);
    try std.testing.expect(table.attribute_definitions != null);

    // --- ListTables ---
    // Exercises: list-of-strings deserialization
    const list_result = try dynamodb.list_tables.execute(
        &client,
        .{},
        .{},
    );

    const table_names = list_result.table_names orelse
        return error.MissingTableNames;

    var found = false;
    for (table_names) |name| {
        if (std.mem.eql(u8, name, table_name)) {
            found = true;
            break;
        }
    }
    try std.testing.expect(found);

    // --- DeleteTable ---
    const delete_result = try dynamodb.delete_table.execute(
        &client,
        .{ .table_name = table_name },
        .{},
    );

    // Verify DeleteTable returned a table description
    try std.testing.expect(delete_result.table_description != null);
}

test "PutItem and GetItem with map fields" {
    const allocator = std.testing.allocator;

    const endpoint_url = std.posix.getenv("AWS_ENDPOINT_URL") orelse
        return error.MissingEndpoint;

    var cfg = try aws.Config.load(allocator, .{
        .endpoint_url = endpoint_url,
    });
    defer cfg.deinit();

    var arena_state = std.heap.ArenaAllocator.init(allocator);
    defer arena_state.deinit();
    const arena = arena_state.allocator();

    var client = dynamodb.Client.init(arena, &cfg);
    defer client.deinit();

    const table_name = "sdk-zig-map-test-table";

    // Create table
    _ = try dynamodb.create_table.execute(
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

    // --- PutItem with map of AttributeValue ---
    // Exercises: map serialization (MapEntry), union serialization (AttributeValue)
    _ = try dynamodb.put_item.execute(
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

    // --- GetItem with map key ---
    // Exercises: map deserialization of response
    const get_result = try dynamodb.get_item.execute(
        &client,
        .{
            .table_name = table_name,
            .key = &.{
                .{ .key = "pk", .value = .{ .s = "test-key-1" } },
            },
        },
        .{},
    );

    const item = get_result.item orelse return error.MissingItem;

    // Verify returned map contains our fields
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

    // Cleanup
    _ = try dynamodb.delete_table.execute(
        &client,
        .{ .table_name = table_name },
        .{},
    );
}

test "DescribeTable returns ResourceNotFoundException for missing table" {
    const allocator = std.testing.allocator;

    const endpoint_url = std.posix.getenv("AWS_ENDPOINT_URL") orelse
        return error.MissingEndpoint;

    var cfg = try aws.Config.load(allocator, .{
        .endpoint_url = endpoint_url,
    });
    defer cfg.deinit();

    var client = dynamodb.Client.init(allocator, &cfg);
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
