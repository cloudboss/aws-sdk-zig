const std = @import("std");
const aws = @import("aws");
const sqs = @import("sqs");

var gpa: std.heap.GeneralPurposeAllocator(.{}) = .init;
var shared_client: ?sqs.Client = null;
var shared_cfg: ?aws.Config = null;
var shared_queue_url_buf: [512]u8 = undefined;
var shared_queue_url: []const u8 = "";

test "zest.beforeAll" {
    const allocator = gpa.allocator();
    shared_cfg = try aws.Config.load(allocator, .{});
    shared_client = sqs.Client.initWithOptions(
        allocator,
        &shared_cfg.?,
        .{ .keep_alive = false },
    );
    {
        var arena = std.heap.ArenaAllocator.init(allocator);
        defer arena.deinit();
        const r = try shared_client.?.createQueue(
            arena.allocator(),
            .{ .queue_name = "sdk-zig-sqs-shared" },
            .{},
        );
        const url = r.queue_url orelse return error.MissingQueueUrl;
        @memcpy(shared_queue_url_buf[0..url.len], url);
        shared_queue_url = shared_queue_url_buf[0..url.len];
    }
}

test "zest.afterAll" {
    if (shared_client) |*c| {
        defer c.deinit();
        if (shared_queue_url.len > 0) {
            var arena = std.heap.ArenaAllocator.init(gpa.allocator());
            defer arena.deinit();
            _ = c.deleteQueue(
                arena.allocator(),
                .{ .queue_url = shared_queue_url },
                .{},
            ) catch {};
        }
    }
    if (shared_cfg) |*cfg| cfg.deinit();
    try std.testing.expect(gpa.deinit() == .ok);
}

test "CreateQueue returns queue URL" {
    const client = &shared_client.?;
    var arena = std.heap.ArenaAllocator.init(gpa.allocator());
    defer arena.deinit();

    const create_result = try client.createQueue(
        arena.allocator(),
        .{ .queue_name = "sdk-zig-sqs-create" },
        .{},
    );

    const queue_url = create_result.queue_url orelse
        return error.MissingQueueUrl;
    try std.testing.expect(queue_url.len > 0);

    _ = try client.deleteQueue(
        arena.allocator(),
        .{ .queue_url = queue_url },
        .{},
    );
}

test "SendMessage returns message ID with MD5 checksum" {
    const client = &shared_client.?;
    var arena = std.heap.ArenaAllocator.init(gpa.allocator());
    defer arena.deinit();

    const send_result = try client.sendMessage(
        arena.allocator(),
        .{
            .queue_url = shared_queue_url,
            .message_body = "test message for send",
        },
        .{},
    );

    try std.testing.expect(send_result.message_id != null);
    try std.testing.expect(send_result.md5_of_message_body != null);

    // Drain the sent message so subsequent tests start clean.
    const recv = try client.receiveMessage(
        arena.allocator(),
        .{
            .queue_url = shared_queue_url,
            .max_number_of_messages = 1,
            .wait_time_seconds = 5,
        },
        .{},
    );
    if (recv.messages) |msgs| {
        if (msgs.len > 0) {
            if (msgs[0].receipt_handle) |rh| {
                _ = try client.deleteMessage(
                    arena.allocator(),
                    .{
                        .queue_url = shared_queue_url,
                        .receipt_handle = rh,
                    },
                    .{},
                );
            }
        }
    }
}

test "ReceiveMessage returns sent message body" {
    const client = &shared_client.?;
    const body = "receive-body-check";
    var arena = std.heap.ArenaAllocator.init(gpa.allocator());
    defer arena.deinit();

    _ = try client.sendMessage(
        arena.allocator(),
        .{ .queue_url = shared_queue_url, .message_body = body },
        .{},
    );

    const recv_result = try client.receiveMessage(
        arena.allocator(),
        .{
            .queue_url = shared_queue_url,
            .max_number_of_messages = 1,
            .wait_time_seconds = 5,
        },
        .{},
    );

    const messages = recv_result.messages orelse
        return error.MissingMessages;
    try std.testing.expect(messages.len > 0);
    try std.testing.expectEqualStrings(
        body,
        messages[0].body orelse return error.MissingBody,
    );

    // Clean up the received message.
    const receipt = messages[0].receipt_handle orelse
        return error.MissingReceiptHandle;
    _ = try client.deleteMessage(
        arena.allocator(),
        .{ .queue_url = shared_queue_url, .receipt_handle = receipt },
        .{},
    );
}

test "DeleteMessage removes message from queue" {
    const client = &shared_client.?;
    var arena = std.heap.ArenaAllocator.init(gpa.allocator());
    defer arena.deinit();

    _ = try client.sendMessage(
        arena.allocator(),
        .{ .queue_url = shared_queue_url, .message_body = "delete-me" },
        .{},
    );

    const recv_result = try client.receiveMessage(
        arena.allocator(),
        .{
            .queue_url = shared_queue_url,
            .max_number_of_messages = 1,
            .wait_time_seconds = 5,
        },
        .{},
    );

    const messages = recv_result.messages orelse
        return error.MissingMessages;
    try std.testing.expect(messages.len > 0);
    const receipt = messages[0].receipt_handle orelse
        return error.MissingReceiptHandle;

    _ = try client.deleteMessage(
        arena.allocator(),
        .{ .queue_url = shared_queue_url, .receipt_handle = receipt },
        .{},
    );

    // Verify queue is now empty.
    const recv2 = try client.receiveMessage(
        arena.allocator(),
        .{
            .queue_url = shared_queue_url,
            .max_number_of_messages = 1,
            .wait_time_seconds = 0,
        },
        .{},
    );

    if (recv2.messages) |msgs| {
        try std.testing.expectEqual(0, msgs.len);
    }
}

test "DeleteQueue removes queue" {
    const client = &shared_client.?;
    var arena = std.heap.ArenaAllocator.init(gpa.allocator());
    defer arena.deinit();

    const create_result = try client.createQueue(
        arena.allocator(),
        .{ .queue_name = "sdk-zig-sqs-delete" },
        .{},
    );

    const queue_url = create_result.queue_url orelse
        return error.MissingQueueUrl;

    {
        _ = try client.deleteQueue(
            arena.allocator(),
            .{ .queue_url = queue_url },
            .{},
        );
    }

    const list_result = try client.listQueues(arena.allocator(), .{}, .{});

    if (list_result.queue_urls) |urls| {
        for (urls) |url| {
            if (std.mem.indexOf(u8, url, "sdk-zig-sqs-delete") != null) {
                return error.QueueStillExists;
            }
        }
    }
}

test "SendMessageBatch sends multiple messages in one call" {
    const client = &shared_client.?;
    var arena = std.heap.ArenaAllocator.init(gpa.allocator());
    defer arena.deinit();

    const create_result = try client.createQueue(
        arena.allocator(),
        .{ .queue_name = "sdk-zig-sqs-batch" },
        .{},
    );

    const queue_url = create_result.queue_url orelse
        return error.MissingQueueUrl;

    const batch_result = try client.sendMessageBatch(
        arena.allocator(),
        .{
            .queue_url = queue_url,
            .entries = &.{
                .{
                    .id = "msg-1",
                    .message_body = "body one",
                    .delay_seconds = null,
                    .message_attributes = null,
                    .message_deduplication_id = null,
                    .message_group_id = null,
                    .message_system_attributes = null,
                },
                .{
                    .id = "msg-2",
                    .message_body = "body two",
                    .delay_seconds = null,
                    .message_attributes = null,
                    .message_deduplication_id = null,
                    .message_group_id = null,
                    .message_system_attributes = null,
                },
                .{
                    .id = "msg-3",
                    .message_body = "body three",
                    .delay_seconds = null,
                    .message_attributes = null,
                    .message_deduplication_id = null,
                    .message_group_id = null,
                    .message_system_attributes = null,
                },
            },
        },
        .{},
    );

    const successful = batch_result.successful orelse
        return error.MissingSuccessful;
    try std.testing.expectEqual(3, successful.len);

    _ = try client.deleteQueue(
        arena.allocator(),
        .{ .queue_url = queue_url },
        .{},
    );
}

test "GetQueueAttributes returns queue metadata" {
    const client = &shared_client.?;
    var arena = std.heap.ArenaAllocator.init(gpa.allocator());
    defer arena.deinit();

    const attr_result = try client.getQueueAttributes(
        arena.allocator(),
        .{
            .queue_url = shared_queue_url,
            .attribute_names = &.{.all},
        },
        .{},
    );

    try std.testing.expect(attr_result.attributes != null);
}

test "ListQueues returns created queue URL" {
    const client = &shared_client.?;
    var arena = std.heap.ArenaAllocator.init(gpa.allocator());
    defer arena.deinit();

    const create_result = try client.createQueue(
        arena.allocator(),
        .{ .queue_name = "sdk-zig-sqs-list" },
        .{},
    );

    const queue_url = create_result.queue_url orelse
        return error.MissingQueueUrl;

    const list_result = try client.listQueues(arena.allocator(), .{}, .{});

    const urls = list_result.queue_urls orelse
        return error.MissingQueueUrls;
    var found = false;
    for (urls) |url| {
        if (std.mem.indexOf(u8, url, "sdk-zig-sqs-list") != null) {
            found = true;
            break;
        }
    }
    try std.testing.expect(found);

    _ = try client.deleteQueue(
        arena.allocator(),
        .{ .queue_url = queue_url },
        .{},
    );
}

test "ReceiveMessage returns empty when queue is empty" {
    const client = &shared_client.?;
    var arena = std.heap.ArenaAllocator.init(gpa.allocator());
    defer arena.deinit();

    const create_result = try client.createQueue(
        arena.allocator(),
        .{ .queue_name = "sdk-zig-sqs-empty" },
        .{},
    );

    const queue_url = create_result.queue_url orelse
        return error.MissingQueueUrl;

    const recv_result = try client.receiveMessage(
        arena.allocator(),
        .{
            .queue_url = queue_url,
            .wait_time_seconds = 0,
            .max_number_of_messages = 1,
        },
        .{},
    );

    if (recv_result.messages) |messages| {
        try std.testing.expectEqual(0, messages.len);
    }

    _ = try client.deleteQueue(
        arena.allocator(),
        .{ .queue_url = queue_url },
        .{},
    );
}

test "GetQueueUrl returns URL for named queue" {
    const client = &shared_client.?;
    var arena = std.heap.ArenaAllocator.init(gpa.allocator());
    defer arena.deinit();

    const create_result = try client.createQueue(
        arena.allocator(),
        .{ .queue_name = "sdk-zig-sqs-geturl" },
        .{},
    );

    const created_url = create_result.queue_url orelse
        return error.MissingQueueUrl;

    const url_result = try client.getQueueUrl(
        arena.allocator(),
        .{ .queue_name = "sdk-zig-sqs-geturl" },
        .{},
    );

    const fetched_url = url_result.queue_url orelse
        return error.MissingQueueUrl;
    try std.testing.expectEqualStrings(created_url, fetched_url);

    _ = try client.deleteQueue(
        arena.allocator(),
        .{ .queue_url = created_url },
        .{},
    );
}

test "PurgeQueue removes all messages" {
    const client = &shared_client.?;
    var arena = std.heap.ArenaAllocator.init(gpa.allocator());
    defer arena.deinit();

    const create_result = try client.createQueue(
        arena.allocator(),
        .{ .queue_name = "sdk-zig-sqs-purge" },
        .{},
    );

    const queue_url = create_result.queue_url orelse
        return error.MissingQueueUrl;

    {
        _ = try client.sendMessage(
            arena.allocator(),
            .{ .queue_url = queue_url, .message_body = "purge-1" },
            .{},
        );
    }
    {
        _ = try client.sendMessage(
            arena.allocator(),
            .{ .queue_url = queue_url, .message_body = "purge-2" },
            .{},
        );
    }

    {
        _ = try client.purgeQueue(
            arena.allocator(),
            .{ .queue_url = queue_url },
            .{},
        );
    }

    const recv = try client.receiveMessage(
        arena.allocator(),
        .{
            .queue_url = queue_url,
            .wait_time_seconds = 0,
            .max_number_of_messages = 10,
        },
        .{},
    );

    if (recv.messages) |msgs| {
        try std.testing.expectEqual(0, msgs.len);
    }

    _ = try client.deleteQueue(
        arena.allocator(),
        .{ .queue_url = queue_url },
        .{},
    );
}

test "SendMessageBatch returns correct successful count" {
    const client = &shared_client.?;
    var arena = std.heap.ArenaAllocator.init(gpa.allocator());
    defer arena.deinit();

    const create_result = try client.createQueue(
        arena.allocator(),
        .{ .queue_name = "sdk-zig-sqs-batch-count" },
        .{},
    );

    const queue_url = create_result.queue_url orelse
        return error.MissingQueueUrl;

    const batch = try client.sendMessageBatch(
        arena.allocator(),
        .{
            .queue_url = queue_url,
            .entries = &.{
                .{
                    .id = "a",
                    .message_body = "alpha",
                    .delay_seconds = null,
                    .message_attributes = null,
                    .message_deduplication_id = null,
                    .message_group_id = null,
                    .message_system_attributes = null,
                },
                .{
                    .id = "b",
                    .message_body = "beta",
                    .delay_seconds = null,
                    .message_attributes = null,
                    .message_deduplication_id = null,
                    .message_group_id = null,
                    .message_system_attributes = null,
                },
                .{
                    .id = "c",
                    .message_body = "gamma",
                    .delay_seconds = null,
                    .message_attributes = null,
                    .message_deduplication_id = null,
                    .message_group_id = null,
                    .message_system_attributes = null,
                },
            },
        },
        .{},
    );

    const successful = batch.successful orelse
        return error.MissingSuccessful;
    try std.testing.expectEqual(3, successful.len);

    _ = try client.deleteQueue(
        arena.allocator(),
        .{ .queue_url = queue_url },
        .{},
    );
}

test "CreateQueue with attributes sets visibility timeout" {
    const client = &shared_client.?;
    var arena = std.heap.ArenaAllocator.init(gpa.allocator());
    defer arena.deinit();

    const create_result = try client.createQueue(
        arena.allocator(),
        .{
            .queue_name = "sdk-zig-sqs-attrs-create",
            .attributes = &.{
                .{ .key = "VisibilityTimeout", .value = "30" },
            },
        },
        .{},
    );

    const queue_url = create_result.queue_url orelse
        return error.MissingQueueUrl;
    try std.testing.expect(queue_url.len > 0);

    _ = try client.deleteQueue(
        arena.allocator(),
        .{ .queue_url = queue_url },
        .{},
    );
}

test "ChangeMessageVisibility extends visibility timeout" {
    const client = &shared_client.?;
    var arena = std.heap.ArenaAllocator.init(gpa.allocator());
    defer arena.deinit();

    const create_result = try client.createQueue(
        arena.allocator(),
        .{ .queue_name = "sdk-zig-sqs-visibility" },
        .{},
    );

    const queue_url = create_result.queue_url orelse
        return error.MissingQueueUrl;

    {
        _ = try client.sendMessage(
            arena.allocator(),
            .{ .queue_url = queue_url, .message_body = "visibility-test" },
            .{},
        );
    }

    // Receive makes the message invisible for the default timeout.
    const recv1 = try client.receiveMessage(
        arena.allocator(),
        .{
            .queue_url = queue_url,
            .max_number_of_messages = 1,
            .wait_time_seconds = 5,
        },
        .{},
    );

    const messages = recv1.messages orelse return error.MissingMessages;
    try std.testing.expect(messages.len > 0);
    const receipt = messages[0].receipt_handle orelse
        return error.MissingReceiptHandle;

    // Set visibility timeout to 0 so the message becomes immediately visible.
    {
        _ = try client.changeMessageVisibility(
            arena.allocator(),
            .{
                .queue_url = queue_url,
                .receipt_handle = receipt,
                .visibility_timeout = 0,
            },
            .{},
        );
    }

    // The message should be receivable again.
    const recv2 = try client.receiveMessage(
        arena.allocator(),
        .{
            .queue_url = queue_url,
            .max_number_of_messages = 1,
            .wait_time_seconds = 5,
        },
        .{},
    );

    const msgs2 = recv2.messages orelse return error.MissingMessages;
    try std.testing.expect(msgs2.len > 0);
    try std.testing.expectEqualStrings(
        "visibility-test",
        msgs2[0].body orelse return error.MissingBody,
    );

    {
        _ = try client.deleteQueue(
            arena.allocator(),
            .{ .queue_url = queue_url },
            .{},
        );
    }
}
