const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const QueueAttributeName = @import("queue_attribute_name.zig").QueueAttributeName;
const MessageSystemAttributeName = @import("message_system_attribute_name.zig").MessageSystemAttributeName;
const Message = @import("message.zig").Message;

pub const ReceiveMessageInput = struct {
    /// This parameter has been discontinued but will be supported for backward
    /// compatibility. To provide attribute names, you are encouraged to use
    /// `MessageSystemAttributeNames`.
    ///
    /// A list of attributes that need to be returned along with each message. These
    /// attributes include:
    ///
    /// * `All` – Returns all values.
    ///
    /// * `ApproximateFirstReceiveTimestamp` – Returns the time the
    /// message was first received from the queue ([epoch
    /// time](http://en.wikipedia.org/wiki/Unix_time) in
    /// milliseconds).
    ///
    /// * `ApproximateReceiveCount` – Returns the number of times a
    /// message has been received across all queues but not deleted.
    ///
    /// * `AWSTraceHeader` – Returns the X-Ray trace
    /// header string.
    ///
    /// * `SenderId`
    ///
    /// * For a user, returns the user ID, for example
    /// `ABCDEFGHI1JKLMNOPQ23R`.
    ///
    /// * For an IAM role, returns the IAM role ID, for example
    /// `ABCDE1F2GH3I4JK5LMNOP:i-a123b456`.
    ///
    /// * `SentTimestamp` – Returns the time the message was sent to the
    /// queue ([epoch time](http://en.wikipedia.org/wiki/Unix_time) in
    /// milliseconds).
    ///
    /// * `SqsManagedSseEnabled` – Enables server-side queue encryption
    /// using SQS owned encryption keys. Only one server-side encryption option is
    /// supported per queue (for example,
    /// [SSE-KMS](https://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/sqs-configure-sse-existing-queue.html) or [SSE-SQS](https://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/sqs-configure-sqs-sse-queue.html)).
    ///
    /// * `MessageDeduplicationId` – Returns the value provided by the
    /// producer that calls the `
    /// SendMessage
    /// `
    /// action.
    ///
    /// * `MessageGroupId` – Returns the value provided by the
    /// producer that calls the `
    /// SendMessage
    /// ` action.
    ///
    /// * `SequenceNumber` – Returns the value provided by
    /// Amazon SQS.
    attribute_names: ?[]const QueueAttributeName = null,

    /// The maximum number of messages to return. Amazon SQS never returns more
    /// messages than this
    /// value (however, fewer messages might be returned). Valid values: 1 to 10.
    /// Default:
    /// 1.
    max_number_of_messages: ?i32 = null,

    /// The name of the message attribute, where *N* is the index.
    ///
    /// * The name can contain alphanumeric characters and the underscore
    /// (`_`), hyphen (`-`), and period
    /// (`.`).
    ///
    /// * The name is case-sensitive and must be unique among all attribute names
    ///   for
    /// the message.
    ///
    /// * The name must not start with AWS-reserved prefixes such as `AWS.`
    /// or `Amazon.` (or any casing variants).
    ///
    /// * The name must not start or end with a period (`.`), and it should
    /// not have periods in succession (`..`).
    ///
    /// * The name can be up to 256 characters long.
    ///
    /// When using `ReceiveMessage`, you can send a list of attribute names to
    /// receive, or you can return all of the attributes by specifying `All` or
    /// `.*` in your request. You can also use all message attributes starting
    /// with a prefix, for example `bar.*`.
    message_attribute_names: ?[]const []const u8 = null,

    /// A list of attributes that need to be returned along with each message. These
    /// attributes include:
    ///
    /// * `All` – Returns all values.
    ///
    /// * `ApproximateFirstReceiveTimestamp` – Returns the time the
    /// message was first received from the queue ([epoch
    /// time](http://en.wikipedia.org/wiki/Unix_time) in
    /// milliseconds).
    ///
    /// * `ApproximateReceiveCount` – Returns the number of times a
    /// message has been received across all queues but not deleted.
    ///
    /// * `AWSTraceHeader` – Returns the X-Ray trace
    /// header string.
    ///
    /// * `SenderId`
    ///
    /// * For a user, returns the user ID, for example
    /// `ABCDEFGHI1JKLMNOPQ23R`.
    ///
    /// * For an IAM role, returns the IAM role ID, for example
    /// `ABCDE1F2GH3I4JK5LMNOP:i-a123b456`.
    ///
    /// * `SentTimestamp` – Returns the time the message was sent to the
    /// queue ([epoch time](http://en.wikipedia.org/wiki/Unix_time) in
    /// milliseconds).
    ///
    /// * `SqsManagedSseEnabled` – Enables server-side queue encryption
    /// using SQS owned encryption keys. Only one server-side encryption option is
    /// supported per queue (for example,
    /// [SSE-KMS](https://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/sqs-configure-sse-existing-queue.html) or [SSE-SQS](https://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/sqs-configure-sqs-sse-queue.html)).
    ///
    /// * `MessageDeduplicationId` – Returns the value provided by the
    /// producer that calls the `
    /// SendMessage
    /// `
    /// action.
    ///
    /// * `MessageGroupId` – Returns the value provided by the
    /// producer that calls the `
    /// SendMessage
    /// ` action.
    ///
    /// * `SequenceNumber` – Returns the value provided by
    /// Amazon SQS.
    message_system_attribute_names: ?[]const MessageSystemAttributeName = null,

    /// The URL of the Amazon SQS queue from which messages are received.
    ///
    /// Queue URLs and names are case-sensitive.
    queue_url: []const u8,

    /// This parameter applies only to FIFO (first-in-first-out) queues.
    ///
    /// The token used for deduplication of `ReceiveMessage` calls. If a networking
    /// issue occurs after a `ReceiveMessage` action, and instead of a response you
    /// receive a generic error, it is possible to retry the same action with an
    /// identical
    /// `ReceiveRequestAttemptId` to retrieve the same set of messages, even if
    /// their visibility timeout has not yet expired.
    ///
    /// * You can use `ReceiveRequestAttemptId` only for 5 minutes after a
    /// `ReceiveMessage` action.
    ///
    /// * When you set `FifoQueue`, a caller of the
    /// `ReceiveMessage` action can provide a
    /// `ReceiveRequestAttemptId` explicitly.
    ///
    /// * It is possible to retry the `ReceiveMessage` action with the same
    /// `ReceiveRequestAttemptId` if none of the messages have been
    /// modified (deleted or had their visibility changes).
    ///
    /// * During a visibility timeout, subsequent calls with the same
    /// `ReceiveRequestAttemptId` return the same messages and receipt
    /// handles. If a retry occurs within the deduplication interval, it resets the
    /// visibility timeout. For more information, see [Visibility
    /// Timeout](https://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/sqs-visibility-timeout.html) in the *Amazon SQS Developer
    /// Guide*.
    ///
    /// If a caller of the `ReceiveMessage` action still processes
    /// messages when the visibility timeout expires and messages become visible,
    /// another worker consuming from the same queue can receive the same messages
    /// and therefore process duplicates. Also, if a consumer whose message
    /// processing time is longer than the visibility timeout tries to delete the
    /// processed messages, the action fails with an error.
    ///
    /// To mitigate this effect, ensure that your application observes a safe
    /// threshold before the visibility timeout expires and extend the visibility
    /// timeout as necessary.
    ///
    /// * While messages with a particular `MessageGroupId` are invisible,
    /// no more messages belonging to the same `MessageGroupId` are returned
    /// until the visibility timeout expires. You can still receive messages
    /// with another `MessageGroupId` from your FIFO queue as long as they are
    /// visible.
    ///
    /// * If a caller of `ReceiveMessage` can't track the
    /// `ReceiveRequestAttemptId`, no retries work until the original
    /// visibility timeout expires. As a result, delays might occur but the messages
    /// in
    /// the queue remain in a strict order.
    ///
    /// The maximum length of `ReceiveRequestAttemptId` is 128 characters.
    /// `ReceiveRequestAttemptId` can contain alphanumeric characters
    /// (`a-z`, `A-Z`, `0-9`) and punctuation
    /// (`!"#$%&'()*+,-./:;?@[\]^_`{|}~`).
    ///
    /// For best practices of using `ReceiveRequestAttemptId`, see [Using the
    /// ReceiveRequestAttemptId Request
    /// Parameter](https://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/using-receiverequestattemptid-request-parameter.html) in the *Amazon SQS
    /// Developer Guide*.
    receive_request_attempt_id: ?[]const u8 = null,

    /// The duration (in seconds) that the received messages are hidden from
    /// subsequent
    /// retrieve requests after being retrieved by a `ReceiveMessage` request. If
    /// not
    /// specified, the default visibility timeout for the queue is used, which is 30
    /// seconds.
    ///
    /// Understanding `VisibilityTimeout`:
    ///
    /// * When a message is received from a queue, it becomes temporarily invisible
    ///   to
    /// other consumers for the duration of the visibility timeout. This prevents
    /// multiple consumers from processing the same message simultaneously. If the
    /// message is not deleted or its visibility timeout is not extended before the
    /// timeout expires, it becomes visible again and can be retrieved by other
    /// consumers.
    ///
    /// * Setting an appropriate visibility timeout is crucial. If it's too short,
    ///   the
    /// message might become visible again before processing is complete, leading to
    /// duplicate processing. If it's too long, it delays the reprocessing of
    /// messages
    /// if the initial processing fails.
    ///
    /// * You can adjust the visibility timeout using the
    /// `--visibility-timeout` parameter in the
    /// `receive-message` command to match the processing time required
    /// by your application.
    ///
    /// * A message that isn't deleted or a message whose visibility isn't extended
    /// before the visibility timeout expires counts as a failed receive. Depending
    /// on
    /// the configuration of the queue, the message might be sent to the dead-letter
    /// queue.
    ///
    /// For more information, see [Visibility
    /// Timeout](https://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/sqs-visibility-timeout.html) in the *Amazon SQS Developer
    /// Guide*.
    visibility_timeout: ?i32 = null,

    /// The duration (in seconds) for which the call waits for a message to arrive
    /// in the
    /// queue before returning. If a message is available, the call returns sooner
    /// than
    /// `WaitTimeSeconds`. If no messages are available and the wait time
    /// expires, the call does not return a message list. If you are using the Java
    /// SDK, it
    /// returns a `ReceiveMessageResponse` object, which has a empty list instead of
    /// a Null object.
    ///
    /// To avoid HTTP errors, ensure that the HTTP response timeout for
    /// `ReceiveMessage` requests is longer than the
    /// `WaitTimeSeconds` parameter. For example, with the Java SDK, you can
    /// set HTTP transport settings using the [
    /// NettyNioAsyncHttpClient](https://sdk.amazonaws.com/java/api/latest/software/amazon/awssdk/http/nio/netty/NettyNioAsyncHttpClient.html) for asynchronous clients, or the [ ApacheHttpClient](https://sdk.amazonaws.com/java/api/latest/software/amazon/awssdk/http/apache/ApacheHttpClient.html) for synchronous clients.
    wait_time_seconds: ?i32 = null,

    pub const json_field_names = .{
        .attribute_names = "AttributeNames",
        .max_number_of_messages = "MaxNumberOfMessages",
        .message_attribute_names = "MessageAttributeNames",
        .message_system_attribute_names = "MessageSystemAttributeNames",
        .queue_url = "QueueUrl",
        .receive_request_attempt_id = "ReceiveRequestAttemptId",
        .visibility_timeout = "VisibilityTimeout",
        .wait_time_seconds = "WaitTimeSeconds",
    };
};

pub const ReceiveMessageOutput = struct {
    /// A list of messages.
    messages: ?[]const Message = null,

    _arena: std.heap.ArenaAllocator = undefined,

    pub fn deinit(self: *ReceiveMessageOutput) void {
        self._arena.deinit();
    }

    pub const json_field_names = .{
        .messages = "Messages",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, input: ReceiveMessageInput, options: Options) !ReceiveMessageOutput {
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

fn serializeRequest(alloc: std.mem.Allocator, input: ReceiveMessageInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(alloc, "X-Amz-Target", "AmazonSQS.ReceiveMessage");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !ReceiveMessageOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ReceiveMessageOutput, body, alloc);
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
