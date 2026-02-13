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

    var client = sqs.Client.init(allocator, &cfg);
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
