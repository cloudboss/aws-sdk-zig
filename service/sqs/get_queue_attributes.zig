const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const QueueAttributeName = @import("queue_attribute_name.zig").QueueAttributeName;

/// Gets attributes for the specified queue.
///
/// **Note:**
///
/// To determine whether a queue is
/// [FIFO](https://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/FIFO-queues.html), you can check whether `QueueName` ends with the `.fifo` suffix.
pub const GetQueueAttributesInput = struct {
    /// A list of attributes for which to retrieve information.
    ///
    /// The `AttributeNames` parameter is optional, but if you don't specify values
    /// for this parameter, the request returns empty results.
    ///
    /// **Note:**
    ///
    /// In the future, new attributes might be added. If you write code that calls
    /// this action, we recommend that you structure your code so that it can handle
    /// new attributes gracefully.
    ///
    /// The following attributes are supported:
    ///
    /// **Important:**
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
    /// **Note:**
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
    /// **Note:**
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

    _arena: std.heap.ArenaAllocator = undefined,

    pub fn deinit(self: *GetQueueAttributesOutput) void {
        self._arena.deinit();
    }

    pub const json_field_names = .{
        .attributes = "Attributes",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, input: GetQueueAttributesInput, options: Options) !GetQueueAttributesOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "sqs");

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

fn serializeRequest(alloc: std.mem.Allocator, input: GetQueueAttributesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpoint("sqs", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const body = try aws.json.jsonStringify(input, alloc);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = "/";
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(alloc, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(alloc, "X-Amz-Target", "AmazonSQS.GetQueueAttributes");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !GetQueueAttributesOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GetQueueAttributesOutput, body, alloc);
}

fn parseErrorResponse(body: []const u8, status: u16) ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";

    if (std.mem.eql(u8, error_code, "BatchEntryIdsNotDistinct")) {
        return .{ .batch_entry_ids_not_distinct = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "BatchRequestTooLong")) {
        return .{ .batch_request_too_long = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "EmptyBatchRequest")) {
        return .{ .empty_batch_request = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "InvalidAddress")) {
        return .{ .invalid_address = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "InvalidAttributeName")) {
        return .{ .invalid_attribute_name = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "InvalidAttributeValue")) {
        return .{ .invalid_attribute_value = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "InvalidBatchEntryId")) {
        return .{ .invalid_batch_entry_id = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "InvalidIdFormat")) {
        return .{ .invalid_id_format = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "InvalidMessageContents")) {
        return .{ .invalid_message_contents = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "InvalidSecurity")) {
        return .{ .invalid_security = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "KmsAccessDenied")) {
        return .{ .kms_access_denied = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "KmsDisabled")) {
        return .{ .kms_disabled = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "KmsInvalidKeyUsage")) {
        return .{ .kms_invalid_key_usage = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "KmsInvalidState")) {
        return .{ .kms_invalid_state = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "KmsNotFound")) {
        return .{ .kms_not_found = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "KmsOptInRequired")) {
        return .{ .kms_opt_in_required = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "KmsThrottled")) {
        return .{ .kms_throttled = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "MessageNotInflight")) {
        return .{ .message_not_inflight = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "OverLimit")) {
        return .{ .over_limit = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "PurgeQueueInProgress")) {
        return .{ .purge_queue_in_progress = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "QueueDeletedRecently")) {
        return .{ .queue_deleted_recently = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "QueueDoesNotExist")) {
        return .{ .queue_does_not_exist = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "QueueNameExists")) {
        return .{ .queue_name_exists = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "ReceiptHandleIsInvalid")) {
        return .{ .receipt_handle_is_invalid = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "RequestThrottled")) {
        return .{ .request_throttled = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "ResourceNotFoundException")) {
        return .{ .resource_not_found_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "TooManyEntriesInBatchRequest")) {
        return .{ .too_many_entries_in_batch_request = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "UnsupportedOperation")) {
        return .{ .unsupported_operation = .{
            .message = error_message,
            .request_id = "",
        } };
    }

    return .{ .unknown = .{
        .code = error_code,
        .message = error_message,
        .request_id = "",
        .http_status = status,
    } };
}
