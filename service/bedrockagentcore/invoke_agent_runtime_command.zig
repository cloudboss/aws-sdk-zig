const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const InvokeAgentRuntimeCommandRequestBody = @import("invoke_agent_runtime_command_request_body.zig").InvokeAgentRuntimeCommandRequestBody;
const InvokeAgentRuntimeCommandStreamOutput = @import("invoke_agent_runtime_command_stream_output.zig").InvokeAgentRuntimeCommandStreamOutput;

pub const InvokeAgentRuntimeCommandInput = struct {
    /// The desired MIME type for the response from the agent runtime command. This
    /// tells the agent runtime what format to use for the response data. Common
    /// values include application/json for JSON data.
    accept: ?[]const u8 = null,

    /// The identifier of the Amazon Web Services account for the agent runtime
    /// resource. This parameter is required when you specify an agent ID instead of
    /// the full ARN for `agentRuntimeArn`.
    account_id: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the agent runtime on which to execute the
    /// command. This identifies the specific agent runtime environment where the
    /// command will run.
    agent_runtime_arn: []const u8,

    /// Additional context information for distributed tracing.
    baggage: ?[]const u8 = null,

    /// The request body containing the command to execute and optional
    /// configuration parameters such as timeout settings.
    body: InvokeAgentRuntimeCommandRequestBody,

    /// The MIME type of the input data in the request payload. This tells the agent
    /// runtime how to interpret the payload data. Common values include
    /// application/json for JSON data.
    content_type: ?[]const u8 = null,

    /// The qualifier to use for the agent runtime. This is an endpoint name that
    /// points to a specific version. If not specified, Amazon Bedrock AgentCore
    /// uses the default endpoint of the agent runtime.
    qualifier: ?[]const u8 = null,

    /// The unique identifier of the runtime session in which to execute the
    /// command. This session ID is used to maintain state and context across
    /// multiple command invocations.
    runtime_session_id: ?[]const u8 = null,

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
        .body = "body",
        .content_type = "contentType",
        .qualifier = "qualifier",
        .runtime_session_id = "runtimeSessionId",
        .trace_id = "traceId",
        .trace_parent = "traceParent",
        .trace_state = "traceState",
    };
};

pub const InvokeAgentRuntimeCommandOutput = struct {
    /// Additional context information for distributed tracing.
    baggage: ?[]const u8 = null,

    /// The MIME type of the response data. This indicates how to interpret the
    /// response data. Common values include application/json for JSON data.
    content_type: []const u8,

    /// The unique identifier of the runtime session in which the command was
    /// executed.
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

    stream: aws.event_stream_reader.EventStreamReader = undefined,

    pub fn deinit(self: *InvokeAgentRuntimeCommandOutput) void {
        self.stream.deinit();
    }

    pub const json_field_names = .{
        .baggage = "baggage",
        .content_type = "contentType",
        .runtime_session_id = "runtimeSessionId",
        .status_code = "statusCode",
        .stream = "stream",
        .trace_id = "traceId",
        .trace_parent = "traceParent",
        .trace_state = "traceState",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: InvokeAgentRuntimeCommandInput, options: CallOptions) !InvokeAgentRuntimeCommandOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "bedrock-agentcore", client.config.http_client.clock_skew_offset);

    var stream_resp = try client.config.http_client.sendStreamingRequestWithOptions(&request, client.options);

    arena.deinit();

    if (!stream_resp.isSuccess()) {
        defer stream_resp.deinit();
        const error_body = stream_resp.body.readAll(client.allocator, 10 * 1024 * 1024) catch return error.RequestFailed;
        defer client.allocator.free(error_body);
        if (options.diagnostic) |d| {
            d.* = try parseErrorResponse(client.allocator, error_body, stream_resp.status);
        }
        return error.ServiceError;
    }

    stream_resp.deinitHeaders();
    errdefer stream_resp.body.deinit();

    const stream = try aws.event_stream_reader.EventStreamReader.init(allocator, stream_resp.body);
    return .{ .stream = stream };
}

fn serializeRequest(allocator: std.mem.Allocator, input: InvokeAgentRuntimeCommandInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("bedrock-agentcore", "Bedrock AgentCore", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/runtimes/");
    try path_buf.appendSlice(allocator, input.agent_runtime_arn);
    try path_buf.appendSlice(allocator, "/commands");
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
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

    const body = try aws.json.jsonStringify(input.body, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
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
    if (input.runtime_session_id) |v| {
        try request.headers.put(allocator, "X-Amzn-Bedrock-AgentCore-Runtime-Session-Id", v);
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
