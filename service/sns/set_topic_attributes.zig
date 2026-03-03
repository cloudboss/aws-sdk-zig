const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;

pub const SetTopicAttributesInput = struct {
    /// A map of attributes with their corresponding values.
    ///
    /// The following lists the names, descriptions, and values of the special
    /// request
    /// parameters that the `SetTopicAttributes` action uses:
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
    /// to an platform application endpoint.
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
    /// The following attribute applies only to
    /// [server-side-encryption](https://docs.aws.amazon.com/sns/latest/dg/sns-server-side-encryption.html):
    ///
    /// * `KmsMasterKeyId` – The ID of an Amazon Web Services managed customer
    ///   master
    /// key (CMK) for Amazon SNS or a custom CMK. For more information, see [Key
    /// Terms](https://docs.aws.amazon.com/sns/latest/dg/sns-server-side-encryption.html#sse-key-terms). For more examples, see [KeyId](https://docs.aws.amazon.com/kms/latest/APIReference/API_DescribeKey.html#API_DescribeKey_RequestParameters) in the *Key Management Service API Reference*.
    ///
    /// * `SignatureVersion` – The signature version corresponds to the
    /// hashing algorithm used while creating the signature of the notifications,
    /// subscription confirmations, or unsubscribe confirmation messages sent by
    /// Amazon SNS.
    /// By default, `SignatureVersion` is set to `1`.
    ///
    /// The following attribute applies only to [FIFO
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
    attribute_name: []const u8,

    /// The new value for the attribute.
    attribute_value: ?[]const u8 = null,

    /// The ARN of the topic to modify.
    topic_arn: []const u8,
};

pub const SetTopicAttributesOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: SetTopicAttributesInput, options: CallOptions) !SetTopicAttributesOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "sns");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: SetTopicAttributesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("sns", "SNS", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(allocator, "Action=SetTopicAttributes&Version=2010-03-31");
    try body_buf.appendSlice(allocator, "&AttributeName=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.attribute_name);
    if (input.attribute_value) |v| {
        try body_buf.appendSlice(allocator, "&AttributeValue=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    try body_buf.appendSlice(allocator, "&TopicArn=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.topic_arn);

    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = "/";
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-www-form-urlencoded");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !SetTopicAttributesOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    const result: SetTopicAttributesOutput = .{};

    return result;
}

fn parseErrorResponse(allocator: std.mem.Allocator, body: []const u8, status: u16) !ServiceError {
    const error_code = aws.xml.findElement(body, "Code") orelse "Unknown";
    const error_message = aws.xml.findElement(body, "Message") orelse "";
    const request_id = aws.xml.findElement(body, "RequestId") orelse "";
    var arena = std.heap.ArenaAllocator.init(allocator);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, request_id);

    if (std.mem.eql(u8, error_code, "AuthorizationErrorException")) {
        return .{ .arena = arena, .kind = .{ .authorization_error_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "BatchEntryIdsNotDistinctException")) {
        return .{ .arena = arena, .kind = .{ .batch_entry_ids_not_distinct_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "BatchRequestTooLongException")) {
        return .{ .arena = arena, .kind = .{ .batch_request_too_long_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ConcurrentAccessException")) {
        return .{ .arena = arena, .kind = .{ .concurrent_access_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "EmptyBatchRequestException")) {
        return .{ .arena = arena, .kind = .{ .empty_batch_request_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "EndpointDisabledException")) {
        return .{ .arena = arena, .kind = .{ .endpoint_disabled_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "FilterPolicyLimitExceededException")) {
        return .{ .arena = arena, .kind = .{ .filter_policy_limit_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InternalErrorException")) {
        return .{ .arena = arena, .kind = .{ .internal_error_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidBatchEntryIdException")) {
        return .{ .arena = arena, .kind = .{ .invalid_batch_entry_id_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidParameterException")) {
        return .{ .arena = arena, .kind = .{ .invalid_parameter_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidParameterValueException")) {
        return .{ .arena = arena, .kind = .{ .invalid_parameter_value_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidSecurityException")) {
        return .{ .arena = arena, .kind = .{ .invalid_security_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidStateException")) {
        return .{ .arena = arena, .kind = .{ .invalid_state_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "KMSAccessDeniedException")) {
        return .{ .arena = arena, .kind = .{ .kms_access_denied_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "KMSDisabledException")) {
        return .{ .arena = arena, .kind = .{ .kms_disabled_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "KMSInvalidStateException")) {
        return .{ .arena = arena, .kind = .{ .kms_invalid_state_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "KMSNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .kms_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "KMSOptInRequired")) {
        return .{ .arena = arena, .kind = .{ .kms_opt_in_required = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "KMSThrottlingException")) {
        return .{ .arena = arena, .kind = .{ .kms_throttling_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "NotFoundException")) {
        return .{ .arena = arena, .kind = .{ .not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "OptedOutException")) {
        return .{ .arena = arena, .kind = .{ .opted_out_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "PlatformApplicationDisabledException")) {
        return .{ .arena = arena, .kind = .{ .platform_application_disabled_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ReplayLimitExceededException")) {
        return .{ .arena = arena, .kind = .{ .replay_limit_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .resource_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "StaleTagException")) {
        return .{ .arena = arena, .kind = .{ .stale_tag_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "SubscriptionLimitExceededException")) {
        return .{ .arena = arena, .kind = .{ .subscription_limit_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TagLimitExceededException")) {
        return .{ .arena = arena, .kind = .{ .tag_limit_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TagPolicyException")) {
        return .{ .arena = arena, .kind = .{ .tag_policy_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ThrottledException")) {
        return .{ .arena = arena, .kind = .{ .throttled_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TooManyEntriesInBatchRequestException")) {
        return .{ .arena = arena, .kind = .{ .too_many_entries_in_batch_request_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TopicLimitExceededException")) {
        return .{ .arena = arena, .kind = .{ .topic_limit_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "UserErrorException")) {
        return .{ .arena = arena, .kind = .{ .user_error_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ValidationException")) {
        return .{ .arena = arena, .kind = .{ .validation_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "VerificationException")) {
        return .{ .arena = arena, .kind = .{ .verification_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
