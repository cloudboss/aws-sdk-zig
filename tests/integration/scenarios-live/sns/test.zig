const std = @import("std");
const aws = @import("aws");
const sns = @import("sns");
const sqs = @import("sqs");

var gpa: std.heap.GeneralPurposeAllocator(.{}) = .init;
var shared_sns_client: ?sns.Client = null;
var shared_sqs_client: ?sqs.Client = null;
var shared_cfg: ?aws.Config = null;
var shared_topic_arn_buf: [256]u8 = undefined;
var shared_topic_arn: []const u8 = "";
var shared_queue_url_buf: [512]u8 = undefined;
var shared_queue_url: []const u8 = "";
var shared_queue_arn_buf: [256]u8 = undefined;
var shared_queue_arn: []const u8 = "";
var shared_sub_arn_buf: [256]u8 = undefined;
var shared_sub_arn: []const u8 = "";

test "zest.beforeAll" {
    const allocator = gpa.allocator();
    shared_cfg = try aws.Config.load(allocator, .{});
    shared_sns_client = sns.Client.init(allocator, &shared_cfg.?);
    shared_sqs_client = sqs.Client.init(allocator, &shared_cfg.?);
    {
        var arena = std.heap.ArenaAllocator.init(allocator);
        defer arena.deinit();

        var topic_name_buf: [64]u8 = undefined;
        const topic_name = try std.fmt.bufPrint(
            &topic_name_buf,
            "sdk-zig-live-sns-{d}",
            .{std.time.timestamp()},
        );

        const topic_r = try shared_sns_client.?.createTopic(
            arena.allocator(),
            .{ .name = topic_name },
            .{},
        );
        const arn = topic_r.topic_arn orelse
            return error.MissingTopicArn;
        @memcpy(shared_topic_arn_buf[0..arn.len], arn);
        shared_topic_arn = shared_topic_arn_buf[0..arn.len];

        _ = try shared_sns_client.?.tagResource(
            arena.allocator(),
            .{
                .resource_arn = shared_topic_arn,
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

        var queue_name_buf: [64]u8 = undefined;
        const queue_name = try std.fmt.bufPrint(
            &queue_name_buf,
            "sdk-zig-live-sns-sqs-{d}",
            .{std.time.timestamp()},
        );

        const queue_r = try shared_sqs_client.?.createQueue(
            arena.allocator(),
            .{ .queue_name = queue_name },
            .{},
        );
        const url = queue_r.queue_url orelse
            return error.MissingQueueUrl;
        @memcpy(shared_queue_url_buf[0..url.len], url);
        shared_queue_url = shared_queue_url_buf[0..url.len];

        const q_attrs = try shared_sqs_client.?.getQueueAttributes(
            arena.allocator(),
            .{
                .queue_url = shared_queue_url,
                .attribute_names = &.{.queue_arn},
            },
            .{},
        );
        const attrs = q_attrs.attributes orelse
            return error.MissingAttributes;
        for (attrs) |entry| {
            if (std.mem.eql(u8, entry.key, "QueueArn")) {
                const v = entry.value;
                @memcpy(
                    shared_queue_arn_buf[0..v.len],
                    v,
                );
                shared_queue_arn =
                    shared_queue_arn_buf[0..v.len];
                break;
            }
        }
        if (shared_queue_arn.len == 0)
            return error.MissingQueueArn;

        _ = try shared_sqs_client.?.tagQueue(
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
    if (shared_sns_client) |*c| {
        defer c.deinit();
        var arena = std.heap.ArenaAllocator.init(gpa.allocator());
        defer arena.deinit();

        if (shared_topic_arn.len > 0) {
            const list_r = c.listSubscriptionsByTopic(
                arena.allocator(),
                .{ .topic_arn = shared_topic_arn },
                .{},
            ) catch null;
            if (list_r) |r| {
                if (r.subscriptions) |subs| {
                    for (subs) |sub| {
                        if (sub.subscription_arn) |sa| {
                            if (std.mem.eql(
                                u8,
                                sa,
                                "PendingConfirmation",
                            )) continue;
                            _ = c.unsubscribe(
                                arena.allocator(),
                                .{
                                    .subscription_arn = sa,
                                },
                                .{},
                            ) catch {};
                        }
                    }
                }
            }

            _ = c.deleteTopic(
                arena.allocator(),
                .{ .topic_arn = shared_topic_arn },
                .{},
            ) catch {};
        }
    }
    if (shared_sqs_client) |*c| {
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

test "listTopics includes created topic" {
    var arena = std.heap.ArenaAllocator.init(std.testing.allocator);
    defer arena.deinit();

    const list_result = try shared_sns_client.?.listTopics(
        arena.allocator(),
        .{},
        .{},
    );

    const topics = list_result.topics orelse
        return error.MissingTopics;
    var found = false;
    for (topics) |topic| {
        if (topic.topic_arn) |arn| {
            if (std.mem.eql(u8, arn, shared_topic_arn)) {
                found = true;
                break;
            }
        }
    }
    try std.testing.expect(found);
}

test "getTopicAttributes returns attributes" {
    var arena = std.heap.ArenaAllocator.init(std.testing.allocator);
    defer arena.deinit();

    const attr_result =
        try shared_sns_client.?.getTopicAttributes(
            arena.allocator(),
            .{ .topic_arn = shared_topic_arn },
            .{},
        );

    try std.testing.expect(attr_result.attributes != null);
}

test "setTopicAttributes updates display name" {
    var arena = std.heap.ArenaAllocator.init(std.testing.allocator);
    defer arena.deinit();

    _ = try shared_sns_client.?.setTopicAttributes(
        arena.allocator(),
        .{
            .topic_arn = shared_topic_arn,
            .attribute_name = "DisplayName",
            .attribute_value = "Live SNS Test Topic",
        },
        .{},
    );

    const attr_result =
        try shared_sns_client.?.getTopicAttributes(
            arena.allocator(),
            .{ .topic_arn = shared_topic_arn },
            .{},
        );

    const attrs = attr_result.attributes orelse
        return error.MissingAttributes;
    var found = false;
    for (attrs) |entry| {
        if (std.mem.eql(u8, entry.key, "DisplayName")) {
            try std.testing.expectEqualStrings(
                "Live SNS Test Topic",
                entry.value,
            );
            found = true;
            break;
        }
    }
    try std.testing.expect(found);
}

test "subscribe creates a subscription" {
    var arena = std.heap.ArenaAllocator.init(std.testing.allocator);
    defer arena.deinit();

    const sub_result = try shared_sns_client.?.subscribe(
        arena.allocator(),
        .{
            .topic_arn = shared_topic_arn,
            .protocol = "sqs",
            .endpoint = shared_queue_arn,
        },
        .{},
    );

    const sa = sub_result.subscription_arn orelse
        return error.MissingSubscriptionArn;
    @memcpy(shared_sub_arn_buf[0..sa.len], sa);
    shared_sub_arn = shared_sub_arn_buf[0..sa.len];
    try std.testing.expect(shared_sub_arn.len > 0);
}

test "listSubscriptionsByTopic returns subscription" {
    var arena = std.heap.ArenaAllocator.init(std.testing.allocator);
    defer arena.deinit();

    const list_result =
        try shared_sns_client.?.listSubscriptionsByTopic(
            arena.allocator(),
            .{ .topic_arn = shared_topic_arn },
            .{},
        );

    const subs = list_result.subscriptions orelse
        return error.MissingSubscriptions;
    var found = false;
    for (subs) |sub| {
        if (sub.subscription_arn) |arn| {
            if (std.mem.eql(u8, arn, shared_sub_arn)) {
                found = true;
                break;
            }
        }
    }
    try std.testing.expect(found);
}

test "publish sends a message" {
    var arena = std.heap.ArenaAllocator.init(std.testing.allocator);
    defer arena.deinit();

    const pub_result = try shared_sns_client.?.publish(
        arena.allocator(),
        .{
            .topic_arn = shared_topic_arn,
            .message = "Hello from aws-sdk-zig live test!",
        },
        .{},
    );

    try std.testing.expect(pub_result.message_id != null);
}

test "tagResource and listTagsForResource" {
    var arena = std.heap.ArenaAllocator.init(std.testing.allocator);
    defer arena.deinit();

    _ = try shared_sns_client.?.tagResource(
        arena.allocator(),
        .{
            .resource_arn = shared_topic_arn,
            .tags = &.{
                .{
                    .key = "extra-tag",
                    .value = "extra-value",
                },
            },
        },
        .{},
    );

    const tag_result =
        try shared_sns_client.?.listTagsForResource(
            arena.allocator(),
            .{ .resource_arn = shared_topic_arn },
            .{},
        );

    const tags = tag_result.tags orelse
        return error.MissingTags;
    var found = false;
    for (tags) |tag| {
        if (std.mem.eql(u8, tag.key, "extra-tag")) {
            try std.testing.expectEqualStrings(
                "extra-value",
                tag.value,
            );
            found = true;
            break;
        }
    }
    try std.testing.expect(found);
}

test "unsubscribe removes subscription" {
    var arena = std.heap.ArenaAllocator.init(std.testing.allocator);
    defer arena.deinit();

    _ = try shared_sns_client.?.unsubscribe(
        arena.allocator(),
        .{ .subscription_arn = shared_sub_arn },
        .{},
    );

    const list_result =
        try shared_sns_client.?.listSubscriptionsByTopic(
            arena.allocator(),
            .{ .topic_arn = shared_topic_arn },
            .{},
        );

    if (list_result.subscriptions) |subs| {
        for (subs) |sub| {
            if (sub.subscription_arn) |arn| {
                if (std.mem.eql(
                    u8,
                    arn,
                    shared_sub_arn,
                )) {
                    return error.SubscriptionStillExists;
                }
            }
        }
    }
}
