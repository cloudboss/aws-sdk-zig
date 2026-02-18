const std = @import("std");
const aws = @import("aws");
const sns = @import("sns");
const sqs = @import("sqs");

test "CreateTopic, Publish, DeleteTopic" {
    const allocator = std.testing.allocator;

    const endpoint_url = std.posix.getenv("AWS_ENDPOINT_URL") orelse
        return error.MissingEndpoint;

    var cfg = try aws.Config.load(allocator, .{
        .endpoint_url = endpoint_url,
    });
    defer cfg.deinit();

    var client = sns.Client.initWithOptions(allocator, &cfg, .{ .keep_alive = false });
    defer client.deinit();

    const topic_name = "sdk-zig-test-topic";

    // --- CreateTopic ---
    var create_result = try sns.create_topic.execute(
        &client,
        .{ .name = topic_name },
        .{},
    );
    defer create_result.deinit();

    const topic_arn = create_result.topic_arn orelse return error.MissingTopicArn;

    // --- Publish ---
    var pub_result = try sns.publish.execute(
        &client,
        .{ .topic_arn = topic_arn, .message = "Hello from aws-sdk-zig!" },
        .{},
    );
    defer pub_result.deinit();

    try std.testing.expect(pub_result.message_id != null);

    // --- DeleteTopic ---
    var delete_result = try sns.delete_topic.execute(
        &client,
        .{ .topic_arn = topic_arn },
        .{},
    );
    defer delete_result.deinit();
}

test "Subscribe SQS queue to SNS topic and receive message" {
    const allocator = std.testing.allocator;

    const endpoint_url = std.posix.getenv("AWS_ENDPOINT_URL") orelse
        return error.MissingEndpoint;

    var cfg = try aws.Config.load(allocator, .{
        .endpoint_url = endpoint_url,
    });
    defer cfg.deinit();

    var sns_client = sns.Client.initWithOptions(allocator, &cfg, .{ .keep_alive = false });
    defer sns_client.deinit();

    var sqs_client = sqs.Client.initWithOptions(allocator, &cfg, .{ .keep_alive = false });
    defer sqs_client.deinit();

    // Create SQS queue for subscription
    var queue_result = try sqs.create_queue.execute(
        &sqs_client,
        .{ .queue_name = "sdk-zig-sns-sub-queue" },
        .{},
    );
    defer queue_result.deinit();

    const queue_url = queue_result.queue_url orelse return error.MissingQueueUrl;

    // Derive queue ARN from URL (LocalStack format: http://host:port/000000000000/name)
    const queue_name = "sdk-zig-sns-sub-queue";
    var arn_buf: [256]u8 = undefined;
    const queue_arn = std.fmt.bufPrint(&arn_buf, "arn:aws:sqs:us-east-1:000000000000:{s}", .{queue_name}) catch
        return error.ArnTooLong;

    // Create SNS topic
    var topic_result = try sns.create_topic.execute(
        &sns_client,
        .{ .name = "sdk-zig-sub-test-topic" },
        .{},
    );
    defer topic_result.deinit();

    const topic_arn = topic_result.topic_arn orelse return error.MissingTopicArn;

    // Subscribe SQS queue to SNS topic
    var sub_result = try sns.subscribe.execute(
        &sns_client,
        .{ .topic_arn = topic_arn, .protocol = "sqs", .endpoint = queue_arn },
        .{},
    );
    defer sub_result.deinit();

    try std.testing.expect(sub_result.subscription_arn != null);

    // Publish a message
    var pub_result = try sns.publish.execute(
        &sns_client,
        .{ .topic_arn = topic_arn, .message = "SNS-to-SQS test message" },
        .{},
    );
    defer pub_result.deinit();

    // Receive from SQS
    var recv_result = try sqs.receive_message.execute(
        &sqs_client,
        .{ .queue_url = queue_url, .max_number_of_messages = 1, .wait_time_seconds = 10 },
        .{},
    );
    defer recv_result.deinit();

    const messages = recv_result.messages orelse return error.MissingMessages;
    try std.testing.expect(messages.len > 0);

    // The SQS message body is an SNS notification JSON envelope containing the message
    const body = messages[0].body orelse return error.MissingBody;
    try std.testing.expect(std.mem.indexOf(u8, body, "SNS-to-SQS test message") != null);

    // Cleanup
    {
        var r = try sns.delete_topic.execute(&sns_client, .{ .topic_arn = topic_arn }, .{});
        defer r.deinit();
    }
    {
        var r = try sqs.delete_queue.execute(&sqs_client, .{ .queue_url = queue_url }, .{});
        defer r.deinit();
    }
}

test "ListTopics includes created topic" {
    const allocator = std.testing.allocator;

    const endpoint_url = std.posix.getenv("AWS_ENDPOINT_URL") orelse
        return error.MissingEndpoint;

    var cfg = try aws.Config.load(allocator, .{
        .endpoint_url = endpoint_url,
    });
    defer cfg.deinit();

    var client = sns.Client.initWithOptions(allocator, &cfg, .{ .keep_alive = false });
    defer client.deinit();

    // --- CreateTopic ---
    var create_result = try sns.create_topic.execute(
        &client,
        .{ .name = "sdk-zig-sns-list-topics" },
        .{},
    );
    defer create_result.deinit();

    const topic_arn = create_result.topic_arn orelse return error.MissingTopicArn;

    // --- ListTopics ---
    var list_result = try sns.list_topics.execute(
        &client,
        .{},
        .{},
    );
    defer list_result.deinit();

    const topics = list_result.topics orelse return error.MissingTopics;
    var found = false;
    for (topics) |topic| {
        if (topic.topic_arn) |arn| {
            if (std.mem.eql(u8, arn, topic_arn)) {
                found = true;
                break;
            }
        }
    }
    try std.testing.expect(found);

    // --- Cleanup ---
    {
        var r = try sns.delete_topic.execute(&client, .{ .topic_arn = topic_arn }, .{});
        defer r.deinit();
    }
}

test "Publish with subject sets message_id" {
    const allocator = std.testing.allocator;

    const endpoint_url = std.posix.getenv("AWS_ENDPOINT_URL") orelse
        return error.MissingEndpoint;

    var cfg = try aws.Config.load(allocator, .{
        .endpoint_url = endpoint_url,
    });
    defer cfg.deinit();

    var client = sns.Client.initWithOptions(allocator, &cfg, .{ .keep_alive = false });
    defer client.deinit();

    // --- CreateTopic ---
    var create_result = try sns.create_topic.execute(
        &client,
        .{ .name = "sdk-zig-sns-publish-subject" },
        .{},
    );
    defer create_result.deinit();

    const topic_arn = create_result.topic_arn orelse return error.MissingTopicArn;

    // --- Publish with subject ---
    var pub_result = try sns.publish.execute(
        &client,
        .{
            .topic_arn = topic_arn,
            .message = "hello",
            .subject = "test subject",
        },
        .{},
    );
    defer pub_result.deinit();

    const message_id = pub_result.message_id orelse return error.MissingMessageId;
    try std.testing.expect(message_id.len > 0);

    // --- Cleanup ---
    {
        var r = try sns.delete_topic.execute(&client, .{ .topic_arn = topic_arn }, .{});
        defer r.deinit();
    }
}

test "ListSubscriptions returns subscription after Subscribe" {
    const allocator = std.testing.allocator;

    const endpoint_url = std.posix.getenv("AWS_ENDPOINT_URL") orelse
        return error.MissingEndpoint;

    var cfg = try aws.Config.load(allocator, .{
        .endpoint_url = endpoint_url,
    });
    defer cfg.deinit();

    var sns_client = sns.Client.initWithOptions(allocator, &cfg, .{ .keep_alive = false });
    defer sns_client.deinit();

    var sqs_client = sqs.Client.initWithOptions(allocator, &cfg, .{ .keep_alive = false });
    defer sqs_client.deinit();

    // --- CreateQueue (SQS) ---
    var queue_result = try sqs.create_queue.execute(
        &sqs_client,
        .{ .queue_name = "sdk-zig-sns-sub-list-queue" },
        .{},
    );
    defer queue_result.deinit();

    const queue_url = queue_result.queue_url orelse return error.MissingQueueUrl;
    const queue_arn = "arn:aws:sqs:us-east-1:000000000000:sdk-zig-sns-sub-list-queue";

    // --- CreateTopic ---
    var topic_result = try sns.create_topic.execute(
        &sns_client,
        .{ .name = "sdk-zig-sns-sub-list-topic" },
        .{},
    );
    defer topic_result.deinit();

    const topic_arn = topic_result.topic_arn orelse return error.MissingTopicArn;

    // --- Subscribe ---
    var sub_result = try sns.subscribe.execute(
        &sns_client,
        .{ .topic_arn = topic_arn, .protocol = "sqs", .endpoint = queue_arn },
        .{},
    );
    defer sub_result.deinit();

    // --- ListSubscriptions ---
    var list_result = try sns.list_subscriptions.execute(
        &sns_client,
        .{},
        .{},
    );
    defer list_result.deinit();

    const subscriptions = list_result.subscriptions orelse
        return error.MissingSubscriptions;
    try std.testing.expect(subscriptions.len > 0);

    // --- Cleanup ---
    {
        var r = try sns.delete_topic.execute(
            &sns_client,
            .{ .topic_arn = topic_arn },
            .{},
        );
        defer r.deinit();
    }
    {
        var r = try sqs.delete_queue.execute(
            &sqs_client,
            .{ .queue_url = queue_url },
            .{},
        );
        defer r.deinit();
    }
}
