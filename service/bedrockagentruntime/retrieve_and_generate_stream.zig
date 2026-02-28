const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const RetrieveAndGenerateInput = @import("retrieve_and_generate_input.zig").RetrieveAndGenerateInput;
const RetrieveAndGenerateConfiguration = @import("retrieve_and_generate_configuration.zig").RetrieveAndGenerateConfiguration;
const RetrieveAndGenerateSessionConfiguration = @import("retrieve_and_generate_session_configuration.zig").RetrieveAndGenerateSessionConfiguration;
const RetrieveAndGenerateStreamResponseOutput = @import("retrieve_and_generate_stream_response_output.zig").RetrieveAndGenerateStreamResponseOutput;

pub const RetrieveAndGenerateStreamInput = struct {
    /// Contains the query to be made to the knowledge base.
    input: RetrieveAndGenerateInput,

    /// Contains configurations for the knowledge base query and retrieval process.
    /// For more information, see [Query
    /// configurations](https://docs.aws.amazon.com/bedrock/latest/userguide/kb-test-config.html).
    retrieve_and_generate_configuration: ?RetrieveAndGenerateConfiguration = null,

    /// Contains details about the session with the knowledge base.
    session_configuration: ?RetrieveAndGenerateSessionConfiguration = null,

    /// The unique identifier of the session. When you first make a
    /// `RetrieveAndGenerate` request, Amazon Bedrock automatically generates this
    /// value. You must reuse this value for all subsequent requests in the same
    /// conversational session. This value allows Amazon Bedrock to maintain context
    /// and knowledge from previous interactions. You can't explicitly set the
    /// `sessionId` yourself.
    session_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .input = "input",
        .retrieve_and_generate_configuration = "retrieveAndGenerateConfiguration",
        .session_configuration = "sessionConfiguration",
        .session_id = "sessionId",
    };
};

pub const RetrieveAndGenerateStreamOutput = struct {
    /// The session ID.
    session_id: []const u8,

    event_reader: aws.event_stream_reader.EventStreamReader = undefined,
    _stream_body: aws.http.StreamingBody = undefined,

    pub fn deinit(self: *RetrieveAndGenerateStreamOutput) void {
        self.event_reader.deinit();
        self._stream_body.deinit();
    }

    pub const json_field_names = .{
        .session_id = "sessionId",
        .stream = "stream",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: RetrieveAndGenerateStreamInput, options: Options) !RetrieveAndGenerateStreamOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "bedrockagentruntime");

    var stream_resp = try client.http_client.sendStreamingRequest(&request);

    arena.deinit();

    if (!stream_resp.isSuccess()) {
        defer stream_resp.deinit();
        const error_body = stream_resp.body.readAll(client.allocator, 10 * 1024 * 1024) catch return error.RequestFailed;
        defer client.allocator.free(error_body);
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(error_body, stream_resp.status, client.allocator) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(stream_resp.status) } } };
        }
        return error.ServiceError;
    }

    const event_reader = try aws.event_stream_reader.EventStreamReader.init(allocator, stream_resp.body.reader());
    return .{ .event_reader = event_reader, ._stream_body = stream_resp.body };
}

fn serializeRequest(alloc: std.mem.Allocator, input: RetrieveAndGenerateStreamInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("bedrockagentruntime", "Bedrock Agent Runtime", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const path = "/retrieveAndGenerateStream";

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(alloc, "{");

    if (has_prev) try body_buf.appendSlice(alloc, ",");
    try body_buf.appendSlice(alloc, "\"input\":");
    try aws.json.writeValue(@TypeOf(input.input), input.input, alloc, &body_buf);
    has_prev = true;
    if (input.retrieve_and_generate_configuration) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"retrieveAndGenerateConfiguration\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.session_configuration) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"sessionConfiguration\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.session_id) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"sessionId\":");
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

    if (std.mem.eql(u8, error_code, "AccessDeniedException")) {
        return .{ .arena = arena, .kind = .{ .access_denied_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "BadGatewayException")) {
        return .{ .arena = arena, .kind = .{ .bad_gateway_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ConflictException")) {
        return .{ .arena = arena, .kind = .{ .conflict_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DependencyFailedException")) {
        return .{ .arena = arena, .kind = .{ .dependency_failed_exception = .{
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
    if (std.mem.eql(u8, error_code, "ModelNotReadyException")) {
        return .{ .arena = arena, .kind = .{ .model_not_ready_exception = .{
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
