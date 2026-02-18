const std = @import("std");
const aws = @import("aws");
const sqs = @import("sqs");

test "CreateQueue, SendMessage, ReceiveMessage, DeleteMessage, DeleteQueue" {
    const allocator = std.testing.allocator;

    const endpoint_url = std.posix.getenv("AWS_ENDPOINT_URL") orelse
        return error.MissingEndpoint;

    var cfg = try aws.Config.load(allocator, .{
        .endpoint_url = endpoint_url,
    });
    defer cfg.deinit();

    var client = sqs.Client.initWithOptions(allocator, &cfg, .{ .keep_alive = false });
    defer client.deinit();

    const queue_name = "sdk-zig-test-queue";
    const message_body = "Hello from aws-sdk-zig integration test!";

    // --- CreateQueue ---
    var create_result = try sqs.create_queue.execute(
        &client,
        .{ .queue_name = queue_name },
        .{},
    );
    defer create_result.deinit();

    const queue_url = create_result.queue_url orelse return error.MissingQueueUrl;

    // --- SendMessage ---
    var send_result = try sqs.send_message.execute(
        &client,
        .{ .queue_url = queue_url, .message_body = message_body },
        .{},
    );
    defer send_result.deinit();

    try std.testing.expect(send_result.message_id != null);
    try std.testing.expect(send_result.md5_of_message_body != null);

    // --- ReceiveMessage ---
    var recv_result = try sqs.receive_message.execute(
        &client,
        .{ .queue_url = queue_url, .max_number_of_messages = 1, .wait_time_seconds = 5 },
        .{},
    );
    defer recv_result.deinit();

    const messages = recv_result.messages orelse return error.MissingMessages;
    try std.testing.expect(messages.len > 0);
    try std.testing.expectEqualStrings(message_body, messages[0].body orelse
        return error.MissingBody);

    // --- DeleteMessage ---
    const receipt_handle = messages[0].receipt_handle orelse return error.MissingReceiptHandle;
    var del_msg_result = try sqs.delete_message.execute(
        &client,
        .{ .queue_url = queue_url, .receipt_handle = receipt_handle },
        .{},
    );
    defer del_msg_result.deinit();

    // --- DeleteQueue ---
    var del_queue_result = try sqs.delete_queue.execute(
        &client,
        .{ .queue_url = queue_url },
        .{},
    );
    defer del_queue_result.deinit();
}

test "SendMessageBatch sends multiple messages in one call" {
    const allocator = std.testing.allocator;

    const endpoint_url = std.posix.getenv("AWS_ENDPOINT_URL") orelse
        return error.MissingEndpoint;

    var cfg = try aws.Config.load(allocator, .{
        .endpoint_url = endpoint_url,
    });
    defer cfg.deinit();

    var client = sqs.Client.initWithOptions(
        allocator,
        &cfg,
        .{ .keep_alive = false },
    );
    defer client.deinit();

    // --- CreateQueue ---
    var create_result = try sqs.create_queue.execute(
        &client,
        .{ .queue_name = "sdk-zig-sqs-batch-send" },
        .{},
    );
    defer create_result.deinit();

    const queue_url = create_result.queue_url orelse
        return error.MissingQueueUrl;

    // --- SendMessageBatch ---
    var batch_result = try sqs.send_message_batch.execute(
        &client,
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
    defer batch_result.deinit();

    const successful = batch_result.successful orelse
        return error.MissingSuccessful;
    try std.testing.expectEqual(3, successful.len);

    // --- DeleteQueue ---
    var del_queue_result = try sqs.delete_queue.execute(
        &client,
        .{ .queue_url = queue_url },
        .{},
    );
    defer del_queue_result.deinit();
}

test "GetQueueAttributes returns queue metadata" {
    const allocator = std.testing.allocator;

    const endpoint_url = std.posix.getenv("AWS_ENDPOINT_URL") orelse
        return error.MissingEndpoint;

    var cfg = try aws.Config.load(allocator, .{
        .endpoint_url = endpoint_url,
    });
    defer cfg.deinit();

    var client = sqs.Client.initWithOptions(
        allocator,
        &cfg,
        .{ .keep_alive = false },
    );
    defer client.deinit();

    // --- CreateQueue ---
    var create_result = try sqs.create_queue.execute(
        &client,
        .{ .queue_name = "sdk-zig-sqs-attributes" },
        .{},
    );
    defer create_result.deinit();

    const queue_url = create_result.queue_url orelse
        return error.MissingQueueUrl;

    // --- GetQueueAttributes ---
    var attr_result = try sqs.get_queue_attributes.execute(
        &client,
        .{
            .queue_url = queue_url,
            .attribute_names = &.{.all},
        },
        .{},
    );
    defer attr_result.deinit();

    try std.testing.expect(attr_result.attributes != null);

    // --- DeleteQueue ---
    var del_queue_result = try sqs.delete_queue.execute(
        &client,
        .{ .queue_url = queue_url },
        .{},
    );
    defer del_queue_result.deinit();
}

test "ListQueues returns created queue URL" {
    const allocator = std.testing.allocator;

    const endpoint_url = std.posix.getenv("AWS_ENDPOINT_URL") orelse
        return error.MissingEndpoint;

    var cfg = try aws.Config.load(allocator, .{
        .endpoint_url = endpoint_url,
    });
    defer cfg.deinit();

    var client = sqs.Client.initWithOptions(
        allocator,
        &cfg,
        .{ .keep_alive = false },
    );
    defer client.deinit();

    // --- CreateQueue ---
    var create_result = try sqs.create_queue.execute(
        &client,
        .{ .queue_name = "sdk-zig-sqs-list-queues" },
        .{},
    );
    defer create_result.deinit();

    const queue_url = create_result.queue_url orelse
        return error.MissingQueueUrl;

    // --- ListQueues ---
    var list_result = try sqs.list_queues.execute(
        &client,
        .{},
        .{},
    );
    defer list_result.deinit();

    const urls = list_result.queue_urls orelse
        return error.MissingQueueUrls;
    var found = false;
    for (urls) |url| {
        if (std.mem.indexOf(
            u8,
            url,
            "sdk-zig-sqs-list-queues",
        ) != null) {
            found = true;
            break;
        }
    }
    try std.testing.expect(found);

    // --- DeleteQueue ---
    var del_queue_result = try sqs.delete_queue.execute(
        &client,
        .{ .queue_url = queue_url },
        .{},
    );
    defer del_queue_result.deinit();
}

test "ReceiveMessage returns empty when queue is empty" {
    const allocator = std.testing.allocator;

    const endpoint_url = std.posix.getenv("AWS_ENDPOINT_URL") orelse
        return error.MissingEndpoint;

    var cfg = try aws.Config.load(allocator, .{
        .endpoint_url = endpoint_url,
    });
    defer cfg.deinit();

    var client = sqs.Client.initWithOptions(
        allocator,
        &cfg,
        .{ .keep_alive = false },
    );
    defer client.deinit();

    // --- CreateQueue ---
    var create_result = try sqs.create_queue.execute(
        &client,
        .{ .queue_name = "sdk-zig-sqs-empty-receive" },
        .{},
    );
    defer create_result.deinit();

    const queue_url = create_result.queue_url orelse
        return error.MissingQueueUrl;

    // --- ReceiveMessage (empty queue) ---
    var recv_result = try sqs.receive_message.execute(
        &client,
        .{
            .queue_url = queue_url,
            .wait_time_seconds = 0,
            .max_number_of_messages = 1,
        },
        .{},
    );
    defer recv_result.deinit();

    if (recv_result.messages) |messages| {
        try std.testing.expectEqual(0, messages.len);
    }

    // --- DeleteQueue ---
    var del_queue_result = try sqs.delete_queue.execute(
        &client,
        .{ .queue_url = queue_url },
        .{},
    );
    defer del_queue_result.deinit();
}
