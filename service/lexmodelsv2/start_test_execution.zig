const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const TestExecutionApiMode = @import("test_execution_api_mode.zig").TestExecutionApiMode;
const TestExecutionTarget = @import("test_execution_target.zig").TestExecutionTarget;
const TestExecutionModality = @import("test_execution_modality.zig").TestExecutionModality;

pub const StartTestExecutionInput = struct {
    /// Indicates whether we use streaming or non-streaming APIs for the test set
    /// execution. For streaming, StartConversation Runtime API is used. Whereas,
    /// for
    /// non-streaming, RecognizeUtterance and RecognizeText Amazon Lex
    /// Runtime API are used.
    api_mode: TestExecutionApiMode,

    /// The target bot for the test set execution.
    target: TestExecutionTarget,

    /// Indicates whether audio or text is used.
    test_execution_modality: ?TestExecutionModality = null,

    /// The test set Id for the test set execution.
    test_set_id: []const u8,

    pub const json_field_names = .{
        .api_mode = "apiMode",
        .target = "target",
        .test_execution_modality = "testExecutionModality",
        .test_set_id = "testSetId",
    };
};

pub const StartTestExecutionOutput = struct {
    /// Indicates whether we use streaming or non-streaming APIs for the test set
    /// execution. For streaming, StartConversation Amazon Lex Runtime API is used.
    /// Whereas
    /// for non-streaming, RecognizeUtterance and RecognizeText Amazon Lex Runtime
    /// API are used.
    api_mode: ?TestExecutionApiMode = null,

    /// The creation date and time for the test set execution.
    creation_date_time: ?i64 = null,

    /// The target bot for the test set execution.
    target: ?TestExecutionTarget = null,

    /// The unique identifier of the test set execution.
    test_execution_id: ?[]const u8 = null,

    /// Indicates whether audio or text is used.
    test_execution_modality: ?TestExecutionModality = null,

    /// The test set Id for the test set execution.
    test_set_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .api_mode = "apiMode",
        .creation_date_time = "creationDateTime",
        .target = "target",
        .test_execution_id = "testExecutionId",
        .test_execution_modality = "testExecutionModality",
        .test_set_id = "testSetId",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: StartTestExecutionInput, options: Options) !StartTestExecutionOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "lexmodelsv2");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(response.body, response.status, client.allocator) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(response.body, response.status, response.headers, allocator);
    return result;
}

fn serializeRequest(alloc: std.mem.Allocator, input: StartTestExecutionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("lexmodelsv2", "Lex Models V2", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(alloc, "/testsets/");
    try path_buf.appendSlice(alloc, input.test_set_id);
    try path_buf.appendSlice(alloc, "/testexecutions");
    const path = try path_buf.toOwnedSlice(alloc);

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(alloc, "{");

    if (has_prev) try body_buf.appendSlice(alloc, ",");
    try body_buf.appendSlice(alloc, "\"apiMode\":");
    try aws.json.writeValue(@TypeOf(input.api_mode), input.api_mode, alloc, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(alloc, ",");
    try body_buf.appendSlice(alloc, "\"target\":");
    try aws.json.writeValue(@TypeOf(input.target), input.target, alloc, &body_buf);
    has_prev = true;
    if (input.test_execution_modality) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"testExecutionModality\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(alloc, "}");
    const body = try body_buf.toOwnedSlice(alloc);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(alloc, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !StartTestExecutionOutput {
    var result: StartTestExecutionOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(StartTestExecutionOutput, body, alloc);
    }
    _ = status;
    _ = headers;

    return result;
}

fn parseErrorResponse(body: []const u8, status: u16, alloc: std.mem.Allocator) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(alloc);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, "");

    if (std.mem.eql(u8, error_code, "ConflictException")) {
        return .{ .arena = arena, .kind = .{ .conflict_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InternalServerException")) {
        return .{ .arena = arena, .kind = .{ .internal_server_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "PreconditionFailedException")) {
        return .{ .arena = arena, .kind = .{ .precondition_failed_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .resource_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ServiceQuotaExceededException")) {
        return .{ .arena = arena, .kind = .{ .service_quota_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ThrottlingException")) {
        return .{ .arena = arena, .kind = .{ .throttling_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ValidationException")) {
        return .{ .arena = arena, .kind = .{ .validation_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
