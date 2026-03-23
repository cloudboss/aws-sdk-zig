const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const MessageAttributeValue = @import("message_attribute_value.zig").MessageAttributeValue;
const MessageSystemAttributeValue = @import("message_system_attribute_value.zig").MessageSystemAttributeValue;

pub const SendMessageInput = struct {
    /// The length of time, in seconds, for which to delay a specific message. Valid
    /// values:
    /// 0 to 900. Maximum: 15 minutes. Messages with a positive `DelaySeconds` value
    /// become available for processing after the delay period is finished. If you
    /// don't specify
    /// a value, the default value for the queue applies.
    ///
    /// When you set `FifoQueue`, you can't set `DelaySeconds` per message. You can
    /// set this parameter only on a queue level.
    delay_seconds: ?i32 = null,

    /// Each message attribute consists of a `Name`, `Type`,
    /// and `Value`. For more information, see
    /// [Amazon SQS
    /// message
    /// attributes](https://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/sqs-message-metadata.html#sqs-message-attributes) in the *Amazon SQS Developer Guide*.
    message_attributes: ?[]const aws.map.MapEntry(MessageAttributeValue) = null,

    /// The message to send. The minimum size is one character. The maximum size is
    /// 1 MiB or 1,048,576 bytes
    ///
    /// A message can include only XML, JSON, and unformatted text. The following
    /// Unicode characters are allowed. For more information, see the [W3C
    /// specification for characters](http://www.w3.org/TR/REC-xml/#charsets).
    ///
    /// `#x9` | `#xA` | `#xD` | `#x20` to `#xD7FF` | `#xE000` to `#xFFFD` |
    /// `#x10000` to `#x10FFFF`
    ///
    /// If a message contains characters outside the allowed set, Amazon SQS rejects
    /// the message and returns an InvalidMessageContents error. Ensure that your
    /// message body includes only valid characters to avoid this exception.
    message_body: []const u8,

    /// This parameter applies only to FIFO (first-in-first-out) queues.
    ///
    /// The token used for deduplication of sent messages. If a message with a
    /// particular
    /// `MessageDeduplicationId` is sent successfully, any messages sent with the
    /// same `MessageDeduplicationId` are accepted successfully but aren't delivered
    /// during the 5-minute deduplication interval. For more information, see [
    /// Exactly-once
    /// processing](https://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/FIFO-queues-exactly-once-processing.html) in the *Amazon SQS Developer
    /// Guide*.
    ///
    /// * Every message must have a unique `MessageDeduplicationId`,
    ///
    /// * You may provide a `MessageDeduplicationId`
    /// explicitly.
    ///
    /// * If you aren't able to provide a `MessageDeduplicationId`
    /// and you enable `ContentBasedDeduplication` for your queue,
    /// Amazon SQS uses a SHA-256 hash to generate the
    /// `MessageDeduplicationId` using the body of the message
    /// (but not the attributes of the message).
    ///
    /// * If you don't provide a `MessageDeduplicationId` and the
    /// queue doesn't have `ContentBasedDeduplication` set, the
    /// action fails with an error.
    ///
    /// * If the queue has `ContentBasedDeduplication` set, your
    /// `MessageDeduplicationId` overrides the generated
    /// one.
    ///
    /// * When `ContentBasedDeduplication` is in effect, messages with
    /// identical content sent within the deduplication interval are treated as
    /// duplicates and only one copy of the message is delivered.
    ///
    /// * If you send one message with `ContentBasedDeduplication` enabled
    /// and then another message with a `MessageDeduplicationId` that is the
    /// same as the one generated for the first `MessageDeduplicationId`, the
    /// two messages are treated as duplicates and only one copy of the message is
    /// delivered.
    ///
    /// The `MessageDeduplicationId` is available to the consumer of the
    /// message (this can be useful for troubleshooting delivery issues).
    ///
    /// If a message is sent successfully but the acknowledgement is lost and the
    /// message
    /// is resent with the same `MessageDeduplicationId` after the deduplication
    /// interval, Amazon SQS can't detect duplicate messages.
    ///
    /// Amazon SQS continues to keep track of the message deduplication ID even
    /// after the message is received and deleted.
    ///
    /// The maximum length of `MessageDeduplicationId` is 128 characters.
    /// `MessageDeduplicationId` can contain alphanumeric characters
    /// (`a-z`, `A-Z`, `0-9`) and punctuation
    /// (`!"#$%&'()*+,-./:;?@[\]^_`{|}~`).
    ///
    /// For best practices of using `MessageDeduplicationId`, see [Using the
    /// MessageDeduplicationId
    /// Property](https://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/using-messagededuplicationid-property.html) in the *Amazon SQS Developer
    /// Guide*.
    message_deduplication_id: ?[]const u8 = null,

    /// `MessageGroupId` is an attribute used in Amazon SQS FIFO
    /// (First-In-First-Out) and standard queues.
    /// In FIFO queues, `MessageGroupId` organizes messages into distinct groups.
    /// Messages within the same message group are always processed one at a time,
    /// in strict order,
    /// ensuring that no two messages from the same group are processed
    /// simultaneously.
    /// In standard queues, using `MessageGroupId` enables fair queues.
    /// It is used to identify the tenant a message belongs to,
    /// helping maintain consistent message dwell time across all tenants during
    /// noisy neighbor events.
    /// Unlike FIFO queues, messages with the same `MessageGroupId` can be processed
    /// in parallel,
    /// maintaining the high throughput of standard queues.
    ///
    /// * **FIFO queues:**
    /// `MessageGroupId` acts as the tag
    /// that specifies that a message belongs to a specific message group.
    /// Messages that belong to the same message group are processed in a FIFO
    /// manner
    /// (however, messages in different message groups might be processed out of
    /// order).
    /// To interleave multiple ordered streams within a single queue, use
    /// `MessageGroupId` values
    /// (for example, session data for multiple users).
    /// In this scenario, multiple consumers can process the queue,
    /// but the session data of each user is processed in a FIFO fashion.
    ///
    /// If you do not provide a `MessageGroupId` when sending a message to a FIFO
    /// queue, the action fails.
    ///
    /// `ReceiveMessage` might return messages with multiple `MessageGroupId`
    /// values.
    /// For each `MessageGroupId`, the messages are sorted by time sent.
    ///
    /// * **Standard queues:**Use `MessageGroupId` in standard queues to enable fair
    ///   queues.
    /// The `MessageGroupId` identifies the tenant a message belongs to.
    /// A tenant can be any entity that shares a queue with others, such as your
    /// customer, a client application,
    /// or a request type. When one tenant sends a disproportionately large volume
    /// of messages
    /// or has messages that require longer processing time, fair queues ensure
    /// other tenants'
    /// messages maintain low dwell time. This preserves quality of service for all
    /// tenants while
    /// maintaining the scalability and throughput of standard queues.
    /// We recommend that you include a `MessageGroupId` in all messages when using
    /// fair queues.
    ///
    /// The length of `MessageGroupId` is 128 characters. Valid values:
    /// alphanumeric characters and punctuation
    /// `(!"#$%&'()*+,-./:;?@[\]^_`{|}~)`.
    ///
    /// For best practices of using `MessageGroupId`, see [Using the MessageGroupId
    /// Property](https://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/using-messagegroupid-property.html) in the *Amazon SQS Developer
    /// Guide*.
    message_group_id: ?[]const u8 = null,

    /// The message system attribute to send. Each message system attribute consists
    /// of a `Name`, `Type`, and `Value`.
    ///
    /// * Currently, the only supported message system attribute is
    ///   `AWSTraceHeader`.
    /// Its type must be `String` and its value must be a correctly formatted
    /// X-Ray trace header string.
    ///
    /// * The size of a message system attribute doesn't count towards the total
    ///   size of a message.
    message_system_attributes: ?[]const aws.map.MapEntry(MessageSystemAttributeValue) = null,

    /// The URL of the Amazon SQS queue to which a message is sent.
    ///
    /// Queue URLs and names are case-sensitive.
    queue_url: []const u8,

    pub const json_field_names = .{
        .delay_seconds = "DelaySeconds",
        .message_attributes = "MessageAttributes",
        .message_body = "MessageBody",
        .message_deduplication_id = "MessageDeduplicationId",
        .message_group_id = "MessageGroupId",
        .message_system_attributes = "MessageSystemAttributes",
        .queue_url = "QueueUrl",
    };
};

pub const SendMessageOutput = struct {
    /// An MD5 digest of the non-URL-encoded message attribute string. You can use
    /// this attribute to verify that Amazon SQS received the message correctly.
    /// Amazon SQS URL-decodes the message before creating the MD5 digest. For
    /// information about MD5, see [RFC1321](https://www.ietf.org/rfc/rfc1321.txt).
    md5_of_message_attributes: ?[]const u8 = null,

    /// An MD5 digest of the non-URL-encoded message body string. You can use this
    /// attribute to verify that Amazon SQS received the message correctly. Amazon
    /// SQS URL-decodes the message before creating the MD5 digest. For information
    /// about MD5, see [RFC1321](https://www.ietf.org/rfc/rfc1321.txt).
    md5_of_message_body: ?[]const u8 = null,

    /// An MD5 digest of the non-URL-encoded message system attribute string. You
    /// can use this
    /// attribute to verify that Amazon SQS received the message correctly. Amazon
    /// SQS URL-decodes the message before creating the MD5 digest.
    md5_of_message_system_attributes: ?[]const u8 = null,

    /// An attribute containing the `MessageId` of the message sent to the queue.
    /// For more information, see [Queue and Message
    /// Identifiers](https://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/sqs-queue-message-identifiers.html) in the *Amazon SQS Developer
    /// Guide*.
    message_id: ?[]const u8 = null,

    /// This parameter applies only to FIFO (first-in-first-out) queues.
    ///
    /// The large, non-consecutive number that Amazon SQS assigns to each message.
    ///
    /// The length of `SequenceNumber` is 128 bits. `SequenceNumber`
    /// continues to increase for a particular `MessageGroupId`.
    sequence_number: ?[]const u8 = null,

    pub const json_field_names = .{
        .md5_of_message_attributes = "MD5OfMessageAttributes",
        .md5_of_message_body = "MD5OfMessageBody",
        .md5_of_message_system_attributes = "MD5OfMessageSystemAttributes",
        .message_id = "MessageId",
        .sequence_number = "SequenceNumber",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: SendMessageInput, options: CallOptions) !SendMessageOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "sqs");

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

fn serializeRequest(allocator: std.mem.Allocator, input: SendMessageInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("sqs", "SQS", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = "/";
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "AmazonSQS.SendMessage");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !SendMessageOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(SendMessageOutput, body, allocator);
}

fn parseErrorResponse(allocator: std.mem.Allocator, body: []const u8, status: u16) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(allocator);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, "");

    if (std.mem.eql(u8, error_code, "BatchEntryIdsNotDistinct")) {
        return .{ .arena = arena, .kind = .{ .batch_entry_ids_not_distinct = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "BatchRequestTooLong")) {
        return .{ .arena = arena, .kind = .{ .batch_request_too_long = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "EmptyBatchRequest")) {
        return .{ .arena = arena, .kind = .{ .empty_batch_request = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidAddress")) {
        return .{ .arena = arena, .kind = .{ .invalid_address = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidAttributeName")) {
        return .{ .arena = arena, .kind = .{ .invalid_attribute_name = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidAttributeValue")) {
        return .{ .arena = arena, .kind = .{ .invalid_attribute_value = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidBatchEntryId")) {
        return .{ .arena = arena, .kind = .{ .invalid_batch_entry_id = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidIdFormat")) {
        return .{ .arena = arena, .kind = .{ .invalid_id_format = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidMessageContents")) {
        return .{ .arena = arena, .kind = .{ .invalid_message_contents = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidSecurity")) {
        return .{ .arena = arena, .kind = .{ .invalid_security = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "KmsAccessDenied")) {
        return .{ .arena = arena, .kind = .{ .kms_access_denied = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "KmsDisabled")) {
        return .{ .arena = arena, .kind = .{ .kms_disabled = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "KmsInvalidKeyUsage")) {
        return .{ .arena = arena, .kind = .{ .kms_invalid_key_usage = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "KmsInvalidState")) {
        return .{ .arena = arena, .kind = .{ .kms_invalid_state = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "KmsNotFound")) {
        return .{ .arena = arena, .kind = .{ .kms_not_found = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "KmsOptInRequired")) {
        return .{ .arena = arena, .kind = .{ .kms_opt_in_required = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "KmsThrottled")) {
        return .{ .arena = arena, .kind = .{ .kms_throttled = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "MessageNotInflight")) {
        return .{ .arena = arena, .kind = .{ .message_not_inflight = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "OverLimit")) {
        return .{ .arena = arena, .kind = .{ .over_limit = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "PurgeQueueInProgress")) {
        return .{ .arena = arena, .kind = .{ .purge_queue_in_progress = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "QueueDeletedRecently")) {
        return .{ .arena = arena, .kind = .{ .queue_deleted_recently = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "QueueDoesNotExist")) {
        return .{ .arena = arena, .kind = .{ .queue_does_not_exist = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "QueueNameExists")) {
        return .{ .arena = arena, .kind = .{ .queue_name_exists = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ReceiptHandleIsInvalid")) {
        return .{ .arena = arena, .kind = .{ .receipt_handle_is_invalid = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "RequestThrottled")) {
        return .{ .arena = arena, .kind = .{ .request_throttled = .{
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
    if (std.mem.eql(u8, error_code, "TooManyEntriesInBatchRequest")) {
        return .{ .arena = arena, .kind = .{ .too_many_entries_in_batch_request = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "UnsupportedOperation")) {
        return .{ .arena = arena, .kind = .{ .unsupported_operation = .{
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
