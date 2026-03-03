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
    shared_cfg = try aws.Config.load(allocator, .{});
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
    {
        var arena = std.heap.ArenaAllocator.init(allocator);
        defer arena.deinit();
        const r = try shared_sns_client.?.createTopic(
            arena.allocator(),
            .{ .name = "sdk-zig-sns-shared" },
            .{},
        );
        const arn = r.topic_arn orelse return error.MissingTopicArn;
        @memcpy(shared_topic_arn_buf[0..arn.len], arn);
        shared_topic_arn = shared_topic_arn_buf[0..arn.len];
    }
}

test "zest.afterAll" {
    if (shared_sns_client) |*c| {
        if (shared_topic_arn.len > 0) {
            var arena = std.heap.ArenaAllocator.init(gpa.allocator());
            defer arena.deinit();
            _ = try c.deleteTopic(
                arena.allocator(),
                .{ .topic_arn = shared_topic_arn },
                .{},
            );
        }
        c.deinit();
    }
    if (shared_sqs_client) |*c| c.deinit();
    if (shared_cfg) |*cfg| cfg.deinit();
    try std.testing.expect(gpa.deinit() == .ok);
}

test "CreateTopic returns topic ARN" {
    var arena = std.heap.ArenaAllocator.init(gpa.allocator());
    defer arena.deinit();

    const create_result = try shared_sns_client.?.createTopic(
        arena.allocator(),
        .{ .name = "sdk-zig-sns-create" },
        .{},
    );

    const topic_arn = create_result.topic_arn orelse
        return error.MissingTopicArn;
    try std.testing.expect(topic_arn.len > 0);

    _ = try shared_sns_client.?.deleteTopic(
        arena.allocator(),
        .{ .topic_arn = topic_arn },
        .{},
    );
}

test "Publish to topic returns message ID" {
    var arena = std.heap.ArenaAllocator.init(gpa.allocator());
    defer arena.deinit();

    const pub_result = try shared_sns_client.?.publish(
        arena.allocator(),
        .{
            .topic_arn = shared_topic_arn,
            .message = "Hello from aws-sdk-zig!",
        },
        .{},
    );

    try std.testing.expect(pub_result.message_id != null);
}

test "DeleteTopic removes topic" {
    var arena = std.heap.ArenaAllocator.init(gpa.allocator());
    defer arena.deinit();

    const create_result = try shared_sns_client.?.createTopic(
        arena.allocator(),
        .{ .name = "sdk-zig-sns-delete" },
        .{},
    );

    const topic_arn = create_result.topic_arn orelse
        return error.MissingTopicArn;

    {
        _ = try shared_sns_client.?.deleteTopic(
            arena.allocator(),
            .{ .topic_arn = topic_arn },
            .{},
        );
    }

    const list_result = try shared_sns_client.?.listTopics(
        arena.allocator(),
        .{},
        .{},
    );

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
    var arena = std.heap.ArenaAllocator.init(gpa.allocator());
    defer arena.deinit();

    const queue_result = try shared_sqs_client.?.createQueue(
        arena.allocator(),
        .{ .queue_name = "sdk-zig-sns-sub-queue" },
        .{},
    );

    const queue_url = queue_result.queue_url orelse
        return error.MissingQueueUrl;

    const queue_name = "sdk-zig-sns-sub-queue";
    var arn_buf: [256]u8 = undefined;
    const queue_arn = std.fmt.bufPrint(
        &arn_buf,
        "arn:aws:sqs:us-east-1:000000000000:{s}",
        .{queue_name},
    ) catch return error.ArnTooLong;

    const topic_result = try shared_sns_client.?.createTopic(
        arena.allocator(),
        .{ .name = "sdk-zig-sub-test-topic" },
        .{},
    );

    const topic_arn = topic_result.topic_arn orelse
        return error.MissingTopicArn;

    const sub_result = try shared_sns_client.?.subscribe(
        arena.allocator(),
        .{
            .topic_arn = topic_arn,
            .protocol = "sqs",
            .endpoint = queue_arn,
        },
        .{},
    );

    try std.testing.expect(sub_result.subscription_arn != null);

    const pub_result = try shared_sns_client.?.publish(
        arena.allocator(),
        .{
            .topic_arn = topic_arn,
            .message = "SNS-to-SQS test message",
        },
        .{},
    );
    _ = pub_result;

    const recv_result = try shared_sqs_client.?.receiveMessage(
        arena.allocator(),
        .{
            .queue_url = queue_url,
            .max_number_of_messages = 1,
            .wait_time_seconds = 10,
        },
        .{},
    );

    const messages = recv_result.messages orelse
        return error.MissingMessages;
    try std.testing.expect(messages.len > 0);

    const body = messages[0].body orelse return error.MissingBody;
    try std.testing.expect(
        std.mem.indexOf(u8, body, "SNS-to-SQS test message") != null,
    );

    {
        _ = try shared_sns_client.?.deleteTopic(
            arena.allocator(),
            .{ .topic_arn = topic_arn },
            .{},
        );
    }
    {
        _ = try shared_sqs_client.?.deleteQueue(
            arena.allocator(),
            .{ .queue_url = queue_url },
            .{},
        );
    }
}

test "ListTopics includes created topic" {
    var arena = std.heap.ArenaAllocator.init(gpa.allocator());
    defer arena.deinit();

    const create_result = try shared_sns_client.?.createTopic(
        arena.allocator(),
        .{ .name = "sdk-zig-sns-list-topics" },
        .{},
    );

    const topic_arn = create_result.topic_arn orelse
        return error.MissingTopicArn;

    const list_result = try shared_sns_client.?.listTopics(
        arena.allocator(),
        .{},
        .{},
    );

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
        _ = try shared_sns_client.?.deleteTopic(
            arena.allocator(),
            .{ .topic_arn = topic_arn },
            .{},
        );
    }
}

test "Publish with subject sets message_id" {
    var arena = std.heap.ArenaAllocator.init(gpa.allocator());
    defer arena.deinit();

    const pub_result = try shared_sns_client.?.publish(
        arena.allocator(),
        .{
            .topic_arn = shared_topic_arn,
            .message = "hello",
            .subject = "test subject",
        },
        .{},
    );

    const message_id = pub_result.message_id orelse
        return error.MissingMessageId;
    try std.testing.expect(message_id.len > 0);
}

test "ListSubscriptions returns subscription after Subscribe" {
    var arena = std.heap.ArenaAllocator.init(gpa.allocator());
    defer arena.deinit();

    const queue_result = try shared_sqs_client.?.createQueue(
        arena.allocator(),
        .{ .queue_name = "sdk-zig-sns-sub-list-queue" },
        .{},
    );

    const queue_url = queue_result.queue_url orelse
        return error.MissingQueueUrl;
    const queue_arn =
        "arn:aws:sqs:us-east-1:000000000000:sdk-zig-sns-sub-list-queue";

    const topic_result = try shared_sns_client.?.createTopic(
        arena.allocator(),
        .{ .name = "sdk-zig-sns-sub-list-topic" },
        .{},
    );

    const topic_arn = topic_result.topic_arn orelse
        return error.MissingTopicArn;

    const sub_result = try shared_sns_client.?.subscribe(
        arena.allocator(),
        .{
            .topic_arn = topic_arn,
            .protocol = "sqs",
            .endpoint = queue_arn,
        },
        .{},
    );
    _ = sub_result;

    const list_result = try shared_sns_client.?.listSubscriptions(
        arena.allocator(),
        .{},
        .{},
    );

    const subscriptions = list_result.subscriptions orelse
        return error.MissingSubscriptions;
    try std.testing.expect(subscriptions.len > 0);

    {
        _ = try shared_sns_client.?.deleteTopic(
            arena.allocator(),
            .{ .topic_arn = topic_arn },
            .{},
        );
    }
    {
        _ = try shared_sqs_client.?.deleteQueue(
            arena.allocator(),
            .{ .queue_url = queue_url },
            .{},
        );
    }
}

test "Unsubscribe removes subscription" {
    var arena = std.heap.ArenaAllocator.init(gpa.allocator());
    defer arena.deinit();

    const topic_result = try shared_sns_client.?.createTopic(
        arena.allocator(),
        .{ .name = "sdk-zig-sns-unsub-topic" },
        .{},
    );

    const topic_arn = topic_result.topic_arn orelse
        return error.MissingTopicArn;

    const queue_result = try shared_sqs_client.?.createQueue(
        arena.allocator(),
        .{ .queue_name = "sdk-zig-sns-unsub-queue" },
        .{},
    );

    const queue_url = queue_result.queue_url orelse
        return error.MissingQueueUrl;
    const queue_arn =
        "arn:aws:sqs:us-east-1:000000000000:sdk-zig-sns-unsub-queue";

    const sub_result = try shared_sns_client.?.subscribe(
        arena.allocator(),
        .{
            .topic_arn = topic_arn,
            .protocol = "sqs",
            .endpoint = queue_arn,
        },
        .{},
    );

    const subscription_arn = sub_result.subscription_arn orelse
        return error.MissingSubscriptionArn;

    {
        _ = try shared_sns_client.?.unsubscribe(
            arena.allocator(),
            .{ .subscription_arn = subscription_arn },
            .{},
        );
    }

    const list_result = try shared_sns_client.?.listSubscriptionsByTopic(
        arena.allocator(),
        .{ .topic_arn = topic_arn },
        .{},
    );

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
        _ = try shared_sns_client.?.deleteTopic(
            arena.allocator(),
            .{ .topic_arn = topic_arn },
            .{},
        );
    }
    {
        _ = try shared_sqs_client.?.deleteQueue(
            arena.allocator(),
            .{ .queue_url = queue_url },
            .{},
        );
    }
}

test "GetTopicAttributes returns topic metadata" {
    var arena = std.heap.ArenaAllocator.init(gpa.allocator());
    defer arena.deinit();

    const attr_result = try shared_sns_client.?.getTopicAttributes(
        arena.allocator(),
        .{ .topic_arn = shared_topic_arn },
        .{},
    );

    try std.testing.expect(attr_result.attributes != null);
}

test "SetTopicAttributes updates display name" {
    var arena = std.heap.ArenaAllocator.init(gpa.allocator());
    defer arena.deinit();

    const create_result = try shared_sns_client.?.createTopic(
        arena.allocator(),
        .{ .name = "sdk-zig-sns-setattr" },
        .{},
    );

    const topic_arn = create_result.topic_arn orelse
        return error.MissingTopicArn;

    {
        _ = try shared_sns_client.?.setTopicAttributes(
            arena.allocator(),
            .{
                .topic_arn = topic_arn,
                .attribute_name = "DisplayName",
                .attribute_value = "My Updated Topic",
            },
            .{},
        );
    }

    const attr_result = try shared_sns_client.?.getTopicAttributes(
        arena.allocator(),
        .{ .topic_arn = topic_arn },
        .{},
    );

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
        _ = try shared_sns_client.?.deleteTopic(
            arena.allocator(),
            .{ .topic_arn = topic_arn },
            .{},
        );
    }
}

test "Publish to nonexistent topic returns error" {
    var arena = std.heap.ArenaAllocator.init(gpa.allocator());
    defer arena.deinit();

    const fake_arn =
        "arn:aws:sns:us-east-1:000000000000:does-not-exist";
    const result = shared_sns_client.?.publish(
        arena.allocator(),
        .{ .topic_arn = fake_arn, .message = "should fail" },
        .{},
    );
    try std.testing.expectError(error.ServiceError, result);
}

test "CreateTopic is idempotent" {
    var arena = std.heap.ArenaAllocator.init(gpa.allocator());
    defer arena.deinit();

    const first = try shared_sns_client.?.createTopic(
        arena.allocator(),
        .{ .name = "sdk-zig-sns-idempotent" },
        .{},
    );

    const first_arn = first.topic_arn orelse
        return error.MissingTopicArn;

    const second = try shared_sns_client.?.createTopic(
        arena.allocator(),
        .{ .name = "sdk-zig-sns-idempotent" },
        .{},
    );

    const second_arn = second.topic_arn orelse
        return error.MissingTopicArn;

    try std.testing.expectEqualStrings(first_arn, second_arn);

    {
        _ = try shared_sns_client.?.deleteTopic(
            arena.allocator(),
            .{ .topic_arn = first_arn },
            .{},
        );
    }
}

test "ListSubscriptionsByTopic returns scoped results" {
    var arena = std.heap.ArenaAllocator.init(gpa.allocator());
    defer arena.deinit();

    const topic_result = try shared_sns_client.?.createTopic(
        arena.allocator(),
        .{ .name = "sdk-zig-sns-listsub-bytopic" },
        .{},
    );

    const topic_arn = topic_result.topic_arn orelse
        return error.MissingTopicArn;

    const queue_result = try shared_sqs_client.?.createQueue(
        arena.allocator(),
        .{ .queue_name = "sdk-zig-sns-listsub-bt-q" },
        .{},
    );

    const queue_url = queue_result.queue_url orelse
        return error.MissingQueueUrl;
    const queue_arn =
        "arn:aws:sqs:us-east-1:000000000000:sdk-zig-sns-listsub-bt-q";

    const sub_result = try shared_sns_client.?.subscribe(
        arena.allocator(),
        .{
            .topic_arn = topic_arn,
            .protocol = "sqs",
            .endpoint = queue_arn,
        },
        .{},
    );
    _ = sub_result;

    const list_result = try shared_sns_client.?.listSubscriptionsByTopic(
        arena.allocator(),
        .{ .topic_arn = topic_arn },
        .{},
    );

    const subs = list_result.subscriptions orelse
        return error.MissingSubscriptions;
    try std.testing.expect(subs.len > 0);

    {
        _ = try shared_sns_client.?.deleteTopic(
            arena.allocator(),
            .{ .topic_arn = topic_arn },
            .{},
        );
    }
    {
        _ = try shared_sqs_client.?.deleteQueue(
            arena.allocator(),
            .{ .queue_url = queue_url },
            .{},
        );
    }
}
