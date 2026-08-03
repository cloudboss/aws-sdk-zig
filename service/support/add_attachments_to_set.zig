const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const errors = @import("errors.zig");
const ServiceError = errors.ServiceError;
const Attachment = @import("attachment.zig").Attachment;

pub const AddAttachmentsToSetInput = struct {
    /// One or more attachments to add to the set. You can add up to three
    /// attachments per
    /// set. The size limit is 5 MB per attachment.
    ///
    /// In the `Attachment` object, use the `data` parameter to specify
    /// the contents of the attachment file. In the previous request syntax, the
    /// value for
    /// `data` appear as `blob`, which is represented as a
    /// base64-encoded string. The value for `fileName` is the name of the
    /// attachment, such as `troubleshoot-screenshot.png`.
    attachments: []const Attachment,

    /// The ID of the attachment set. If an `attachmentSetId` is not specified, a
    /// new attachment set is created, and the ID of the set is returned in the
    /// response. If an
    /// `attachmentSetId` is specified, the attachments are added to the
    /// specified set, if it exists.
    attachment_set_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .attachments = "attachments",
        .attachment_set_id = "attachmentSetId",
    };
};

pub const AddAttachmentsToSetOutput = struct {
    /// The ID of the attachment set. If an `attachmentSetId` was not specified, a
    /// new attachment set is created, and the ID of the set is returned in the
    /// response. If an
    /// `attachmentSetId` was specified, the attachments are added to the
    /// specified set, if it exists.
    attachment_set_id: ?[]const u8 = null,

    /// The time and date when the attachment set expires.
    expiry_time: ?[]const u8 = null,

    pub const json_field_names = .{
        .attachment_set_id = "attachmentSetId",
        .expiry_time = "expiryTime",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: AddAttachmentsToSetInput, options: CallOptions) !AddAttachmentsToSetOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "support", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: AddAttachmentsToSetInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("support", "Support", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWSSupport_20130415.AddAttachmentsToSet");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !AddAttachmentsToSetOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(AddAttachmentsToSetOutput, body, allocator);
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

    if (std.mem.eql(u8, error_code, "AttachmentIdNotFound")) {
        const parsed_error: ?errors.AttachmentIdNotFound = aws.json.parseJsonObject(errors.AttachmentIdNotFound, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .attachment_id_not_found = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "AttachmentLimitExceeded")) {
        const parsed_error: ?errors.AttachmentLimitExceeded = aws.json.parseJsonObject(errors.AttachmentLimitExceeded, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .attachment_limit_exceeded = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "AttachmentSetExpired")) {
        const parsed_error: ?errors.AttachmentSetExpired = aws.json.parseJsonObject(errors.AttachmentSetExpired, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .attachment_set_expired = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "AttachmentSetIdNotFound")) {
        const parsed_error: ?errors.AttachmentSetIdNotFound = aws.json.parseJsonObject(errors.AttachmentSetIdNotFound, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .attachment_set_id_not_found = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "AttachmentSetSizeLimitExceeded")) {
        const parsed_error: ?errors.AttachmentSetSizeLimitExceeded = aws.json.parseJsonObject(errors.AttachmentSetSizeLimitExceeded, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .attachment_set_size_limit_exceeded = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "CaseCreationLimitExceeded")) {
        const parsed_error: ?errors.CaseCreationLimitExceeded = aws.json.parseJsonObject(errors.CaseCreationLimitExceeded, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .case_creation_limit_exceeded = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "CaseIdNotFound")) {
        const parsed_error: ?errors.CaseIdNotFound = aws.json.parseJsonObject(errors.CaseIdNotFound, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .case_id_not_found = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "DescribeAttachmentLimitExceeded")) {
        const parsed_error: ?errors.DescribeAttachmentLimitExceeded = aws.json.parseJsonObject(errors.DescribeAttachmentLimitExceeded, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .describe_attachment_limit_exceeded = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InternalServerError")) {
        const parsed_error: ?errors.InternalServerError = aws.json.parseJsonObject(errors.InternalServerError, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .internal_server_error = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ThrottlingException")) {
        const parsed_error: ?errors.ThrottlingException = aws.json.parseJsonObject(errors.ThrottlingException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .throttling_exception = typed_error } };
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
