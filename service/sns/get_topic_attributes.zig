const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const serde = @import("serde.zig");

pub const GetTopicAttributesInput = struct {
    /// The ARN of the topic whose properties you want to get.
    topic_arn: []const u8,
};

pub const GetTopicAttributesOutput = struct {
    /// A map of the topic's attributes. Attributes in this map include the
    /// following:
    ///
    /// * `DeliveryPolicy` – The JSON serialization of the topic's
    /// delivery policy.
    ///
    /// * `DisplayName` – The human-readable name used in the
    /// `From` field for notifications to `email` and
    /// `email-json` endpoints.
    ///
    /// * `EffectiveDeliveryPolicy` – The JSON serialization of the
    /// effective delivery policy, taking system defaults into account.
    ///
    /// * `Owner` – The Amazon Web Services account ID of the topic's owner.
    ///
    /// * `Policy` – The JSON serialization of the topic's access
    /// control policy.
    ///
    /// * `SignatureVersion` – The signature version corresponds to
    /// the hashing algorithm used while creating the signature of the
    /// notifications,
    /// subscription confirmations, or unsubscribe confirmation messages sent by
    /// Amazon SNS.
    ///
    /// * By default, `SignatureVersion` is set to **1**. The signature is a
    ///   Base64-encoded
    /// **SHA1withRSA** signature.
    ///
    /// * When you set `SignatureVersion` to **2**. Amazon SNS uses a Base64-encoded
    ///   **SHA256withRSA** signature.
    ///
    /// If the API response does not include the
    /// `SignatureVersion` attribute, it means that the
    /// `SignatureVersion` for the topic has value **1**.
    ///
    /// * `SubscriptionsConfirmed` – The number of confirmed
    /// subscriptions for the topic.
    ///
    /// * `SubscriptionsDeleted` – The number of deleted subscriptions
    /// for the topic.
    ///
    /// * `SubscriptionsPending` – The number of subscriptions pending
    /// confirmation for the topic.
    ///
    /// * `TopicArn` – The topic's ARN.
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
    /// The following attribute applies only to
    /// [server-side-encryption](https://docs.aws.amazon.com/sns/latest/dg/sns-server-side-encryption.html):
    ///
    /// * `KmsMasterKeyId` - The ID of an Amazon Web Services managed customer
    ///   master key
    /// (CMK) for Amazon SNS or a custom CMK. For more information, see [Key
    /// Terms](https://docs.aws.amazon.com/sns/latest/dg/sns-server-side-encryption.html#sse-key-terms). For more examples, see [KeyId](https://docs.aws.amazon.com/kms/latest/APIReference/API_DescribeKey.html#API_DescribeKey_RequestParameters) in the *Key Management Service API Reference*.
    ///
    /// The following attributes apply only to [FIFO
    /// topics](https://docs.aws.amazon.com/sns/latest/dg/sns-fifo-topics.html):
    ///
    /// * `ArchivePolicy` – The policy that sets the retention period
    /// for messages stored in the message archive of an Amazon SNS FIFO
    /// topic.
    ///
    /// * `BeginningArchiveTime` – The earliest starting point at
    /// which a message in the topic’s archive can be replayed from. This point in
    /// time
    /// is based on the configured message retention period set by the topic’s
    /// message
    /// archiving policy.
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
    /// * `FifoTopic` – When this is set to `true`, a FIFO
    /// topic is created.
    attributes: ?[]const aws.map.StringMapEntry = null,
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetTopicAttributesInput, options: Options) !GetTopicAttributesOutput {
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
            d.* = parseErrorResponse(response.body, response.status, client.allocator) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(response.body, response.status, response.headers, allocator);
    return result;
}

fn serializeRequest(alloc: std.mem.Allocator, input: GetTopicAttributesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("sns", "SNS", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(alloc, "Action=GetTopicAttributes&Version=2010-03-31");
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

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !GetTopicAttributesOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "GetTopicAttributesResult")) break;
            },
            else => {},
        }
    }

    var result: GetTopicAttributesOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Attributes")) {
                    result.attributes = try serde.deserializeTopicAttributesMap(&reader, alloc, "entry");
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

fn parseErrorResponse(body: []const u8, status: u16, alloc: std.mem.Allocator) !ServiceError {
    const error_code = aws.xml.findElement(body, "Code") orelse "Unknown";
    const error_message = aws.xml.findElement(body, "Message") orelse "";
    const request_id = aws.xml.findElement(body, "RequestId") orelse "";
    var arena = std.heap.ArenaAllocator.init(alloc);
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
