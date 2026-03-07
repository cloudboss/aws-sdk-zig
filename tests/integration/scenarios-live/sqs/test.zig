const std = @import("std");
const aws = @import("aws");
const sqs = @import("sqs");

var gpa: std.heap.GeneralPurposeAllocator(.{}) = .init;
var shared_client: ?sqs.Client = null;
var shared_cfg: ?aws.Config = null;
var shared_queue_url_buf: [512]u8 = undefined;
var shared_queue_url: []const u8 = "";
var shared_queue_name_buf: [64]u8 = undefined;
var shared_queue_name: []const u8 = "";

test "zest.beforeAll" {
    const allocator = gpa.allocator();
    shared_cfg = try aws.Config.load(allocator, .{});
    shared_client = sqs.Client.init(allocator, &shared_cfg.?);
    {
        var arena = std.heap.ArenaAllocator.init(allocator);
        defer arena.deinit();

        const queue_name = try std.fmt.bufPrint(
            &shared_queue_name_buf,
            "sdk-zig-live-sqs-{d}",
            .{std.time.timestamp()},
        );
        shared_queue_name = queue_name;

        const r = try shared_client.?.createQueue(
            arena.allocator(),
            .{ .queue_name = queue_name },
            .{},
        );
        const url = r.queue_url orelse
            return error.MissingQueueUrl;
        @memcpy(shared_queue_url_buf[0..url.len], url);
        shared_queue_url = shared_queue_url_buf[0..url.len];

        _ = try shared_client.?.tagQueue(
            arena.allocator(),
            .{
                .queue_url = shared_queue_url,
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

test "createQueue returns queue URL" {
    const client = &shared_client.?;
    var arena = std.heap.ArenaAllocator.init(std.testing.allocator);
    defer arena.deinit();

    var name_buf: [64]u8 = undefined;
    const queue_name = try std.fmt.bufPrint(
        &name_buf,
        "sdk-zig-live-sqs-cq-{d}",
        .{std.time.timestamp()},
    );

    const create_result = try client.createQueue(
        arena.allocator(),
        .{ .queue_name = queue_name },
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

test "sendMessage returns message ID" {
    const client = &shared_client.?;
    var arena = std.heap.ArenaAllocator.init(std.testing.allocator);
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

test "receiveMessage returns sent message body" {
    const client = &shared_client.?;
    const body = "receive-body-check";
    var arena = std.heap.ArenaAllocator.init(std.testing.allocator);
    defer arena.deinit();

    _ = try client.sendMessage(
        arena.allocator(),
        .{
            .queue_url = shared_queue_url,
            .message_body = body,
        },
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

    const receipt = messages[0].receipt_handle orelse
        return error.MissingReceiptHandle;
    _ = try client.deleteMessage(
        arena.allocator(),
        .{
            .queue_url = shared_queue_url,
            .receipt_handle = receipt,
        },
        .{},
    );
}

test "deleteMessage removes message from queue" {
    const client = &shared_client.?;
    var arena = std.heap.ArenaAllocator.init(std.testing.allocator);
    defer arena.deinit();

    _ = try client.sendMessage(
        arena.allocator(),
        .{
            .queue_url = shared_queue_url,
            .message_body = "delete-me",
        },
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
        .{
            .queue_url = shared_queue_url,
            .receipt_handle = receipt,
        },
        .{},
    );

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

test "listQueues includes created queue" {
    const client = &shared_client.?;
    var arena = std.heap.ArenaAllocator.init(std.testing.allocator);
    defer arena.deinit();

    var found = false;
    var attempt: usize = 0;
    while (attempt < 10 and !found) : (attempt += 1) {
        const list_result = try client.listQueues(
            arena.allocator(),
            .{ .queue_name_prefix = shared_queue_name },
            .{},
        );

        if (list_result.queue_urls) |urls| {
            for (urls) |url| {
                if (std.mem.indexOf(
                    u8,
                    url,
                    shared_queue_name,
                ) != null) {
                    found = true;
                    break;
                }
            }
        }

        if (!found and attempt + 1 < 10) {
            std.Thread.sleep(300 * std.time.ns_per_ms);
        }
    }

    try std.testing.expect(found);
}

test "getQueueAttributes returns metadata" {
    const client = &shared_client.?;
    var arena = std.heap.ArenaAllocator.init(std.testing.allocator);
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

test "sendMessageBatch sends multiple messages" {
    const client = &shared_client.?;
    var arena = std.heap.ArenaAllocator.init(std.testing.allocator);
    defer arena.deinit();

    var name_buf: [64]u8 = undefined;
    const queue_name = try std.fmt.bufPrint(
        &name_buf,
        "sdk-zig-live-sqs-batch-{d}",
        .{std.time.timestamp()},
    );

    const create_result = try client.createQueue(
        arena.allocator(),
        .{ .queue_name = queue_name },
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
                    .message_body = "batch one",
                    .delay_seconds = null,
                    .message_attributes = null,
                    .message_deduplication_id = null,
                    .message_group_id = null,
                    .message_system_attributes = null,
                },
                .{
                    .id = "msg-2",
                    .message_body = "batch two",
                    .delay_seconds = null,
                    .message_attributes = null,
                    .message_deduplication_id = null,
                    .message_group_id = null,
                    .message_system_attributes = null,
                },
                .{
                    .id = "msg-3",
                    .message_body = "batch three",
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

test "purgeQueue clears all messages" {
    const client = &shared_client.?;
    var arena = std.heap.ArenaAllocator.init(std.testing.allocator);
    defer arena.deinit();

    _ = try client.sendMessage(
        arena.allocator(),
        .{
            .queue_url = shared_queue_url,
            .message_body = "purge-1",
        },
        .{},
    );
    _ = try client.sendMessage(
        arena.allocator(),
        .{
            .queue_url = shared_queue_url,
            .message_body = "purge-2",
        },
        .{},
    );

    _ = try client.purgeQueue(
        arena.allocator(),
        .{ .queue_url = shared_queue_url },
        .{},
    );

    const recv = try client.receiveMessage(
        arena.allocator(),
        .{
            .queue_url = shared_queue_url,
            .wait_time_seconds = 0,
            .max_number_of_messages = 10,
        },
        .{},
    );

    if (recv.messages) |msgs| {
        try std.testing.expectEqual(0, msgs.len);
    }
}

test "getQueueUrl returns URL for named queue" {
    const client = &shared_client.?;
    var arena = std.heap.ArenaAllocator.init(std.testing.allocator);
    defer arena.deinit();

    var name_buf: [64]u8 = undefined;
    const queue_name = try std.fmt.bufPrint(
        &name_buf,
        "sdk-zig-live-sqs-gu-{d}",
        .{std.time.timestamp()},
    );

    const create_result = try client.createQueue(
        arena.allocator(),
        .{ .queue_name = queue_name },
        .{},
    );

    const created_url = create_result.queue_url orelse
        return error.MissingQueueUrl;

    const url_result = try client.getQueueUrl(
        arena.allocator(),
        .{ .queue_name = queue_name },
        .{},
    );

    const fetched_url = url_result.queue_url orelse
        return error.MissingQueueUrl;
    try std.testing.expectEqualStrings(
        created_url,
        fetched_url,
    );

    _ = try client.deleteQueue(
        arena.allocator(),
        .{ .queue_url = created_url },
        .{},
    );
}
