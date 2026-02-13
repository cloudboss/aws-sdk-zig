const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;

/// Deletes the specified message from the specified queue. To select the
/// message to
/// delete, use the `ReceiptHandle` of the message (*not* the
/// `MessageId` which you receive when you send the message). Amazon SQS can
/// delete a message from a queue even if a visibility timeout setting causes
/// the message to
/// be locked by another consumer. Amazon SQS automatically deletes messages
/// left in a queue
/// longer than the retention period configured for the queue.
///
/// **Note:**
///
/// Each time you receive a message, meaning when a consumer retrieves a message
/// from
/// the queue, it comes with a unique `ReceiptHandle`. If you receive the
/// same message more than once, you will get a different `ReceiptHandle`
/// each time. When you want to delete a message using the `DeleteMessage`
/// action, you must use the `ReceiptHandle` from the most recent time you
/// received the message. If you use an old `ReceiptHandle`, the request will
/// succeed, but the message might not be deleted.
///
/// For standard queues, it is possible to receive a message even after you
/// delete it. This might happen on rare occasions if one of the servers which
/// stores a
/// copy of the message is unavailable when you send the request to delete the
/// message.
/// The copy remains on the server and might be returned to you during a
/// subsequent
/// receive request. You should ensure that your application is idempotent, so
/// that
/// receiving a message more than once does not cause issues.
pub const DeleteMessageInput = struct {
    /// The URL of the Amazon SQS queue from which messages are deleted.
    ///
    /// Queue URLs and names are case-sensitive.
    queue_url: []const u8,

    /// The receipt handle associated with the message to delete.
    receipt_handle: []const u8,

    pub const json_field_names = .{
        .queue_url = "QueueUrl",
        .receipt_handle = "ReceiptHandle",
    };
};

pub const DeleteMessageOutput = struct {

    _arena: std.heap.ArenaAllocator = undefined,

    pub fn deinit(self: *DeleteMessageOutput) void {
        self._arena.deinit();
    }
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, input: DeleteMessageInput, options: Options) !DeleteMessageOutput {
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

fn serializeRequest(alloc: std.mem.Allocator, input: DeleteMessageInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(alloc, "X-Amz-Target", "AmazonSQS.DeleteMessage");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !DeleteMessageOutput {
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
