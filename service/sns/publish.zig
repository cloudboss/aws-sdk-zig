const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const MessageAttributeValue = @import("message_attribute_value.zig").MessageAttributeValue;
const serde = @import("serde.zig");

pub const PublishInput = struct {
    /// The message you want to send.
    ///
    /// If you are publishing to a topic and you want to send the same message to
    /// all
    /// transport protocols, include the text of the message as a String value. If
    /// you want to
    /// send different messages for each transport protocol, set the value of the
    /// `MessageStructure` parameter to `json` and use a JSON object
    /// for the `Message` parameter.
    ///
    /// Constraints:
    ///
    /// * With the exception of SMS, messages must be UTF-8 encoded strings and at
    ///   most
    /// 256 KB in size (262,144 bytes, not 262,144 characters).
    ///
    /// * For SMS, each message can contain up to 140 characters. This character
    ///   limit
    /// depends on the encoding schema. For example, an SMS message can contain 160
    /// GSM
    /// characters, 140 ASCII characters, or 70 UCS-2 characters.
    ///
    /// If you publish a message that exceeds this size limit, Amazon SNS sends the
    /// message
    /// as multiple messages, each fitting within the size limit. Messages aren't
    /// truncated mid-word but are cut off at whole-word boundaries.
    ///
    /// The total size limit for a single SMS `Publish` action is 1,600
    /// characters.
    ///
    /// JSON-specific constraints:
    ///
    /// * Keys in the JSON object that correspond to supported transport protocols
    ///   must
    /// have simple JSON string values.
    ///
    /// * The values will be parsed (unescaped) before they are used in outgoing
    /// messages.
    ///
    /// * Outbound notifications are JSON encoded (meaning that the characters will
    ///   be
    /// reescaped for sending).
    ///
    /// * Values have a minimum length of 0 (the empty string, "", is allowed).
    ///
    /// * Values have a maximum length bounded by the overall message size (so,
    /// including multiple protocols may limit message sizes).
    ///
    /// * Non-string values will cause the key to be ignored.
    ///
    /// * Keys that do not correspond to supported transport protocols are
    /// ignored.
    ///
    /// * Duplicate keys are not allowed.
    ///
    /// * Failure to parse or validate any key or value in the message will cause
    ///   the
    /// `Publish` call to return an error (no partial delivery).
    message: []const u8,

    /// Message attributes for Publish action.
    message_attributes: ?[]const aws.map.MapEntry(MessageAttributeValue) = null,

    /// * This parameter applies only to FIFO (first-in-first-out) topics. The
    /// `MessageDeduplicationId` can contain up to 128 alphanumeric
    /// characters `(a-z, A-Z, 0-9)` and punctuation
    /// `(!"#$%&'()*+,-./:;?@[\]^_`{|}~)`.
    ///
    /// * Every message must have a unique `MessageDeduplicationId`, which is
    /// a token used for deduplication of sent messages within the 5 minute minimum
    /// deduplication interval.
    ///
    /// * The scope of deduplication depends on the `FifoThroughputScope`
    /// attribute, when set to `Topic` the message deduplication scope is
    /// across the entire topic, when set to `MessageGroup` the message
    /// deduplication scope is within each individual message group.
    ///
    /// * If a message with a particular `MessageDeduplicationId` is sent
    /// successfully, subsequent messages within the deduplication scope and
    /// interval,
    /// with the same `MessageDeduplicationId`, are accepted successfully but
    /// aren't delivered.
    ///
    /// * Every message must have a unique `MessageDeduplicationId`:
    ///
    /// * You may provide a `MessageDeduplicationId`
    /// explicitly.
    ///
    /// * If you aren't able to provide a `MessageDeduplicationId`
    /// and you enable `ContentBasedDeduplication` for your topic,
    /// Amazon SNS uses a SHA-256 hash to generate the
    /// `MessageDeduplicationId` using the body of the message
    /// (but not the attributes of the message).
    ///
    /// * If you don't provide a `MessageDeduplicationId` and the
    /// topic doesn't have `ContentBasedDeduplication` set, the
    /// action fails with an error.
    ///
    /// * If the topic has a `ContentBasedDeduplication` set, your
    /// `MessageDeduplicationId` overrides the generated one.
    ///
    /// * When `ContentBasedDeduplication` is in effect, messages with
    /// identical content sent within the deduplication scope and interval are
    /// treated
    /// as duplicates and only one copy of the message is delivered.
    ///
    /// * If you send one message with `ContentBasedDeduplication` enabled,
    /// and then another message with a `MessageDeduplicationId` that is the
    /// same as the one generated for the first `MessageDeduplicationId`, the
    /// two messages are treated as duplicates, within the deduplication scope and
    /// interval, and only one copy of the message is delivered.
    message_deduplication_id: ?[]const u8 = null,

    /// The
    /// `MessageGroupId` can contain up to 128 alphanumeric characters
    /// `(a-z, A-Z, 0-9)` and punctuation
    /// `(!"#$%&'()*+,-./:;?@[\]^_`{|}~)`.
    ///
    /// For FIFO topics: The `MessageGroupId` is a tag that specifies that a message
    /// belongs to a
    /// specific message group. Messages that belong to the same message group are
    /// processed in
    /// a FIFO manner (however, messages in different message groups might be
    /// processed out of
    /// order). Every message must include a `MessageGroupId`.
    ///
    /// For standard topics: The `MessageGroupId` is optional
    /// and is forwarded only to Amazon SQS standard subscriptions to activate [fair
    /// queues](https://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/sqs-fair-queues.html).
    /// The `MessageGroupId` is not used for, or sent to, any other endpoint types.
    /// When provided, the same validation rules apply as for FIFO topics.
    message_group_id: ?[]const u8 = null,

    /// Set `MessageStructure` to `json` if you want to send a different
    /// message for each protocol. For example, using one publish action, you can
    /// send a short
    /// message to your SMS subscribers and a longer message to your email
    /// subscribers. If you
    /// set `MessageStructure` to `json`, the value of the
    /// `Message` parameter must:
    ///
    /// * be a syntactically valid JSON object; and
    ///
    /// * contain at least a top-level JSON key of "default" with a value that is a
    /// string.
    ///
    /// You can define other top-level keys that define the message you want to send
    /// to a
    /// specific transport protocol (e.g., "http").
    ///
    /// Valid value: `json`
    message_structure: ?[]const u8 = null,

    /// The phone number to which you want to deliver an SMS message. Use E.164
    /// format.
    ///
    /// If you don't specify a value for the `PhoneNumber` parameter, you must
    /// specify a value for the `TargetArn` or `TopicArn`
    /// parameters.
    phone_number: ?[]const u8 = null,

    /// Optional parameter to be used as the "Subject" line when the message is
    /// delivered to
    /// email endpoints. This field will also be included, if present, in the
    /// standard JSON
    /// messages delivered to other endpoints.
    ///
    /// Constraints: Subjects must be UTF-8 text with no line breaks or control
    /// characters,
    /// and less than 100 characters long.
    subject: ?[]const u8 = null,

    /// If you don't specify a value for the `TargetArn` parameter, you must
    /// specify a value for the `PhoneNumber` or `TopicArn`
    /// parameters.
    target_arn: ?[]const u8 = null,

    /// The topic you want to publish to.
    ///
    /// If you don't specify a value for the `TopicArn` parameter, you must specify
    /// a value for the `PhoneNumber` or `TargetArn` parameters.
    topic_arn: ?[]const u8 = null,
};

pub const PublishOutput = struct {
    /// Unique identifier assigned to the published message.
    ///
    /// Length Constraint: Maximum 100 characters
    message_id: ?[]const u8 = null,

    /// This response element applies only to FIFO (first-in-first-out) topics.
    ///
    /// The sequence number is a large, non-consecutive number that Amazon SNS
    /// assigns to each
    /// message. The length of `SequenceNumber` is 128 bits.
    /// `SequenceNumber` continues to increase for each
    /// `MessageGroupId`.
    sequence_number: ?[]const u8 = null,
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: PublishInput, options: Options) !PublishOutput {
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

fn serializeRequest(alloc: std.mem.Allocator, input: PublishInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("sns", "SNS", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(alloc, "Action=Publish&Version=2010-03-31");
    try body_buf.appendSlice(alloc, "&Message=");
    try aws.url.appendUrlEncoded(alloc, &body_buf, input.message);
    if (input.message_attributes) |entries| {
        for (entries, 0..) |entry, idx| {
            const n = idx + 1;
            {
                var prefix_buf: [256]u8 = undefined;
                const key_prefix = std.fmt.bufPrint(&prefix_buf, "&MessageAttributes.entry.{d}.key=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, key_prefix);
                try aws.url.appendUrlEncoded(alloc, &body_buf, entry.key);
            }
            if (entry.value.binary_value) |v| {
                {
                    var prefix_buf: [256]u8 = undefined;
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&MessageAttributes.entry.{d}.BinaryValue=", .{n}) catch continue;
                    try body_buf.appendSlice(alloc, field_prefix);
                    try aws.url.appendUrlEncoded(alloc, &body_buf, v);
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&MessageAttributes.entry.{d}.DataType=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, field_prefix);
                try aws.url.appendUrlEncoded(alloc, &body_buf, entry.value.data_type);
            }
            if (entry.value.string_value) |v| {
                {
                    var prefix_buf: [256]u8 = undefined;
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&MessageAttributes.entry.{d}.StringValue=", .{n}) catch continue;
                    try body_buf.appendSlice(alloc, field_prefix);
                    try aws.url.appendUrlEncoded(alloc, &body_buf, v);
                }
            }
        }
    }
    if (input.message_deduplication_id) |v| {
        try body_buf.appendSlice(alloc, "&MessageDeduplicationId=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.message_group_id) |v| {
        try body_buf.appendSlice(alloc, "&MessageGroupId=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.message_structure) |v| {
        try body_buf.appendSlice(alloc, "&MessageStructure=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.phone_number) |v| {
        try body_buf.appendSlice(alloc, "&PhoneNumber=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.subject) |v| {
        try body_buf.appendSlice(alloc, "&Subject=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.target_arn) |v| {
        try body_buf.appendSlice(alloc, "&TargetArn=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.topic_arn) |v| {
        try body_buf.appendSlice(alloc, "&TopicArn=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, v);
    }

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

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !PublishOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "PublishResult")) break;
            },
            else => {},
        }
    }

    var result: PublishOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "MessageId")) {
                    result.message_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "SequenceNumber")) {
                    result.sequence_number = try alloc.dupe(u8, try reader.readElementText());
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
