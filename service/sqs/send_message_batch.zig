const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const SendMessageBatchRequestEntry = @import("send_message_batch_request_entry.zig").SendMessageBatchRequestEntry;
const BatchResultErrorEntry = @import("batch_result_error_entry.zig").BatchResultErrorEntry;
const SendMessageBatchResultEntry = @import("send_message_batch_result_entry.zig").SendMessageBatchResultEntry;

/// You can use `SendMessageBatch` to send up to 10 messages to the specified
/// queue by assigning either identical or different values to each message (or
/// by not
/// assigning values at all). This is a batch version of `
/// SendMessage.` For a FIFO queue, multiple messages within a single batch are
/// enqueued
/// in the order they are sent.
///
/// The result of sending each message is reported individually in the response.
/// Because the batch request can result in a combination of successful and
/// unsuccessful actions, you should check for batch errors even when the call
/// returns an HTTP status code of `200`.
///
/// The maximum allowed individual message size and the maximum total payload
/// size (the
/// sum of the individual lengths of all of the batched messages) are both 1 MiB
/// 1,048,576 bytes.
///
/// **Important:**
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
///
/// If you don't specify the `DelaySeconds` parameter for an entry, Amazon SQS
/// uses
/// the default value for the queue.
pub const SendMessageBatchInput = struct {
    /// A list of `
    /// SendMessageBatchRequestEntry
    /// ` items.
    entries: []const SendMessageBatchRequestEntry,

    /// The URL of the Amazon SQS queue to which batched messages are sent.
    ///
    /// Queue URLs and names are case-sensitive.
    queue_url: []const u8,

    pub const json_field_names = .{
        .entries = "Entries",
        .queue_url = "QueueUrl",
    };
};

pub const SendMessageBatchOutput = struct {
    /// A list of `
    /// BatchResultErrorEntry
    /// ` items with error
    /// details about each message that can't be enqueued.
    failed: ?[]const BatchResultErrorEntry = null,

    /// A list of `
    /// SendMessageBatchResultEntry
    /// ` items.
    successful: ?[]const SendMessageBatchResultEntry = null,

    _arena: std.heap.ArenaAllocator = undefined,

    pub fn deinit(self: *SendMessageBatchOutput) void {
        self._arena.deinit();
    }

    pub const json_field_names = .{
        .failed = "Failed",
        .successful = "Successful",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, input: SendMessageBatchInput, options: Options) !SendMessageBatchOutput {
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

fn serializeRequest(alloc: std.mem.Allocator, input: SendMessageBatchInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(alloc, "X-Amz-Target", "AmazonSQS.SendMessageBatch");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !SendMessageBatchOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(SendMessageBatchOutput, body, alloc);
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
