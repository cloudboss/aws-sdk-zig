const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;

pub const SetQueueAttributesInput = struct {
    /// A map of attributes to set.
    ///
    /// The following lists the names, descriptions, and values of the special
    /// request
    /// parameters that the `SetQueueAttributes` action uses:
    ///
    /// * `DelaySeconds` – The length of time, in seconds, for which the
    /// delivery of all messages in the queue is delayed. Valid values: An integer
    /// from
    /// 0 to 900 (15 minutes). Default: 0.
    ///
    /// * `MaximumMessageSize` – The limit of how many bytes a message
    /// can contain before Amazon SQS rejects it. Valid values: An integer from
    /// 1,024 bytes
    /// (1 KiB) up to 1,048,576 bytes (1 MiB). Default: 1,048,576 bytes (1 MiB).
    ///
    /// * `MessageRetentionPeriod` – The length of time, in seconds, for
    /// which Amazon SQS retains a message. Valid values: An integer representing
    /// seconds,
    /// from 60 (1 minute) to 1,209,600 (14 days). Default: 345,600 (4 days). When
    /// you
    /// change a queue's attributes, the change can take up to 60 seconds for most
    /// of
    /// the attributes to propagate throughout the Amazon SQS system. Changes made
    /// to the
    /// `MessageRetentionPeriod` attribute can take up to 15 minutes and
    /// will impact existing messages in the queue potentially causing them to be
    /// expired and deleted if the `MessageRetentionPeriod` is reduced below
    /// the age of existing messages.
    ///
    /// * `Policy` – The queue's policy. A valid Amazon Web Services policy. For
    ///   more
    /// information about policy structure, see [Overview of Amazon Web Services IAM
    /// Policies](https://docs.aws.amazon.com/IAM/latest/UserGuide/PoliciesOverview.html) in the *Identity and Access Management User
    /// Guide*.
    ///
    /// * `ReceiveMessageWaitTimeSeconds` – The length of time, in
    /// seconds, for which a `
    /// ReceiveMessage
    /// ` action waits
    /// for a message to arrive. Valid values: An integer from 0 to 20 (seconds).
    /// Default: 0.
    ///
    /// * `VisibilityTimeout` – The visibility timeout for the queue, in
    /// seconds. Valid values: An integer from 0 to 43,200 (12 hours). Default: 30.
    /// For
    /// more information about the visibility timeout, see [Visibility
    /// Timeout](https://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/sqs-visibility-timeout.html) in the *Amazon SQS Developer
    /// Guide*.
    ///
    /// The following attributes apply only to [dead-letter
    /// queues:](https://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/sqs-dead-letter-queues.html)
    ///
    /// * `RedrivePolicy` – The string that includes the parameters for the
    ///   dead-letter queue functionality
    /// of the source queue as a JSON object. The parameters are as follows:
    ///
    /// * `deadLetterTargetArn` – The Amazon Resource Name (ARN) of the dead-letter
    ///   queue to
    /// which Amazon SQS moves messages after the value of `maxReceiveCount` is
    /// exceeded.
    ///
    /// * `maxReceiveCount` – The number of times a message is delivered to the
    ///   source queue before being
    /// moved to the dead-letter queue. Default: 10. When the `ReceiveCount` for a
    /// message exceeds the `maxReceiveCount`
    /// for a queue, Amazon SQS moves the message to the dead-letter-queue.
    ///
    /// * `RedriveAllowPolicy` – The string that includes the parameters for the
    ///   permissions for the dead-letter
    /// queue redrive permission and which source queues can specify dead-letter
    /// queues as a JSON object. The parameters are as follows:
    ///
    /// * `redrivePermission` – The permission type that defines which source queues
    ///   can
    /// specify the current queue as the dead-letter queue. Valid values are:
    ///
    /// * `allowAll` – (Default) Any source queues in this Amazon Web Services
    ///   account in the same Region can
    /// specify this queue as the dead-letter queue.
    ///
    /// * `denyAll` – No source queues can specify this queue as the dead-letter
    /// queue.
    ///
    /// * `byQueue` – Only queues specified by the `sourceQueueArns` parameter can
    ///   specify
    /// this queue as the dead-letter queue.
    ///
    /// * `sourceQueueArns` – The Amazon Resource Names (ARN)s of the source queues
    ///   that can specify
    /// this queue as the dead-letter queue and redrive messages. You can specify
    /// this parameter only when the
    /// `redrivePermission` parameter is set to `byQueue`. You can specify up to 10
    /// source queue ARNs.
    /// To allow more than 10 source queues to specify dead-letter queues, set the
    /// `redrivePermission` parameter
    /// to `allowAll`.
    ///
    /// The dead-letter queue of a
    /// FIFO queue must also be a FIFO queue. Similarly, the dead-letter
    /// queue of a standard queue must also be a standard queue.
    ///
    /// The following attributes apply only to
    /// [server-side-encryption](https://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/sqs-server-side-encryption.html):
    ///
    /// * `KmsMasterKeyId` – The ID of an Amazon Web Services managed customer
    ///   master
    /// key (CMK) for Amazon SQS or a custom CMK. For more information, see [Key
    /// Terms](https://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/sqs-server-side-encryption.html#sqs-sse-key-terms). While the alias of the AWS-managed CMK for Amazon SQS is
    /// always `alias/aws/sqs`, the alias of a custom CMK can, for example,
    /// be `alias/*MyAlias*
    /// `. For more examples, see
    /// [KeyId](https://docs.aws.amazon.com/kms/latest/APIReference/API_DescribeKey.html#API_DescribeKey_RequestParameters) in the *Key Management Service API
    /// Reference*.
    ///
    /// * `KmsDataKeyReusePeriodSeconds` – The length of time, in
    /// seconds, for which Amazon SQS can reuse a [data
    /// key](https://docs.aws.amazon.com/kms/latest/developerguide/concepts.html#data-keys) to
    /// encrypt or decrypt messages before calling KMS again. An integer
    /// representing seconds, between 60 seconds (1 minute) and 86,400 seconds (24
    /// hours). Default: 300 (5 minutes). A shorter time period provides better
    /// security
    /// but results in more calls to KMS which might incur charges after Free Tier.
    /// For
    /// more information, see [How Does the Data Key Reuse Period
    /// Work?](https://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/sqs-server-side-encryption.html#sqs-how-does-the-data-key-reuse-period-work).
    ///
    /// * `SqsManagedSseEnabled` – Enables server-side queue encryption
    /// using SQS owned encryption keys. Only one server-side encryption option is
    /// supported per queue (for example,
    /// [SSE-KMS](https://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/sqs-configure-sse-existing-queue.html) or [SSE-SQS](https://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/sqs-configure-sqs-sse-queue.html)).
    ///
    /// The following attribute applies only to [FIFO (first-in-first-out)
    /// queues](https://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/FIFO-queues.html):
    ///
    /// * `ContentBasedDeduplication` – Enables content-based
    /// deduplication. For more information, see [Exactly-once
    /// processing](https://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/FIFO-queues-exactly-once-processing.html) in the *Amazon SQS Developer
    /// Guide*. Note the following:
    ///
    /// * Every message must have a unique
    /// `MessageDeduplicationId`.
    ///
    /// * You may provide a `MessageDeduplicationId`
    /// explicitly.
    ///
    /// * If you aren't able to provide a
    /// `MessageDeduplicationId` and you enable
    /// `ContentBasedDeduplication` for your queue, Amazon SQS
    /// uses a SHA-256 hash to generate the
    /// `MessageDeduplicationId` using the body of the
    /// message (but not the attributes of the message).
    ///
    /// * If you don't provide a `MessageDeduplicationId` and
    /// the queue doesn't have `ContentBasedDeduplication`
    /// set, the action fails with an error.
    ///
    /// * If the queue has `ContentBasedDeduplication` set,
    /// your `MessageDeduplicationId` overrides the generated
    /// one.
    ///
    /// * When `ContentBasedDeduplication` is in effect, messages
    /// with identical content sent within the deduplication interval are
    /// treated as duplicates and only one copy of the message is
    /// delivered.
    ///
    /// * If you send one message with `ContentBasedDeduplication`
    /// enabled and then another message with a
    /// `MessageDeduplicationId` that is the same as the one
    /// generated for the first `MessageDeduplicationId`, the two
    /// messages are treated as duplicates and only one copy of the message is
    /// delivered.
    ///
    /// The following attributes apply only to
    /// [high throughput
    /// for FIFO
    /// queues](https://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/high-throughput-fifo.html):
    ///
    /// * `DeduplicationScope` – Specifies whether message deduplication occurs at
    ///   the
    /// message group or queue level. Valid values are `messageGroup` and `queue`.
    ///
    /// * `FifoThroughputLimit` – Specifies whether the FIFO queue throughput
    /// quota applies to the entire queue or per message group. Valid values are
    /// `perQueue` and `perMessageGroupId`.
    /// The `perMessageGroupId` value is allowed only when the value for
    /// `DeduplicationScope` is `messageGroup`.
    ///
    /// To enable high throughput for FIFO queues, do the following:
    ///
    /// * Set `DeduplicationScope` to `messageGroup`.
    ///
    /// * Set `FifoThroughputLimit` to `perMessageGroupId`.
    ///
    /// If you set these attributes to anything other than the values shown for
    /// enabling high
    /// throughput, normal throughput is in effect and deduplication occurs as
    /// specified.
    ///
    /// For information on throughput quotas,
    /// see [Quotas related to
    /// messages](https://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/quotas-messages.html)
    /// in the *Amazon SQS Developer Guide*.
    attributes: []const aws.map.StringMapEntry,

    /// The URL of the Amazon SQS queue whose attributes are set.
    ///
    /// Queue URLs and names are case-sensitive.
    queue_url: []const u8,

    pub const json_field_names = .{
        .attributes = "Attributes",
        .queue_url = "QueueUrl",
    };
};

pub const SetQueueAttributesOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: SetQueueAttributesInput, options: CallOptions) !SetQueueAttributesOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: SetQueueAttributesInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AmazonSQS.SetQueueAttributes");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !SetQueueAttributesOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    return .{};
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
