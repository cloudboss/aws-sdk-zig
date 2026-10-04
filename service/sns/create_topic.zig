const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Tag = @import("tag.zig").Tag;
const serde = @import("serde.zig");

pub const CreateTopicInput = struct {
    /// A map of attributes with their corresponding values.
    ///
    /// The following lists names, descriptions, and values of the special request
    /// parameters
    /// that the `CreateTopic` action uses:
    ///
    /// * `DeliveryPolicy` – The policy that defines how Amazon SNS retries
    /// failed deliveries to HTTP/S endpoints.
    ///
    /// * `DisplayName` – The display name to use for a topic with SMS
    /// subscriptions.
    ///
    /// * `Policy` – The policy that defines who can access your
    /// topic. By default, only the topic owner can publish or subscribe to the
    /// topic.
    ///
    /// * `TracingConfig` – Tracing mode of an Amazon SNS topic. By default
    /// `TracingConfig` is set to `PassThrough`, and the topic
    /// passes through the tracing header it receives from an Amazon SNS publisher
    /// to its
    /// subscriptions. If set to `Active`, Amazon SNS will vend X-Ray segment data
    /// to topic owner account if the sampled flag in the tracing header is true.
    /// This
    /// is only supported on standard topics.
    ///
    /// * HTTP
    ///
    /// * `HTTPSuccessFeedbackRoleArn` – Indicates successful
    /// message delivery status for an Amazon SNS topic that is subscribed to an
    /// HTTP
    /// endpoint.
    ///
    /// * `HTTPSuccessFeedbackSampleRate` – Indicates
    /// percentage of successful messages to sample for an Amazon SNS topic that is
    /// subscribed to an HTTP endpoint.
    ///
    /// * `HTTPFailureFeedbackRoleArn` – Indicates failed
    /// message delivery status for an Amazon SNS topic that is subscribed to an
    /// HTTP
    /// endpoint.
    ///
    /// * Amazon Data Firehose
    ///
    /// * `FirehoseSuccessFeedbackRoleArn` – Indicates
    /// successful message delivery status for an Amazon SNS topic that is
    /// subscribed
    /// to an Amazon Data Firehose endpoint.
    ///
    /// * `FirehoseSuccessFeedbackSampleRate` – Indicates
    /// percentage of successful messages to sample for an Amazon SNS topic that is
    /// subscribed to an Amazon Data Firehose endpoint.
    ///
    /// * `FirehoseFailureFeedbackRoleArn` – Indicates failed
    /// message delivery status for an Amazon SNS topic that is subscribed to an
    /// Amazon Data Firehose endpoint.
    ///
    /// * Lambda
    ///
    /// * `LambdaSuccessFeedbackRoleArn` – Indicates
    /// successful message delivery status for an Amazon SNS topic that is
    /// subscribed
    /// to an Lambda endpoint.
    ///
    /// * `LambdaSuccessFeedbackSampleRate` – Indicates
    /// percentage of successful messages to sample for an Amazon SNS topic that is
    /// subscribed to an Lambda endpoint.
    ///
    /// * `LambdaFailureFeedbackRoleArn` – Indicates failed
    /// message delivery status for an Amazon SNS topic that is subscribed to an
    /// Lambda endpoint.
    ///
    /// * Platform application endpoint
    ///
    /// * `ApplicationSuccessFeedbackRoleArn` – Indicates
    /// successful message delivery status for an Amazon SNS topic that is
    /// subscribed
    /// to a platform application endpoint.
    ///
    /// * `ApplicationSuccessFeedbackSampleRate` – Indicates
    /// percentage of successful messages to sample for an Amazon SNS topic that is
    /// subscribed to an platform application endpoint.
    ///
    /// * `ApplicationFailureFeedbackRoleArn` – Indicates
    /// failed message delivery status for an Amazon SNS topic that is subscribed to
    /// an platform application endpoint.
    ///
    /// In addition to being able to configure topic attributes for message
    /// delivery status of notification messages sent to Amazon SNS application
    /// endpoints, you can also configure application attributes for the delivery
    /// status of push notification messages sent to push notification
    /// services.
    ///
    /// For example, For more information, see [Using Amazon SNS Application
    /// Attributes for Message Delivery
    /// Status](https://docs.aws.amazon.com/sns/latest/dg/sns-msg-status.html).
    ///
    /// * Amazon SQS
    ///
    /// * `SQSSuccessFeedbackRoleArn` – Indicates successful
    /// message delivery status for an Amazon SNS topic that is subscribed to an
    /// Amazon SQS endpoint.
    ///
    /// * `SQSSuccessFeedbackSampleRate` – Indicates
    /// percentage of successful messages to sample for an Amazon SNS topic that is
    /// subscribed to an Amazon SQS endpoint.
    ///
    /// * `SQSFailureFeedbackRoleArn` – Indicates failed
    /// message delivery status for an Amazon SNS topic that is subscribed to an
    /// Amazon SQS endpoint.
    ///
    /// The SuccessFeedbackRoleArn and FailureFeedbackRoleArn
    /// attributes are used to give Amazon SNS write access to use CloudWatch Logs
    /// on your
    /// behalf. The SuccessFeedbackSampleRate attribute is for specifying the
    /// sample rate percentage (0-100) of successfully delivered messages. After you
    /// configure the FailureFeedbackRoleArn attribute, then all failed message
    /// deliveries generate CloudWatch Logs.
    ///
    /// The following attribute applies only to [server-side
    /// encryption](https://docs.aws.amazon.com/sns/latest/dg/sns-server-side-encryption.html):
    ///
    /// * `KmsMasterKeyId` – The ID of an Amazon Web Services managed customer
    ///   master
    /// key (CMK) for Amazon SNS or a custom CMK. For more information, see [Key
    /// Terms](https://docs.aws.amazon.com/sns/latest/dg/sns-server-side-encryption.html#sse-key-terms). For more examples, see [KeyId](https://docs.aws.amazon.com/kms/latest/APIReference/API_DescribeKey.html#API_DescribeKey_RequestParameters) in the *Key Management Service API Reference*.
    ///
    /// The following attributes apply only to [FIFO
    /// topics](https://docs.aws.amazon.com/sns/latest/dg/sns-fifo-topics.html):
    ///
    /// * `ArchivePolicy` – The policy that sets the retention period
    /// for messages stored in the message archive of an Amazon SNS FIFO
    /// topic.
    ///
    /// * `ContentBasedDeduplication` – Enables content-based
    /// deduplication for FIFO topics.
    ///
    /// * By default, `ContentBasedDeduplication` is set to
    /// `false`. If you create a FIFO topic and this attribute is
    /// `false`, you must specify a value for the
    /// `MessageDeduplicationId` parameter for the
    /// [Publish](https://docs.aws.amazon.com/sns/latest/api/API_Publish.html)
    /// action.
    ///
    /// * When you set `ContentBasedDeduplication` to
    /// `true`, Amazon SNS uses a SHA-256 hash to
    /// generate the `MessageDeduplicationId` using the body of the
    /// message (but not the attributes of the message).
    ///
    /// (Optional) To override the generated value, you can specify a value
    /// for the `MessageDeduplicationId` parameter for the
    /// `Publish` action.
    ///
    /// * `FifoThroughputScope` – Enables higher throughput for your FIFO topic by
    ///   adjusting the scope of deduplication. This attribute has two possible
    ///   values:
    ///
    /// * `Topic` – The scope of message deduplication is across the entire topic.
    ///   This is the default value and maintains existing behavior, with a maximum
    ///   throughput of 3000 messages per second or 20MB per second, whichever comes
    ///   first.
    ///
    /// * `MessageGroup` – The scope of deduplication is within each individual
    ///   message group, which enables higher throughput per topic subject to
    ///   regional quotas. For more information on quotas or to request an increase,
    ///   see [Amazon SNS service
    ///   quotas](https://docs.aws.amazon.com/general/latest/gr/sns.html) in the
    ///   Amazon Web Services General Reference.
    attributes: ?[]const aws.map.StringMapEntry = null,

    /// The body of the policy document you want to use for this topic.
    ///
    /// You can only add one policy per topic.
    ///
    /// The policy must be in JSON string format.
    ///
    /// Length Constraints: Maximum length of 30,720.
    data_protection_policy: ?[]const u8 = null,

    /// The name of the topic you want to create.
    ///
    /// Constraints: Topic names must be made up of only uppercase and lowercase
    /// ASCII
    /// letters, numbers, underscores, and hyphens, and must be between 1 and 256
    /// characters
    /// long.
    ///
    /// For a FIFO (first-in-first-out) topic, the name must end with the `.fifo`
    /// suffix.
    name: []const u8,

    /// The list of tags to add to a new topic.
    ///
    /// To be able to tag a topic on creation, you must have the
    /// `sns:CreateTopic` and `sns:TagResource`
    /// permissions.
    tags: ?[]const Tag = null,
};

pub const CreateTopicOutput = struct {
    /// The Amazon Resource Name (ARN) assigned to the created topic.
    topic_arn: ?[]const u8 = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateTopicInput, options: CallOptions) !CreateTopicOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "sns", client.config.http_client.clock_skew_offset);

    var response = try client.config.http_client.sendRequestWithOptions(&request, client.options);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = try parseErrorResponse(client.allocator, response.body, response.status);
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: CreateTopicInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("sns", "SNS", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=CreateTopic&Version=2010-03-31");
    if (input.attributes) |entries| {
        for (entries, 0..) |entry, idx| {
            const n = idx + 1;
            {
                var prefix_buf: [256]u8 = undefined;
                const key_prefix = std.fmt.bufPrint(&prefix_buf, "&Attributes.entry.{d}.key=", .{n}) catch continue;
                try body_buf.appendSlice(allocator, key_prefix);
                try aws.url.appendUrlEncoded(allocator, &body_buf, entry.key);
            }
            {
                var prefix_buf: [256]u8 = undefined;
                const val_prefix = std.fmt.bufPrint(&prefix_buf, "&Attributes.entry.{d}.value=", .{n}) catch continue;
                try body_buf.appendSlice(allocator, val_prefix);
                try aws.url.appendUrlEncoded(allocator, &body_buf, entry.value);
            }
        }
    }
    if (input.data_protection_policy) |v| {
        try body_buf.appendSlice(allocator, "&DataProtectionPolicy=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    try body_buf.appendSlice(allocator, "&Name=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.name);
    if (input.tags) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Tags.member.{d}.Key=", .{n}) catch continue;
                try body_buf.appendSlice(allocator, field_prefix);
                try aws.url.appendUrlEncoded(allocator, &body_buf, item.key);
            }
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Tags.member.{d}.Value=", .{n}) catch continue;
                try body_buf.appendSlice(allocator, field_prefix);
                try aws.url.appendUrlEncoded(allocator, &body_buf, item.value);
            }
        }
    }

    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-www-form-urlencoded");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateTopicOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "CreateTopicResult")) break;
            },
            else => {},
        }
    }

    var result: CreateTopicOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "TopicArn")) {
                    result.topic_arn = try allocator.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }

    return result;
}
