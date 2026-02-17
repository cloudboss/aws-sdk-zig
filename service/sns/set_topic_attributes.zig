const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
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

pub const SetTopicAttributesOutput = struct {

    _arena: std.heap.ArenaAllocator = undefined,

    pub fn deinit(self: *SetTopicAttributesOutput) void {
        self._arena.deinit();
    }
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, input: SetTopicAttributesInput, options: Options) !SetTopicAttributesOutput {
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
            d.* = parseErrorResponse(response.body, response.status);
        }
        return error.ServiceError;
    }

    var resp_arena = std.heap.ArenaAllocator.init(client.allocator);
    errdefer resp_arena.deinit();
    var result = try deserializeResponse(response.body, response.status, response.headers, resp_arena.allocator());
    result._arena = resp_arena;
    return result;
}

fn serializeRequest(alloc: std.mem.Allocator, input: SetTopicAttributesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpoint("sns", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(alloc, "Action=SetTopicAttributes&Version=2010-03-31");
    try body_buf.appendSlice(alloc, "&AttributeName=");
    try aws.url.appendUrlEncoded(alloc, &body_buf, input.attribute_name);
    if (input.attribute_value) |v| {
        try body_buf.appendSlice(alloc, "&AttributeValue=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, v);
    }
    try body_buf.appendSlice(alloc, "&TopicArn=");
    try aws.url.appendUrlEncoded(alloc, &body_buf, input.topic_arn);

    const body = try body_buf.toOwnedSlice(alloc);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = "/";
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(alloc, "Content-Type", "application/x-www-form-urlencoded");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !SetTopicAttributesOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = alloc;
    const result: SetTopicAttributesOutput = .{};

    return result;
}

fn parseErrorResponse(body: []const u8, status: u16) ServiceError {
    const error_code = aws.xml.findElement(body, "Code") orelse "Unknown";
    const error_message = aws.xml.findElement(body, "Message") orelse "";
    const request_id = aws.xml.findElement(body, "RequestId") orelse "";

    if (std.mem.eql(u8, error_code, "AuthorizationErrorException")) {
        return .{ .authorization_error_exception = .{
            .message = error_message,
            .request_id = request_id,
        } };
    }
    if (std.mem.eql(u8, error_code, "BatchEntryIdsNotDistinctException")) {
        return .{ .batch_entry_ids_not_distinct_exception = .{
            .message = error_message,
            .request_id = request_id,
        } };
    }
    if (std.mem.eql(u8, error_code, "BatchRequestTooLongException")) {
        return .{ .batch_request_too_long_exception = .{
            .message = error_message,
            .request_id = request_id,
        } };
    }
    if (std.mem.eql(u8, error_code, "ConcurrentAccessException")) {
        return .{ .concurrent_access_exception = .{
            .message = error_message,
            .request_id = request_id,
        } };
    }
    if (std.mem.eql(u8, error_code, "EmptyBatchRequestException")) {
        return .{ .empty_batch_request_exception = .{
            .message = error_message,
            .request_id = request_id,
        } };
    }
    if (std.mem.eql(u8, error_code, "EndpointDisabledException")) {
        return .{ .endpoint_disabled_exception = .{
            .message = error_message,
            .request_id = request_id,
        } };
    }
    if (std.mem.eql(u8, error_code, "FilterPolicyLimitExceededException")) {
        return .{ .filter_policy_limit_exceeded_exception = .{
            .message = error_message,
            .request_id = request_id,
        } };
    }
    if (std.mem.eql(u8, error_code, "InternalErrorException")) {
        return .{ .internal_error_exception = .{
            .message = error_message,
            .request_id = request_id,
        } };
    }
    if (std.mem.eql(u8, error_code, "InvalidBatchEntryIdException")) {
        return .{ .invalid_batch_entry_id_exception = .{
            .message = error_message,
            .request_id = request_id,
        } };
    }
    if (std.mem.eql(u8, error_code, "InvalidParameterException")) {
        return .{ .invalid_parameter_exception = .{
            .message = error_message,
            .request_id = request_id,
        } };
    }
    if (std.mem.eql(u8, error_code, "InvalidParameterValueException")) {
        return .{ .invalid_parameter_value_exception = .{
            .message = error_message,
            .request_id = request_id,
        } };
    }
    if (std.mem.eql(u8, error_code, "InvalidSecurityException")) {
        return .{ .invalid_security_exception = .{
            .message = error_message,
            .request_id = request_id,
        } };
    }
    if (std.mem.eql(u8, error_code, "InvalidStateException")) {
        return .{ .invalid_state_exception = .{
            .message = error_message,
            .request_id = request_id,
        } };
    }
    if (std.mem.eql(u8, error_code, "KMSAccessDeniedException")) {
        return .{ .kms_access_denied_exception = .{
            .message = error_message,
            .request_id = request_id,
        } };
    }
    if (std.mem.eql(u8, error_code, "KMSDisabledException")) {
        return .{ .kms_disabled_exception = .{
            .message = error_message,
            .request_id = request_id,
        } };
    }
    if (std.mem.eql(u8, error_code, "KMSInvalidStateException")) {
        return .{ .kms_invalid_state_exception = .{
            .message = error_message,
            .request_id = request_id,
        } };
    }
    if (std.mem.eql(u8, error_code, "KMSNotFoundException")) {
        return .{ .kms_not_found_exception = .{
            .message = error_message,
            .request_id = request_id,
        } };
    }
    if (std.mem.eql(u8, error_code, "KMSOptInRequired")) {
        return .{ .kms_opt_in_required = .{
            .message = error_message,
            .request_id = request_id,
        } };
    }
    if (std.mem.eql(u8, error_code, "KMSThrottlingException")) {
        return .{ .kms_throttling_exception = .{
            .message = error_message,
            .request_id = request_id,
        } };
    }
    if (std.mem.eql(u8, error_code, "NotFoundException")) {
        return .{ .not_found_exception = .{
            .message = error_message,
            .request_id = request_id,
        } };
    }
    if (std.mem.eql(u8, error_code, "OptedOutException")) {
        return .{ .opted_out_exception = .{
            .message = error_message,
            .request_id = request_id,
        } };
    }
    if (std.mem.eql(u8, error_code, "PlatformApplicationDisabledException")) {
        return .{ .platform_application_disabled_exception = .{
            .message = error_message,
            .request_id = request_id,
        } };
    }
    if (std.mem.eql(u8, error_code, "ReplayLimitExceededException")) {
        return .{ .replay_limit_exceeded_exception = .{
            .message = error_message,
            .request_id = request_id,
        } };
    }
    if (std.mem.eql(u8, error_code, "ResourceNotFoundException")) {
        return .{ .resource_not_found_exception = .{
            .message = error_message,
            .request_id = request_id,
        } };
    }
    if (std.mem.eql(u8, error_code, "StaleTagException")) {
        return .{ .stale_tag_exception = .{
            .message = error_message,
            .request_id = request_id,
        } };
    }
    if (std.mem.eql(u8, error_code, "SubscriptionLimitExceededException")) {
        return .{ .subscription_limit_exceeded_exception = .{
            .message = error_message,
            .request_id = request_id,
        } };
    }
    if (std.mem.eql(u8, error_code, "TagLimitExceededException")) {
        return .{ .tag_limit_exceeded_exception = .{
            .message = error_message,
            .request_id = request_id,
        } };
    }
    if (std.mem.eql(u8, error_code, "TagPolicyException")) {
        return .{ .tag_policy_exception = .{
            .message = error_message,
            .request_id = request_id,
        } };
    }
    if (std.mem.eql(u8, error_code, "ThrottledException")) {
        return .{ .throttled_exception = .{
            .message = error_message,
            .request_id = request_id,
        } };
    }
    if (std.mem.eql(u8, error_code, "TooManyEntriesInBatchRequestException")) {
        return .{ .too_many_entries_in_batch_request_exception = .{
            .message = error_message,
            .request_id = request_id,
        } };
    }
    if (std.mem.eql(u8, error_code, "TopicLimitExceededException")) {
        return .{ .topic_limit_exceeded_exception = .{
            .message = error_message,
            .request_id = request_id,
        } };
    }
    if (std.mem.eql(u8, error_code, "UserErrorException")) {
        return .{ .user_error_exception = .{
            .message = error_message,
            .request_id = request_id,
        } };
    }
    if (std.mem.eql(u8, error_code, "ValidationException")) {
        return .{ .validation_exception = .{
            .message = error_message,
            .request_id = request_id,
        } };
    }
    if (std.mem.eql(u8, error_code, "VerificationException")) {
        return .{ .verification_exception = .{
            .message = error_message,
            .request_id = request_id,
        } };
    }

    return .{ .unknown = .{
        .code = error_code,
        .message = error_message,
        .request_id = request_id,
        .http_status = status,
    } };
}
