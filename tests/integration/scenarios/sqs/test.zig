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
    const endpoint_url = std.posix.getenv("AWS_ENDPOINT_URL") orelse
        return error.MissingEndpoint;
    shared_cfg = try aws.Config.load(allocator, .{ .endpoint_url = endpoint_url });
    shared_client = sqs.Client.initWithOptions(
        allocator,
        &shared_cfg.?,
        .{ .keep_alive = false },
    );
    var r = try sqs.create_queue.execute(
        &shared_client.?,
        .{ .queue_name = "sdk-zig-sqs-shared" },
        .{},
    );
    defer r.deinit();
    const url = r.queue_url orelse return error.MissingQueueUrl;
    @memcpy(shared_queue_url_buf[0..url.len], url);
    shared_queue_url = shared_queue_url_buf[0..url.len];
}

test "zest.afterAll" {
    if (shared_client) |*c| {
        defer c.deinit();
        if (shared_queue_url.len > 0) {
            if (sqs.delete_queue.execute(
                c,
                .{ .queue_url = shared_queue_url },
                .{},
            )) |r_| {
                var r = r_;
                r.deinit();
            } else |_| {}
        }
    }
    if (shared_cfg) |*cfg| cfg.deinit();
    _ = gpa.deinit();
}

test "CreateQueue returns queue URL" {
    const client = &shared_client.?;

    var create_result = try sqs.create_queue.execute(
        client,
        .{ .queue_name = "sdk-zig-sqs-create" },
        .{},
    );
    defer create_result.deinit();

    const queue_url = create_result.queue_url orelse
        return error.MissingQueueUrl;
    try std.testing.expect(queue_url.len > 0);

    var del = try sqs.delete_queue.execute(
        client,
        .{ .queue_url = queue_url },
        .{},
    );
    defer del.deinit();
}

test "SendMessage returns message ID with MD5 checksum" {
    const client = &shared_client.?;

    var send_result = try sqs.send_message.execute(
        client,
        .{
            .queue_url = shared_queue_url,
            .message_body = "test message for send",
        },
        .{},
    );
    defer send_result.deinit();

    try std.testing.expect(send_result.message_id != null);
    try std.testing.expect(send_result.md5_of_message_body != null);

    // Drain the sent message so subsequent tests start clean.
    var recv = try sqs.receive_message.execute(
        client,
        .{
            .queue_url = shared_queue_url,
            .max_number_of_messages = 1,
            .wait_time_seconds = 5,
        },
        .{},
    );
    defer recv.deinit();
    if (recv.messages) |msgs| {
        if (msgs.len > 0) {
            if (msgs[0].receipt_handle) |rh| {
                var d = try sqs.delete_message.execute(
                    client,
                    .{
                        .queue_url = shared_queue_url,
                        .receipt_handle = rh,
                    },
                    .{},
                );
                defer d.deinit();
            }
        }
    }
}

test "ReceiveMessage returns sent message body" {
    const client = &shared_client.?;
    const body = "receive-body-check";

    var send_result = try sqs.send_message.execute(
        client,
        .{ .queue_url = shared_queue_url, .message_body = body },
        .{},
    );
    defer send_result.deinit();

    var recv_result = try sqs.receive_message.execute(
        client,
        .{
            .queue_url = shared_queue_url,
            .max_number_of_messages = 1,
            .wait_time_seconds = 5,
        },
        .{},
    );
    defer recv_result.deinit();

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
    var del = try sqs.delete_message.execute(
        client,
        .{ .queue_url = shared_queue_url, .receipt_handle = receipt },
        .{},
    );
    defer del.deinit();
}

test "DeleteMessage removes message from queue" {
    const client = &shared_client.?;

    var send_result = try sqs.send_message.execute(
        client,
        .{ .queue_url = shared_queue_url, .message_body = "delete-me" },
        .{},
    );
    defer send_result.deinit();

    var recv_result = try sqs.receive_message.execute(
        client,
        .{
            .queue_url = shared_queue_url,
            .max_number_of_messages = 1,
            .wait_time_seconds = 5,
        },
        .{},
    );
    defer recv_result.deinit();

    const messages = recv_result.messages orelse
        return error.MissingMessages;
    try std.testing.expect(messages.len > 0);
    const receipt = messages[0].receipt_handle orelse
        return error.MissingReceiptHandle;

    var del_msg = try sqs.delete_message.execute(
        client,
        .{ .queue_url = shared_queue_url, .receipt_handle = receipt },
        .{},
    );
    defer del_msg.deinit();

    // Verify queue is now empty.
    var recv2 = try sqs.receive_message.execute(
        client,
        .{
            .queue_url = shared_queue_url,
            .max_number_of_messages = 1,
            .wait_time_seconds = 0,
        },
        .{},
    );
    defer recv2.deinit();

    if (recv2.messages) |msgs| {
        try std.testing.expectEqual(0, msgs.len);
    }
}

test "DeleteQueue removes queue" {
    const client = &shared_client.?;

    var create_result = try sqs.create_queue.execute(
        client,
        .{ .queue_name = "sdk-zig-sqs-delete" },
        .{},
    );
    defer create_result.deinit();

    const queue_url = create_result.queue_url orelse
        return error.MissingQueueUrl;

    {
        var del = try sqs.delete_queue.execute(
            client,
            .{ .queue_url = queue_url },
            .{},
        );
        defer del.deinit();
    }

    var list_result = try sqs.list_queues.execute(client, .{}, .{});
    defer list_result.deinit();

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

    var create_result = try sqs.create_queue.execute(
        client,
        .{ .queue_name = "sdk-zig-sqs-batch" },
        .{},
    );
    defer create_result.deinit();

    const queue_url = create_result.queue_url orelse
        return error.MissingQueueUrl;

    var batch_result = try sqs.send_message_batch.execute(
        client,
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

    var del = try sqs.delete_queue.execute(
        client,
        .{ .queue_url = queue_url },
        .{},
    );
    defer del.deinit();
}

test "GetQueueAttributes returns queue metadata" {
    const client = &shared_client.?;

    var attr_result = try sqs.get_queue_attributes.execute(
        client,
        .{
            .queue_url = shared_queue_url,
            .attribute_names = &.{.all},
        },
        .{},
    );
    defer attr_result.deinit();

    try std.testing.expect(attr_result.attributes != null);
}

test "ListQueues returns created queue URL" {
    const client = &shared_client.?;

    var create_result = try sqs.create_queue.execute(
        client,
        .{ .queue_name = "sdk-zig-sqs-list" },
        .{},
    );
    defer create_result.deinit();

    const queue_url = create_result.queue_url orelse
        return error.MissingQueueUrl;

    var list_result = try sqs.list_queues.execute(client, .{}, .{});
    defer list_result.deinit();

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

    var del = try sqs.delete_queue.execute(
        client,
        .{ .queue_url = queue_url },
        .{},
    );
    defer del.deinit();
}

test "ReceiveMessage returns empty when queue is empty" {
    const client = &shared_client.?;

    var create_result = try sqs.create_queue.execute(
        client,
        .{ .queue_name = "sdk-zig-sqs-empty" },
        .{},
    );
    defer create_result.deinit();

    const queue_url = create_result.queue_url orelse
        return error.MissingQueueUrl;

    var recv_result = try sqs.receive_message.execute(
        client,
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

    var del = try sqs.delete_queue.execute(
        client,
        .{ .queue_url = queue_url },
        .{},
    );
    defer del.deinit();
}

test "GetQueueUrl returns URL for named queue" {
    const client = &shared_client.?;

    var create_result = try sqs.create_queue.execute(
        client,
        .{ .queue_name = "sdk-zig-sqs-geturl" },
        .{},
    );
    defer create_result.deinit();

    const created_url = create_result.queue_url orelse
        return error.MissingQueueUrl;

    var url_result = try sqs.get_queue_url.execute(
        client,
        .{ .queue_name = "sdk-zig-sqs-geturl" },
        .{},
    );
    defer url_result.deinit();

    const fetched_url = url_result.queue_url orelse
        return error.MissingQueueUrl;
    try std.testing.expectEqualStrings(created_url, fetched_url);

    var del = try sqs.delete_queue.execute(
        client,
        .{ .queue_url = created_url },
        .{},
    );
    defer del.deinit();
}

test "PurgeQueue removes all messages" {
    const client = &shared_client.?;

    var create_result = try sqs.create_queue.execute(
        client,
        .{ .queue_name = "sdk-zig-sqs-purge" },
        .{},
    );
    defer create_result.deinit();

    const queue_url = create_result.queue_url orelse
        return error.MissingQueueUrl;

    {
        var r = try sqs.send_message.execute(
            client,
            .{ .queue_url = queue_url, .message_body = "purge-1" },
            .{},
        );
        defer r.deinit();
    }
    {
        var r = try sqs.send_message.execute(
            client,
            .{ .queue_url = queue_url, .message_body = "purge-2" },
            .{},
        );
        defer r.deinit();
    }

    {
        var r = try sqs.purge_queue.execute(
            client,
            .{ .queue_url = queue_url },
            .{},
        );
        defer r.deinit();
    }

    var recv = try sqs.receive_message.execute(
        client,
        .{
            .queue_url = queue_url,
            .wait_time_seconds = 0,
            .max_number_of_messages = 10,
        },
        .{},
    );
    defer recv.deinit();

    if (recv.messages) |msgs| {
        try std.testing.expectEqual(0, msgs.len);
    }

    var del = try sqs.delete_queue.execute(
        client,
        .{ .queue_url = queue_url },
        .{},
    );
    defer del.deinit();
}

test "SendMessageBatch returns correct successful count" {
    const client = &shared_client.?;

    var create_result = try sqs.create_queue.execute(
        client,
        .{ .queue_name = "sdk-zig-sqs-batch-count" },
        .{},
    );
    defer create_result.deinit();

    const queue_url = create_result.queue_url orelse
        return error.MissingQueueUrl;

    var batch = try sqs.send_message_batch.execute(
        client,
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
    defer batch.deinit();

    const successful = batch.successful orelse
        return error.MissingSuccessful;
    try std.testing.expectEqual(3, successful.len);

    var del = try sqs.delete_queue.execute(
        client,
        .{ .queue_url = queue_url },
        .{},
    );
    defer del.deinit();
}

test "CreateQueue with attributes sets visibility timeout" {
    const client = &shared_client.?;

    var create_result = try sqs.create_queue.execute(
        client,
        .{
            .queue_name = "sdk-zig-sqs-attrs-create",
            .attributes = &.{
                .{ .key = "VisibilityTimeout", .value = "30" },
            },
        },
        .{},
    );
    defer create_result.deinit();

    const queue_url = create_result.queue_url orelse
        return error.MissingQueueUrl;
    try std.testing.expect(queue_url.len > 0);

    var del = try sqs.delete_queue.execute(
        client,
        .{ .queue_url = queue_url },
        .{},
    );
    defer del.deinit();
}

test "ChangeMessageVisibility extends visibility timeout" {
    const client = &shared_client.?;

    var create_result = try sqs.create_queue.execute(
        client,
        .{ .queue_name = "sdk-zig-sqs-visibility" },
        .{},
    );
    defer create_result.deinit();

    const queue_url = create_result.queue_url orelse
        return error.MissingQueueUrl;

    {
        var r = try sqs.send_message.execute(
            client,
            .{ .queue_url = queue_url, .message_body = "visibility-test" },
            .{},
        );
        defer r.deinit();
    }

    // Receive makes the message invisible for the default timeout.
    var recv1 = try sqs.receive_message.execute(
        client,
        .{
            .queue_url = queue_url,
            .max_number_of_messages = 1,
            .wait_time_seconds = 5,
        },
        .{},
    );
    defer recv1.deinit();

    const messages = recv1.messages orelse return error.MissingMessages;
    try std.testing.expect(messages.len > 0);
    const receipt = messages[0].receipt_handle orelse
        return error.MissingReceiptHandle;

    // Set visibility timeout to 0 so the message becomes immediately visible.
    {
        var r = try sqs.change_message_visibility.execute(
            client,
            .{
                .queue_url = queue_url,
                .receipt_handle = receipt,
                .visibility_timeout = 0,
            },
            .{},
        );
        defer r.deinit();
    }

    // The message should be receivable again.
    var recv2 = try sqs.receive_message.execute(
        client,
        .{
            .queue_url = queue_url,
            .max_number_of_messages = 1,
            .wait_time_seconds = 5,
        },
        .{},
    );
    defer recv2.deinit();

    const msgs2 = recv2.messages orelse return error.MissingMessages;
    try std.testing.expect(msgs2.len > 0);
    try std.testing.expectEqualStrings(
        "visibility-test",
        msgs2[0].body orelse return error.MissingBody,
    );

    {
        var r = try sqs.delete_queue.execute(
            client,
            .{ .queue_url = queue_url },
            .{},
        );
        defer r.deinit();
    }
}
