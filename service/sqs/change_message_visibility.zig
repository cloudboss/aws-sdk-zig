const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;

/// Changes the visibility timeout of a specified message in a queue to a new
/// value. The
/// default visibility timeout for a message is 30 seconds. The minimum is 0
/// seconds. The
/// maximum is 12 hours. For more information, see [Visibility
/// Timeout](https://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/sqs-visibility-timeout.html) in the *Amazon SQS Developer
/// Guide*.
///
/// For example, if the default timeout for a queue is 60 seconds, 15 seconds
/// have elapsed
/// since you received the message, and you send a ChangeMessageVisibility call
/// with
/// `VisibilityTimeout` set to 10 seconds, the 10 seconds begin to count from
/// the time that you make the `ChangeMessageVisibility` call. Thus, any attempt
/// to change the visibility timeout or to delete that message 10 seconds after
/// you
/// initially change the visibility timeout (a total of 25 seconds) might result
/// in an
/// error.
///
/// An Amazon SQS message has three basic states:
///
/// * Sent to a queue by a producer.
///
/// * Received from the queue by a consumer.
///
/// * Deleted from the queue.
///
/// A message is considered to be *stored* after it is sent to a queue by a
/// producer, but not yet received from the queue by a consumer (that is,
/// between states 1 and 2). There is no limit to the number of stored messages.
/// A message is considered to be *in flight* after it is received from a queue
/// by a consumer, but not yet deleted from the queue (that is, between states 2
/// and 3). There is a limit to the number of in flight messages.
///
/// Limits that apply to in flight messages are unrelated to the *unlimited*
/// number of stored messages.
///
/// For most standard queues (depending on queue traffic and message backlog),
/// there can be a maximum of approximately 120,000 in flight messages (received
/// from a queue by a consumer, but not yet deleted from the queue).
/// If you reach this limit, Amazon SQS returns the `OverLimit` error message.
/// To avoid reaching the limit, you should delete messages from the queue after
/// they're processed. You can also increase the number of queues you use to
/// process your messages.
/// To request a limit increase, [file a support
/// request](https://console.aws.amazon.com/support/home#/case/create?issueType=service-limit-increase&limitType=service-code-sqs).
///
/// For FIFO queues, there can be a maximum of 120,000 in flight messages
/// (received from a queue by a consumer, but not yet deleted from the queue).
/// If you reach this limit, Amazon SQS returns no error messages.
///
/// **Important:**
///
/// If you attempt to set the `VisibilityTimeout` to a value greater than
/// the maximum time left, Amazon SQS returns an error. Amazon SQS doesn't
/// automatically
/// recalculate and increase the timeout to the maximum remaining time.
///
/// Unlike with a queue, when you change the visibility timeout for a specific
/// message
/// the timeout value is applied immediately but isn't saved in memory for that
/// message.
/// If you don't delete a message after it is received, the visibility timeout
/// for the
/// message reverts to the original timeout value (not to the value you set
/// using the
/// `ChangeMessageVisibility` action) the next time the message is
/// received.
pub const ChangeMessageVisibilityInput = struct {
    /// The URL of the Amazon SQS queue whose message's visibility is changed.
    ///
    /// Queue URLs and names are case-sensitive.
    queue_url: []const u8,

    /// The receipt handle associated with the message, whose visibility timeout is
    /// changed.
    /// This parameter is returned by the `
    /// ReceiveMessage
    /// `
    /// action.
    receipt_handle: []const u8,

    /// The new value for the message's visibility timeout (in seconds). Values
    /// range:
    /// `0` to `43200`. Maximum: 12 hours.
    visibility_timeout: i32,

    pub const json_field_names = .{
        .queue_url = "QueueUrl",
        .receipt_handle = "ReceiptHandle",
        .visibility_timeout = "VisibilityTimeout",
    };
};

pub const ChangeMessageVisibilityOutput = struct {

    _arena: std.heap.ArenaAllocator = undefined,

    pub fn deinit(self: *ChangeMessageVisibilityOutput) void {
        self._arena.deinit();
    }
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, input: ChangeMessageVisibilityInput, options: Options) !ChangeMessageVisibilityOutput {
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

fn serializeRequest(alloc: std.mem.Allocator, input: ChangeMessageVisibilityInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(alloc, "X-Amz-Target", "AmazonSQS.ChangeMessageVisibility");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !ChangeMessageVisibilityOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = alloc;
    return .{};
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
