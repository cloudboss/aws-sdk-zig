const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const errors = @import("errors.zig");
const ServiceError = errors.ServiceError;
const CaseDetails = @import("case_details.zig").CaseDetails;

pub const DescribeCasesInput = struct {
    /// The start date for a filtered date search on support case communications.
    /// Case
    /// communications are available for 12 months after creation.
    after_time: ?[]const u8 = null,

    /// The end date for a filtered date search on support case communications. Case
    /// communications are available for 12 months after creation.
    before_time: ?[]const u8 = null,

    /// A list of ID numbers of the support cases you want returned. The maximum
    /// number of
    /// cases is 100.
    case_id_list: ?[]const []const u8 = null,

    /// The ID displayed for a case in the Amazon Web Services Support Center user
    /// interface.
    display_id: ?[]const u8 = null,

    /// Specifies whether to include communications in the `DescribeCases`
    /// response. By default, communications are included.
    include_communications: ?bool = null,

    /// Specifies whether to include resolved support cases in the `DescribeCases`
    /// response. By default, resolved cases aren't included.
    include_resolved_cases: ?bool = null,

    /// The language in which Amazon Web Services Support handles the case. Amazon
    /// Web Services Support
    /// currently supports Chinese (“zh”), English ("en"), Japanese ("ja") and
    /// Korean (“ko”). You must specify the ISO 639-1
    /// code for the `language` parameter if you want support in that language.
    language: ?[]const u8 = null,

    /// The maximum number of results to return before paginating.
    max_results: ?i32 = null,

    /// A resumption point for pagination.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .after_time = "afterTime",
        .before_time = "beforeTime",
        .case_id_list = "caseIdList",
        .display_id = "displayId",
        .include_communications = "includeCommunications",
        .include_resolved_cases = "includeResolvedCases",
        .language = "language",
        .max_results = "maxResults",
        .next_token = "nextToken",
    };
};

pub const DescribeCasesOutput = struct {
    /// The details for the cases that match the request.
    cases: ?[]const CaseDetails = null,

    /// A resumption point for pagination.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .cases = "cases",
        .next_token = "nextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeCasesInput, options: CallOptions) !DescribeCasesOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeCasesInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSSupport_20130415.DescribeCases");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeCasesOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeCasesOutput, body, allocator);
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
