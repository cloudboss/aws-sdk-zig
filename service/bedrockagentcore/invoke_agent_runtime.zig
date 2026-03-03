const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;

pub const InvokeAgentRuntimeInput = struct {
    /// The desired MIME type for the response from the agent runtime. This tells
    /// the agent runtime what format to use for the response data. Common values
    /// include application/json for JSON data.
    accept: ?[]const u8 = null,

    /// The identifier of the Amazon Web Services account for the agent runtime
    /// resource.
    account_id: ?[]const u8 = null,

    /// The Amazon Web Services Resource Name (ARN) of the agent runtime to invoke.
    /// The ARN uniquely identifies the agent runtime resource in Amazon Bedrock
    /// AgentCore.
    agent_runtime_arn: []const u8,

    /// Additional context information for distributed tracing.
    baggage: ?[]const u8 = null,

    /// The MIME type of the input data in the payload. This tells the agent runtime
    /// how to interpret the payload data. Common values include application/json
    /// for JSON data.
    content_type: ?[]const u8 = null,

    /// The version of the MCP protocol being used.
    mcp_protocol_version: ?[]const u8 = null,

    /// The identifier of the MCP session.
    mcp_session_id: ?[]const u8 = null,

    /// The input data to send to the agent runtime. The format of this data depends
    /// on the specific agent configuration and must match the specified content
    /// type. For most agents, this is a JSON object containing the user's request.
    payload: []const u8,

    /// The qualifier to use for the agent runtime. This can be a version number or
    /// an endpoint name that points to a specific version. If not specified, Amazon
    /// Bedrock AgentCore uses the default version of the agent runtime.
    qualifier: ?[]const u8 = null,

    /// The identifier of the runtime session.
    runtime_session_id: ?[]const u8 = null,

    /// The identifier of the runtime user.
    runtime_user_id: ?[]const u8 = null,

    /// The trace identifier for request tracking.
    trace_id: ?[]const u8 = null,

    /// The parent trace information for distributed tracing.
    trace_parent: ?[]const u8 = null,

    /// The trace state information for distributed tracing.
    trace_state: ?[]const u8 = null,

    pub const json_field_names = .{
        .accept = "accept",
        .account_id = "accountId",
        .agent_runtime_arn = "agentRuntimeArn",
        .baggage = "baggage",
        .content_type = "contentType",
        .mcp_protocol_version = "mcpProtocolVersion",
        .mcp_session_id = "mcpSessionId",
        .payload = "payload",
        .qualifier = "qualifier",
        .runtime_session_id = "runtimeSessionId",
        .runtime_user_id = "runtimeUserId",
        .trace_id = "traceId",
        .trace_parent = "traceParent",
        .trace_state = "traceState",
    };
};

pub const InvokeAgentRuntimeOutput = struct {
    /// Additional context information for distributed tracing.
    baggage: ?[]const u8 = null,

    /// The MIME type of the response data. This indicates how to interpret the
    /// response data. Common values include application/json for JSON data.
    content_type: []const u8,

    /// The version of the MCP protocol being used.
    mcp_protocol_version: ?[]const u8 = null,

    /// The identifier of the MCP session.
    mcp_session_id: ?[]const u8 = null,

    /// The response data from the agent runtime. The format of this data depends on
    /// the specific agent configuration and the requested accept type. For most
    /// agents, this is a JSON object containing the agent's response to the user's
    /// request.
    response: ?aws.http.StreamingBody = null,

    /// The identifier of the runtime session.
    runtime_session_id: ?[]const u8 = null,

    /// The HTTP status code of the response. A status code of 200 indicates a
    /// successful operation. Other status codes indicate various error conditions.
    status_code: ?i32 = null,

    /// The trace identifier for request tracking.
    trace_id: ?[]const u8 = null,

    /// The parent trace information for distributed tracing.
    trace_parent: ?[]const u8 = null,

    /// The trace state information for distributed tracing.
    trace_state: ?[]const u8 = null,

    pub fn deinit(self: *InvokeAgentRuntimeOutput) void {
        if (self.response) |*b| b.deinit();
    }

    pub const json_field_names = .{
        .baggage = "baggage",
        .content_type = "contentType",
        .mcp_protocol_version = "mcpProtocolVersion",
        .mcp_session_id = "mcpSessionId",
        .response = "response",
        .runtime_session_id = "runtimeSessionId",
        .status_code = "statusCode",
        .trace_id = "traceId",
        .trace_parent = "traceParent",
        .trace_state = "traceState",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: InvokeAgentRuntimeInput, options: CallOptions) !InvokeAgentRuntimeOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "bedrockagentcore");

    var stream_resp = try client.http_client.sendStreamingRequest(&request);

    arena.deinit();

    if (!stream_resp.isSuccess()) {
        defer stream_resp.deinit();
        const error_body = stream_resp.body.readAll(client.allocator, 10 * 1024 * 1024) catch return error.RequestFailed;
        defer client.allocator.free(error_body);
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(client.allocator, error_body, stream_resp.status) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(stream_resp.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeStreamingResponse(allocator, &stream_resp);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: InvokeAgentRuntimeInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("bedrockagentcore", "Bedrock AgentCore", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(allocator, "/runtimes/");
    try path_buf.appendSlice(allocator, input.agent_runtime_arn);
    try path_buf.appendSlice(allocator, "/invocations");
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .{};
    var query_has_prev = false;
    if (input.account_id) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "accountId=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.qualifier) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "qualifier=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    const query = try query_buf.toOwnedSlice(allocator);

    const body = input.payload;

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");
    if (input.accept) |v| {
        try request.headers.put(allocator, "Accept", v);
    }
    if (input.baggage) |v| {
        try request.headers.put(allocator, "baggage", v);
    }
    if (input.content_type) |v| {
        try request.headers.put(allocator, "Content-Type", v);
    }
    if (input.mcp_protocol_version) |v| {
        try request.headers.put(allocator, "Mcp-Protocol-Version", v);
    }
    if (input.mcp_session_id) |v| {
        try request.headers.put(allocator, "Mcp-Session-Id", v);
    }
    if (input.runtime_session_id) |v| {
        try request.headers.put(allocator, "X-Amzn-Bedrock-AgentCore-Runtime-Session-Id", v);
    }
    if (input.runtime_user_id) |v| {
        try request.headers.put(allocator, "X-Amzn-Bedrock-AgentCore-Runtime-User-Id", v);
    }
    if (input.trace_id) |v| {
        try request.headers.put(allocator, "X-Amzn-Trace-Id", v);
    }
    if (input.trace_parent) |v| {
        try request.headers.put(allocator, "traceparent", v);
    }
    if (input.trace_state) |v| {
        try request.headers.put(allocator, "tracestate", v);
    }

    return request;
}

fn deserializeStreamingResponse(allocator: std.mem.Allocator, stream_resp: *aws.http.StreamingResponse) !InvokeAgentRuntimeOutput {
    var result: InvokeAgentRuntimeOutput = .{};
    result.response = stream_resp.body;
    result.status_code = @intCast(stream_resp.status);
    if (stream_resp.headers.get("baggage")) |value| {
        result.baggage = try allocator.dupe(u8, value);
    }
    if (stream_resp.headers.get("content-type")) |value| {
        result.content_type = try allocator.dupe(u8, value);
    }
    if (stream_resp.headers.get("mcp-protocol-version")) |value| {
        result.mcp_protocol_version = try allocator.dupe(u8, value);
    }
    if (stream_resp.headers.get("mcp-session-id")) |value| {
        result.mcp_session_id = try allocator.dupe(u8, value);
    }
    if (stream_resp.headers.get("x-amzn-bedrock-agentcore-runtime-session-id")) |value| {
        result.runtime_session_id = try allocator.dupe(u8, value);
    }
    if (stream_resp.headers.get("x-amzn-trace-id")) |value| {
        result.trace_id = try allocator.dupe(u8, value);
    }
    if (stream_resp.headers.get("traceparent")) |value| {
        result.trace_parent = try allocator.dupe(u8, value);
    }
    if (stream_resp.headers.get("tracestate")) |value| {
        result.trace_state = try allocator.dupe(u8, value);
    }
    stream_resp.deinitHeaders();

    return result;
}

fn parseErrorResponse(allocator: std.mem.Allocator, body: []const u8, status: u16) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
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

    if (std.mem.eql(u8, error_code, "AccessDeniedException")) {
        return .{ .arena = arena, .kind = .{ .access_denied_exception = .{
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
    if (std.mem.eql(u8, error_code, "DuplicateIdException")) {
        return .{ .arena = arena, .kind = .{ .duplicate_id_exception = .{
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
    if (std.mem.eql(u8, error_code, "InvalidInputException")) {
        return .{ .arena = arena, .kind = .{ .invalid_input_exception = .{
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
    if (std.mem.eql(u8, error_code, "RetryableConflictException")) {
        return .{ .arena = arena, .kind = .{ .retryable_conflict_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "RuntimeClientError")) {
        return .{ .arena = arena, .kind = .{ .runtime_client_error = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ServiceException")) {
        return .{ .arena = arena, .kind = .{ .service_exception = .{
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
    if (std.mem.eql(u8, error_code, "ThrottledException")) {
        return .{ .arena = arena, .kind = .{ .throttled_exception = .{
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
    if (std.mem.eql(u8, error_code, "UnauthorizedException")) {
        return .{ .arena = arena, .kind = .{ .unauthorized_exception = .{
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
