const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;

/// Creates a new standard or FIFO queue. You can pass one or more attributes in
/// the request. Keep the following in mind:
///
/// * If you don't specify the `FifoQueue` attribute, Amazon SQS creates a
///   standard queue.
///
/// **Note:**
///
/// You can't change the queue type after you create it and you can't convert
/// an existing standard queue into a FIFO queue. You must either create a new
/// FIFO queue for your application or delete your existing standard queue and
/// recreate it as a FIFO queue. For more information, see [Moving From a
/// standard queue to a FIFO
/// queue](https://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/FIFO-queues.html#FIFO-queues-moving) in the
/// *Amazon SQS Developer Guide*.
///
/// * If you don't provide a value for an attribute, the queue is created with
///   the
/// default value for the attribute.
///
/// * If you delete a queue, you must wait at least 60 seconds before creating a
/// queue with the same name.
///
/// To successfully create a new queue, you must provide a queue name that
/// adheres to the
/// [limits
/// related to
/// queues](https://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/limits-queues.html) and is unique within the scope of your queues.
///
/// **Note:**
///
/// After you create a queue, you must wait at least one second after the queue
/// is
/// created to be able to use the queue.
///
/// To retrieve the URL of a queue, use the [
/// `GetQueueUrl`
/// ](https://docs.aws.amazon.com/AWSSimpleQueueService/latest/APIReference/API_GetQueueUrl.html) action. This action only requires the [
/// `QueueName`
/// ](https://docs.aws.amazon.com/AWSSimpleQueueService/latest/APIReference/API_CreateQueue.html#API_CreateQueue_RequestSyntax) parameter.
///
/// When creating queues, keep the following points in mind:
///
/// * If you specify the name of an existing queue and provide the exact same
///   names
/// and values for all its attributes, the [
/// `CreateQueue`
/// ](https://docs.aws.amazon.com/AWSSimpleQueueService/latest/APIReference/API_CreateQueue.html) action will return the URL of the
/// existing queue instead of creating a new one.
///
/// * If you attempt to create a queue with a name that already exists but with
/// different attribute names or values, the `CreateQueue` action will
/// return an error. This ensures that existing queues are not inadvertently
/// altered.
///
/// **Note:**
///
/// Cross-account permissions don't apply to this action. For more information,
/// see [Grant
/// cross-account permissions to a role and a
/// username](https://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/sqs-customer-managed-policy-examples.html#grant-cross-account-permissions-to-role-and-user-name) in the *Amazon SQS Developer Guide*.
pub const CreateQueueInput = struct {
    /// A map of attributes with their corresponding values.
    ///
    /// The following lists the names, descriptions, and values of the special
    /// request
    /// parameters that the `CreateQueue` action uses:
    ///
    /// * `DelaySeconds` – The length of time, in seconds, for which the
    /// delivery of all messages in the queue is delayed. Valid values: An integer
    /// from
    /// 0 to 900 seconds (15 minutes). Default: 0.
    ///
    /// * `MaximumMessageSize` – The limit of how many bytes a message
    /// can contain before Amazon SQS rejects it. Valid values: An integer from
    /// 1,024 bytes
    /// (1 KiB) to 1,048,576 bytes (1 MiB). Default: 1,048,576 bytes (1 MiB).
    ///
    /// * `MessageRetentionPeriod` – The length of time, in seconds, for
    /// which Amazon SQS retains a message. Valid values: An integer from 60 seconds
    /// (1
    /// minute) to 1,209,600 seconds (14 days). Default: 345,600 (4 days). When you
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
    /// Policies](https://docs.aws.amazon.com/IAM/latest/UserGuide/PoliciesOverview.html) in the *IAM User Guide*.
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
    /// **Note:**
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
    /// Terms](https://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/sqs-server-side-encryption.html#sqs-sse-key-terms). While the alias of the Amazon Web Services managed CMK for Amazon SQS is
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
    /// Work?](https://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/sqs-server-side-encryption.html#sqs-how-does-the-data-key-reuse-period-work)
    ///
    /// * `SqsManagedSseEnabled` – Enables server-side queue encryption
    /// using SQS owned encryption keys. Only one server-side encryption option is
    /// supported per queue (for example,
    /// [SSE-KMS](https://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/sqs-configure-sse-existing-queue.html) or [SSE-SQS](https://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/sqs-configure-sqs-sse-queue.html)).
    ///
    /// The following attributes apply only to [FIFO (first-in-first-out)
    /// queues](https://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/FIFO-queues.html):
    ///
    /// * `FifoQueue` – Designates a queue as FIFO. Valid values are
    /// `true` and `false`. If you don't specify the `FifoQueue` attribute, Amazon
    /// SQS creates a standard queue. You
    /// can provide this attribute only during queue creation. You can't change it
    /// for
    /// an existing queue. When you set this attribute, you must also provide the
    /// `MessageGroupId` for your messages explicitly.
    ///
    /// For more information, see [FIFO queue
    /// logic](https://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/FIFO-queues-understanding-logic.html) in the *Amazon SQS Developer
    /// Guide*.
    ///
    /// * `ContentBasedDeduplication` – Enables content-based
    /// deduplication. Valid values are `true` and `false`. For
    /// more information, see [Exactly-once
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
    attributes: ?[]const aws.map.StringMapEntry = null,

    /// The name of the new queue. The following limits apply to this name:
    ///
    /// * A queue name can have up to 80 characters.
    ///
    /// * Valid values: alphanumeric characters, hyphens (`-`), and
    /// underscores (`_`).
    ///
    /// * A FIFO queue name must end with the `.fifo` suffix.
    ///
    /// Queue URLs and names are case-sensitive.
    queue_name: []const u8,

    /// Add cost allocation tags to the specified Amazon SQS queue. For an overview,
    /// see [Tagging
    /// Your Amazon SQS
    /// Queues](https://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/sqs-queue-tags.html) in the *Amazon SQS Developer Guide*.
    ///
    /// When you use queue tags, keep the following guidelines in mind:
    ///
    /// * Adding more than 50 tags to a queue isn't recommended.
    ///
    /// * Tags don't have any semantic meaning. Amazon SQS interprets tags as
    ///   character strings.
    ///
    /// * Tags are case-sensitive.
    ///
    /// * A new tag with a key identical to that of an existing tag overwrites the
    ///   existing tag.
    ///
    /// For a full list of tag restrictions, see
    /// [Quotas related to
    /// queues](https://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/sqs-limits.html#limits-queues)
    /// in the *Amazon SQS Developer Guide*.
    ///
    /// **Note:**
    ///
    /// To be able to tag a queue on creation, you must have the
    /// `sqs:CreateQueue` and `sqs:TagQueue` permissions.
    ///
    /// Cross-account permissions don't apply to this action. For more information,
    /// see [Grant
    /// cross-account permissions to a role and a
    /// username](https://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/sqs-customer-managed-policy-examples.html#grant-cross-account-permissions-to-role-and-user-name) in the *Amazon SQS Developer Guide*.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .attributes = "Attributes",
        .queue_name = "QueueName",
        .tags = "tags",
    };
};

pub const CreateQueueOutput = struct {
    /// The URL of the created Amazon SQS queue.
    queue_url: ?[]const u8 = null,

    _arena: std.heap.ArenaAllocator = undefined,

    pub fn deinit(self: *CreateQueueOutput) void {
        self._arena.deinit();
    }

    pub const json_field_names = .{
        .queue_url = "QueueUrl",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, input: CreateQueueInput, options: Options) !CreateQueueOutput {
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

fn serializeRequest(alloc: std.mem.Allocator, input: CreateQueueInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(alloc, "X-Amz-Target", "AmazonSQS.CreateQueue");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !CreateQueueOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateQueueOutput, body, alloc);
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
