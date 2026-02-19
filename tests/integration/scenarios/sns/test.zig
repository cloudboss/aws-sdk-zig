const std = @import("std");
const aws = @import("aws");
const sns = @import("sns");
const sqs = @import("sqs");

var gpa: std.heap.GeneralPurposeAllocator(.{}) = .init;

var shared_sns_client: ?sns.Client = null;
var shared_sqs_client: ?sqs.Client = null;
var shared_cfg: ?aws.Config = null;
var shared_topic_arn_buf: [512]u8 = undefined;
var shared_topic_arn: []const u8 = "";

test "zest.beforeAll" {
    const allocator = gpa.allocator();
    const endpoint_url = std.posix.getenv("AWS_ENDPOINT_URL") orelse
        return error.MissingEndpoint;
    shared_cfg = try aws.Config.load(
        allocator,
        .{ .endpoint_url = endpoint_url },
    );
    shared_sns_client = sns.Client.initWithOptions(
        allocator,
        &shared_cfg.?,
        .{ .keep_alive = false },
    );
    shared_sqs_client = sqs.Client.initWithOptions(
        allocator,
        &shared_cfg.?,
        .{ .keep_alive = false },
    );
    var r = try sns.create_topic.execute(
        &shared_sns_client.?,
        .{ .name = "sdk-zig-sns-shared" },
        .{},
    );
    defer r.deinit();
    const arn = r.topic_arn orelse return error.MissingTopicArn;
    @memcpy(shared_topic_arn_buf[0..arn.len], arn);
    shared_topic_arn = shared_topic_arn_buf[0..arn.len];
}

test "zest.afterAll" {
    defer _ = gpa.deinit();
    if (shared_sns_client) |*c| {
        if (shared_topic_arn.len > 0) {
            var r = try sns.delete_topic.execute(
                c,
                .{ .topic_arn = shared_topic_arn },
                .{},
            );
            defer r.deinit();
        }
        c.deinit();
    }
    if (shared_sqs_client) |*c| c.deinit();
    if (shared_cfg) |*cfg| cfg.deinit();
}

test "CreateTopic returns topic ARN" {
    var create_result = try sns.create_topic.execute(
        &shared_sns_client.?,
        .{ .name = "sdk-zig-sns-create" },
        .{},
    );
    defer create_result.deinit();

    const topic_arn = create_result.topic_arn orelse
        return error.MissingTopicArn;
    try std.testing.expect(topic_arn.len > 0);

    var del = try sns.delete_topic.execute(
        &shared_sns_client.?,
        .{ .topic_arn = topic_arn },
        .{},
    );
    defer del.deinit();
}

test "Publish to topic returns message ID" {
    var pub_result = try sns.publish.execute(
        &shared_sns_client.?,
        .{
            .topic_arn = shared_topic_arn,
            .message = "Hello from aws-sdk-zig!",
        },
        .{},
    );
    defer pub_result.deinit();

    try std.testing.expect(pub_result.message_id != null);
}

test "DeleteTopic removes topic" {
    var create_result = try sns.create_topic.execute(
        &shared_sns_client.?,
        .{ .name = "sdk-zig-sns-delete" },
        .{},
    );
    defer create_result.deinit();

    const topic_arn = create_result.topic_arn orelse
        return error.MissingTopicArn;

    {
        var del = try sns.delete_topic.execute(
            &shared_sns_client.?,
            .{ .topic_arn = topic_arn },
            .{},
        );
        defer del.deinit();
    }

    var list_result = try sns.list_topics.execute(
        &shared_sns_client.?,
        .{},
        .{},
    );
    defer list_result.deinit();

    if (list_result.topics) |topics| {
        for (topics) |topic| {
            if (topic.topic_arn) |arn| {
                if (std.mem.eql(u8, arn, topic_arn)) {
                    return error.TopicStillExists;
                }
            }
        }
    }
}

test "SNS delivers published message to SQS subscription" {
    var queue_result = try sqs.create_queue.execute(
        &shared_sqs_client.?,
        .{ .queue_name = "sdk-zig-sns-sub-queue" },
        .{},
    );
    defer queue_result.deinit();

    const queue_url = queue_result.queue_url orelse
        return error.MissingQueueUrl;

    const queue_name = "sdk-zig-sns-sub-queue";
    var arn_buf: [256]u8 = undefined;
    const queue_arn = std.fmt.bufPrint(
        &arn_buf,
        "arn:aws:sqs:us-east-1:000000000000:{s}",
        .{queue_name},
    ) catch return error.ArnTooLong;

    var topic_result = try sns.create_topic.execute(
        &shared_sns_client.?,
        .{ .name = "sdk-zig-sub-test-topic" },
        .{},
    );
    defer topic_result.deinit();

    const topic_arn = topic_result.topic_arn orelse
        return error.MissingTopicArn;

    var sub_result = try sns.subscribe.execute(
        &shared_sns_client.?,
        .{
            .topic_arn = topic_arn,
            .protocol = "sqs",
            .endpoint = queue_arn,
        },
        .{},
    );
    defer sub_result.deinit();

    try std.testing.expect(sub_result.subscription_arn != null);

    var pub_result = try sns.publish.execute(
        &shared_sns_client.?,
        .{
            .topic_arn = topic_arn,
            .message = "SNS-to-SQS test message",
        },
        .{},
    );
    defer pub_result.deinit();

    var recv_result = try sqs.receive_message.execute(
        &shared_sqs_client.?,
        .{
            .queue_url = queue_url,
            .max_number_of_messages = 1,
            .wait_time_seconds = 10,
        },
        .{},
    );
    defer recv_result.deinit();

    const messages = recv_result.messages orelse
        return error.MissingMessages;
    try std.testing.expect(messages.len > 0);

    const body = messages[0].body orelse return error.MissingBody;
    try std.testing.expect(
        std.mem.indexOf(u8, body, "SNS-to-SQS test message") != null,
    );

    {
        var r = try sns.delete_topic.execute(
            &shared_sns_client.?,
            .{ .topic_arn = topic_arn },
            .{},
        );
        defer r.deinit();
    }
    {
        var r = try sqs.delete_queue.execute(
            &shared_sqs_client.?,
            .{ .queue_url = queue_url },
            .{},
        );
        defer r.deinit();
    }
}

test "ListTopics includes created topic" {
    var create_result = try sns.create_topic.execute(
        &shared_sns_client.?,
        .{ .name = "sdk-zig-sns-list-topics" },
        .{},
    );
    defer create_result.deinit();

    const topic_arn = create_result.topic_arn orelse
        return error.MissingTopicArn;

    var list_result = try sns.list_topics.execute(
        &shared_sns_client.?,
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

    {
        var r = try sns.delete_topic.execute(
            &shared_sns_client.?,
            .{ .topic_arn = topic_arn },
            .{},
        );
        defer r.deinit();
    }
}

test "Publish with subject sets message_id" {
    var pub_result = try sns.publish.execute(
        &shared_sns_client.?,
        .{
            .topic_arn = shared_topic_arn,
            .message = "hello",
            .subject = "test subject",
        },
        .{},
    );
    defer pub_result.deinit();

    const message_id = pub_result.message_id orelse
        return error.MissingMessageId;
    try std.testing.expect(message_id.len > 0);
}

test "ListSubscriptions returns subscription after Subscribe" {
    var queue_result = try sqs.create_queue.execute(
        &shared_sqs_client.?,
        .{ .queue_name = "sdk-zig-sns-sub-list-queue" },
        .{},
    );
    defer queue_result.deinit();

    const queue_url = queue_result.queue_url orelse
        return error.MissingQueueUrl;
    const queue_arn =
        "arn:aws:sqs:us-east-1:000000000000:sdk-zig-sns-sub-list-queue";

    var topic_result = try sns.create_topic.execute(
        &shared_sns_client.?,
        .{ .name = "sdk-zig-sns-sub-list-topic" },
        .{},
    );
    defer topic_result.deinit();

    const topic_arn = topic_result.topic_arn orelse
        return error.MissingTopicArn;

    var sub_result = try sns.subscribe.execute(
        &shared_sns_client.?,
        .{
            .topic_arn = topic_arn,
            .protocol = "sqs",
            .endpoint = queue_arn,
        },
        .{},
    );
    defer sub_result.deinit();

    var list_result = try sns.list_subscriptions.execute(
        &shared_sns_client.?,
        .{},
        .{},
    );
    defer list_result.deinit();

    const subscriptions = list_result.subscriptions orelse
        return error.MissingSubscriptions;
    try std.testing.expect(subscriptions.len > 0);

    {
        var r = try sns.delete_topic.execute(
            &shared_sns_client.?,
            .{ .topic_arn = topic_arn },
            .{},
        );
        defer r.deinit();
    }
    {
        var r = try sqs.delete_queue.execute(
            &shared_sqs_client.?,
            .{ .queue_url = queue_url },
            .{},
        );
        defer r.deinit();
    }
}

test "Unsubscribe removes subscription" {
    var topic_result = try sns.create_topic.execute(
        &shared_sns_client.?,
        .{ .name = "sdk-zig-sns-unsub-topic" },
        .{},
    );
    defer topic_result.deinit();

    const topic_arn = topic_result.topic_arn orelse
        return error.MissingTopicArn;

    var queue_result = try sqs.create_queue.execute(
        &shared_sqs_client.?,
        .{ .queue_name = "sdk-zig-sns-unsub-queue" },
        .{},
    );
    defer queue_result.deinit();

    const queue_url = queue_result.queue_url orelse
        return error.MissingQueueUrl;
    const queue_arn =
        "arn:aws:sqs:us-east-1:000000000000:sdk-zig-sns-unsub-queue";

    var sub_result = try sns.subscribe.execute(
        &shared_sns_client.?,
        .{
            .topic_arn = topic_arn,
            .protocol = "sqs",
            .endpoint = queue_arn,
        },
        .{},
    );
    defer sub_result.deinit();

    const subscription_arn = sub_result.subscription_arn orelse
        return error.MissingSubscriptionArn;

    {
        var r = try sns.unsubscribe.execute(
            &shared_sns_client.?,
            .{ .subscription_arn = subscription_arn },
            .{},
        );
        defer r.deinit();
    }

    var list_result = try sns.list_subscriptions_by_topic.execute(
        &shared_sns_client.?,
        .{ .topic_arn = topic_arn },
        .{},
    );
    defer list_result.deinit();

    if (list_result.subscriptions) |subs| {
        for (subs) |sub| {
            if (sub.subscription_arn) |arn| {
                if (std.mem.eql(u8, arn, subscription_arn)) {
                    return error.SubscriptionStillExists;
                }
            }
        }
    }

    {
        var r = try sns.delete_topic.execute(
            &shared_sns_client.?,
            .{ .topic_arn = topic_arn },
            .{},
        );
        defer r.deinit();
    }
    {
        var r = try sqs.delete_queue.execute(
            &shared_sqs_client.?,
            .{ .queue_url = queue_url },
            .{},
        );
        defer r.deinit();
    }
}

test "GetTopicAttributes returns topic metadata" {
    var attr_result = try sns.get_topic_attributes.execute(
        &shared_sns_client.?,
        .{ .topic_arn = shared_topic_arn },
        .{},
    );
    defer attr_result.deinit();

    try std.testing.expect(attr_result.attributes != null);
}

test "SetTopicAttributes updates display name" {
    var create_result = try sns.create_topic.execute(
        &shared_sns_client.?,
        .{ .name = "sdk-zig-sns-setattr" },
        .{},
    );
    defer create_result.deinit();

    const topic_arn = create_result.topic_arn orelse
        return error.MissingTopicArn;

    {
        var r = try sns.set_topic_attributes.execute(
            &shared_sns_client.?,
            .{
                .topic_arn = topic_arn,
                .attribute_name = "DisplayName",
                .attribute_value = "My Updated Topic",
            },
            .{},
        );
        defer r.deinit();
    }

    var attr_result = try sns.get_topic_attributes.execute(
        &shared_sns_client.?,
        .{ .topic_arn = topic_arn },
        .{},
    );
    defer attr_result.deinit();

    const attrs = attr_result.attributes orelse
        return error.MissingAttributes;
    var found = false;
    for (attrs) |entry| {
        if (std.mem.eql(u8, entry.key, "DisplayName")) {
            try std.testing.expectEqualStrings(
                "My Updated Topic",
                entry.value,
            );
            found = true;
            break;
        }
    }
    try std.testing.expect(found);

    {
        var r = try sns.delete_topic.execute(
            &shared_sns_client.?,
            .{ .topic_arn = topic_arn },
            .{},
        );
        defer r.deinit();
    }
}

test "Publish to nonexistent topic returns error" {
    const fake_arn =
        "arn:aws:sns:us-east-1:000000000000:does-not-exist";
    const result = sns.publish.execute(
        &shared_sns_client.?,
        .{ .topic_arn = fake_arn, .message = "should fail" },
        .{},
    );
    try std.testing.expectError(error.ServiceError, result);
}

test "CreateTopic is idempotent" {
    var first = try sns.create_topic.execute(
        &shared_sns_client.?,
        .{ .name = "sdk-zig-sns-idempotent" },
        .{},
    );
    defer first.deinit();

    const first_arn = first.topic_arn orelse
        return error.MissingTopicArn;

    var second = try sns.create_topic.execute(
        &shared_sns_client.?,
        .{ .name = "sdk-zig-sns-idempotent" },
        .{},
    );
    defer second.deinit();

    const second_arn = second.topic_arn orelse
        return error.MissingTopicArn;

    try std.testing.expectEqualStrings(first_arn, second_arn);

    {
        var r = try sns.delete_topic.execute(
            &shared_sns_client.?,
            .{ .topic_arn = first_arn },
            .{},
        );
        defer r.deinit();
    }
}

test "ListSubscriptionsByTopic returns scoped results" {
    var topic_result = try sns.create_topic.execute(
        &shared_sns_client.?,
        .{ .name = "sdk-zig-sns-listsub-bytopic" },
        .{},
    );
    defer topic_result.deinit();

    const topic_arn = topic_result.topic_arn orelse
        return error.MissingTopicArn;

    var queue_result = try sqs.create_queue.execute(
        &shared_sqs_client.?,
        .{ .queue_name = "sdk-zig-sns-listsub-bt-q" },
        .{},
    );
    defer queue_result.deinit();

    const queue_url = queue_result.queue_url orelse
        return error.MissingQueueUrl;
    const queue_arn =
        "arn:aws:sqs:us-east-1:000000000000:sdk-zig-sns-listsub-bt-q";

    var sub_result = try sns.subscribe.execute(
        &shared_sns_client.?,
        .{
            .topic_arn = topic_arn,
            .protocol = "sqs",
            .endpoint = queue_arn,
        },
        .{},
    );
    defer sub_result.deinit();

    var list_result = try sns.list_subscriptions_by_topic.execute(
        &shared_sns_client.?,
        .{ .topic_arn = topic_arn },
        .{},
    );
    defer list_result.deinit();

    const subs = list_result.subscriptions orelse
        return error.MissingSubscriptions;
    try std.testing.expect(subs.len > 0);

    {
        var r = try sns.delete_topic.execute(
            &shared_sns_client.?,
            .{ .topic_arn = topic_arn },
            .{},
        );
        defer r.deinit();
    }
    {
        var r = try sqs.delete_queue.execute(
            &shared_sqs_client.?,
            .{ .queue_url = queue_url },
            .{},
        );
        defer r.deinit();
    }
}
