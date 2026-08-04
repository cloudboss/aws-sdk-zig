const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const errors = @import("errors.zig");
const ServiceError = errors.ServiceError;
const QueueAttributeName = @import("queue_attribute_name.zig").QueueAttributeName;

pub const GetQueueAttributesInput = struct {
    /// A list of attributes for which to retrieve information.
    ///
    /// The `AttributeNames` parameter is optional, but if you don't specify values
    /// for this parameter, the request returns empty results.
    ///
    /// In the future, new attributes might be added. If you write code that calls
    /// this action, we recommend that you structure your code so that it can handle
    /// new attributes gracefully.
    ///
    /// The following attributes are supported:
    ///
    /// The `ApproximateNumberOfMessagesDelayed`,
    /// `ApproximateNumberOfMessagesNotVisible`, and
    /// `ApproximateNumberOfMessages` metrics may not achieve consistency
    /// until at least 1 minute after the producers stop sending messages. This
    /// period is
    /// required for the queue metadata to reach eventual consistency.
    ///
    /// * `All` – Returns all values.
    ///
    /// * `ApproximateNumberOfMessages` – Returns the approximate
    /// number of messages available for retrieval from the queue.
    ///
    /// * `ApproximateNumberOfMessagesDelayed` – Returns the
    /// approximate number of messages in the queue that are delayed and not
    /// available
    /// for reading immediately. This can happen when the queue is configured as a
    /// delay
    /// queue or when a message has been sent with a delay parameter.
    ///
    /// * `ApproximateNumberOfMessagesNotVisible` – Returns the
    /// approximate number of messages that are in flight. Messages are considered
    /// to be
    /// *in flight* if they have been sent to a client but have
    /// not yet been deleted or have not yet reached the end of their visibility
    /// window.
    ///
    /// * `CreatedTimestamp` – Returns the time when the queue was
    /// created in seconds ([epoch
    /// time](http://en.wikipedia.org/wiki/Unix_time)).
    ///
    /// * `DelaySeconds` – Returns the default delay on the queue in
    /// seconds.
    ///
    /// * `LastModifiedTimestamp` – Returns the time when the queue
    /// was last changed in seconds ([epoch
    /// time](http://en.wikipedia.org/wiki/Unix_time)).
    ///
    /// * `MaximumMessageSize` – Returns the limit of how many bytes a
    /// message can contain before Amazon SQS rejects it.
    ///
    /// * `MessageRetentionPeriod` – Returns the length of time, in
    /// seconds, for which Amazon SQS retains a message. When you change a queue's
    /// attributes, the change can take up to 60 seconds for most of the attributes
    /// to
    /// propagate throughout the Amazon SQS system. Changes made to the
    /// `MessageRetentionPeriod` attribute can take up to 15 minutes and
    /// will impact existing messages in the queue potentially causing them to be
    /// expired and deleted if the `MessageRetentionPeriod` is reduced below
    /// the age of existing messages.
    ///
    /// * `Policy` – Returns the policy of the queue.
    ///
    /// * `QueueArn` – Returns the Amazon resource name (ARN) of the
    /// queue.
    ///
    /// * `ReceiveMessageWaitTimeSeconds` – Returns the length of
    /// time, in seconds, for which the `ReceiveMessage` action waits for a
    /// message to arrive.
    ///
    /// * `VisibilityTimeout` – Returns the visibility timeout for the
    /// queue. For more information about the visibility timeout, see [Visibility
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
    /// * `KmsMasterKeyId` – Returns the ID of an Amazon Web Services managed
    ///   customer
    /// master key (CMK) for Amazon SQS or a custom CMK. For more information, see
    /// [Key
    /// Terms](https://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/sqs-server-side-encryption.html#sqs-sse-key-terms).
    ///
    /// * `KmsDataKeyReusePeriodSeconds` – Returns the length of time,
    /// in seconds, for which Amazon SQS can reuse a data key to encrypt or decrypt
    /// messages before calling KMS again. For more information, see
    /// [How Does the Data Key Reuse Period
    /// Work?](https://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/sqs-server-side-encryption.html#sqs-how-does-the-data-key-reuse-period-work).
    ///
    /// * `SqsManagedSseEnabled` – Returns information about whether the
    /// queue is using SSE-SQS encryption using SQS owned encryption keys. Only one
    /// server-side encryption option is supported per queue (for example,
    /// [SSE-KMS](https://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/sqs-configure-sse-existing-queue.html) or [SSE-SQS](https://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/sqs-configure-sqs-sse-queue.html)).
    ///
    /// The following attributes apply only to [FIFO (first-in-first-out)
    /// queues](https://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/FIFO-queues.html):
    ///
    /// * `FifoQueue` – Returns information about whether the queue is
    /// FIFO. For more information, see [FIFO queue
    /// logic](https://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/FIFO-queues-understanding-logic.html) in the *Amazon SQS Developer
    /// Guide*.
    ///
    /// To determine whether a queue is
    /// [FIFO](https://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/FIFO-queues.html), you can check whether `QueueName` ends with the `.fifo` suffix.
    ///
    /// * `ContentBasedDeduplication` – Returns whether content-based
    /// deduplication is enabled for the queue. For more information, see
    /// [Exactly-once
    /// processing](https://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/FIFO-queues-exactly-once-processing.html) in the *Amazon SQS Developer
    /// Guide*.
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
    attribute_names: ?[]const QueueAttributeName = null,

    /// The URL of the Amazon SQS queue whose attribute information is retrieved.
    ///
    /// Queue URLs and names are case-sensitive.
    queue_url: []const u8,

    pub const json_field_names = .{
        .attribute_names = "AttributeNames",
        .queue_url = "QueueUrl",
    };
};

pub const GetQueueAttributesOutput = struct {
    /// A map of attributes to their respective values.
    attributes: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .attributes = "Attributes",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetQueueAttributesInput, options: CallOptions) !GetQueueAttributesOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "sqs", client.config.http_client.clock_skew_offset);

    var response = try client.config.http_client.sendRequestWithOptions(&request, client.options);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch return error.OutOfMemory;
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: GetQueueAttributesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("sqs", "SQS", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "AmazonSQS.GetQueueAttributes");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetQueueAttributesOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GetQueueAttributesOutput, body, allocator);
}

fn parseErrorResponse(allocator: std.mem.Allocator, body: []const u8, status: u16) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.findScalarLast(u8, type_str, '#')) |idx| {
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
        const parsed_error: ?errors.BatchEntryIdsNotDistinct = aws.json.parseJsonObject(errors.BatchEntryIdsNotDistinct, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .batch_entry_ids_not_distinct = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "BatchRequestTooLong")) {
        const parsed_error: ?errors.BatchRequestTooLong = aws.json.parseJsonObject(errors.BatchRequestTooLong, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .batch_request_too_long = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "EmptyBatchRequest")) {
        const parsed_error: ?errors.EmptyBatchRequest = aws.json.parseJsonObject(errors.EmptyBatchRequest, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .empty_batch_request = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidAddress")) {
        const parsed_error: ?errors.InvalidAddress = aws.json.parseJsonObject(errors.InvalidAddress, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_address = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidAttributeName")) {
        const parsed_error: ?errors.InvalidAttributeName = aws.json.parseJsonObject(errors.InvalidAttributeName, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_attribute_name = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidAttributeValue")) {
        const parsed_error: ?errors.InvalidAttributeValue = aws.json.parseJsonObject(errors.InvalidAttributeValue, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_attribute_value = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidBatchEntryId")) {
        const parsed_error: ?errors.InvalidBatchEntryId = aws.json.parseJsonObject(errors.InvalidBatchEntryId, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_batch_entry_id = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidIdFormat")) {
        const parsed_error: ?errors.InvalidIdFormat = aws.json.parseJsonObject(errors.InvalidIdFormat, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_id_format = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidMessageContents")) {
        const parsed_error: ?errors.InvalidMessageContents = aws.json.parseJsonObject(errors.InvalidMessageContents, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_message_contents = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidSecurity")) {
        const parsed_error: ?errors.InvalidSecurity = aws.json.parseJsonObject(errors.InvalidSecurity, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_security = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "KmsAccessDenied")) {
        const parsed_error: ?errors.KmsAccessDenied = aws.json.parseJsonObject(errors.KmsAccessDenied, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .kms_access_denied = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "KmsDisabled")) {
        const parsed_error: ?errors.KmsDisabled = aws.json.parseJsonObject(errors.KmsDisabled, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .kms_disabled = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "KmsInvalidKeyUsage")) {
        const parsed_error: ?errors.KmsInvalidKeyUsage = aws.json.parseJsonObject(errors.KmsInvalidKeyUsage, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .kms_invalid_key_usage = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "KmsInvalidState")) {
        const parsed_error: ?errors.KmsInvalidState = aws.json.parseJsonObject(errors.KmsInvalidState, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .kms_invalid_state = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "KmsNotFound")) {
        const parsed_error: ?errors.KmsNotFound = aws.json.parseJsonObject(errors.KmsNotFound, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .kms_not_found = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "KmsOptInRequired")) {
        const parsed_error: ?errors.KmsOptInRequired = aws.json.parseJsonObject(errors.KmsOptInRequired, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .kms_opt_in_required = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "KmsThrottled")) {
        const parsed_error: ?errors.KmsThrottled = aws.json.parseJsonObject(errors.KmsThrottled, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .kms_throttled = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "MessageNotInflight")) {
        const parsed_error: ?errors.MessageNotInflight = aws.json.parseJsonObject(errors.MessageNotInflight, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .message_not_inflight = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "OverLimit")) {
        const parsed_error: ?errors.OverLimit = aws.json.parseJsonObject(errors.OverLimit, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .over_limit = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "PurgeQueueInProgress")) {
        const parsed_error: ?errors.PurgeQueueInProgress = aws.json.parseJsonObject(errors.PurgeQueueInProgress, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .purge_queue_in_progress = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "QueueDeletedRecently")) {
        const parsed_error: ?errors.QueueDeletedRecently = aws.json.parseJsonObject(errors.QueueDeletedRecently, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .queue_deleted_recently = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "QueueDoesNotExist")) {
        const parsed_error: ?errors.QueueDoesNotExist = aws.json.parseJsonObject(errors.QueueDoesNotExist, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .queue_does_not_exist = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "QueueNameExists")) {
        const parsed_error: ?errors.QueueNameExists = aws.json.parseJsonObject(errors.QueueNameExists, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .queue_name_exists = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ReceiptHandleIsInvalid")) {
        const parsed_error: ?errors.ReceiptHandleIsInvalid = aws.json.parseJsonObject(errors.ReceiptHandleIsInvalid, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .receipt_handle_is_invalid = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "RequestThrottled")) {
        const parsed_error: ?errors.RequestThrottled = aws.json.parseJsonObject(errors.RequestThrottled, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .request_throttled = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ResourceNotFoundException")) {
        const parsed_error: ?errors.ResourceNotFoundException = aws.json.parseJsonObject(errors.ResourceNotFoundException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .resource_not_found_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "TooManyEntriesInBatchRequest")) {
        const parsed_error: ?errors.TooManyEntriesInBatchRequest = aws.json.parseJsonObject(errors.TooManyEntriesInBatchRequest, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .too_many_entries_in_batch_request = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "UnsupportedOperation")) {
        const parsed_error: ?errors.UnsupportedOperation = aws.json.parseJsonObject(errors.UnsupportedOperation, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .unsupported_operation = typed_error } };
        }
    }

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
