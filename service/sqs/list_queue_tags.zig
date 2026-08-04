const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const errors = @import("errors.zig");
const ServiceError = errors.ServiceError;

pub const ListQueueTagsInput = struct {
    /// The URL of the queue.
    queue_url: []const u8,

    pub const json_field_names = .{
        .queue_url = "QueueUrl",
    };
};

pub const ListQueueTagsOutput = struct {
    /// The list of all tags added to the specified queue.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .tags = "Tags",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListQueueTagsInput, options: CallOptions) !ListQueueTagsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListQueueTagsInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AmazonSQS.ListQueueTags");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListQueueTagsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListQueueTagsOutput, body, allocator);
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
