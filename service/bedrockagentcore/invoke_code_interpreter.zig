const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ToolArguments = @import("tool_arguments.zig").ToolArguments;
const ToolName = @import("tool_name.zig").ToolName;
const CodeInterpreterStreamOutput = @import("code_interpreter_stream_output.zig").CodeInterpreterStreamOutput;

pub const InvokeCodeInterpreterInput = struct {
    /// The arguments for the code interpreter. This includes the code to execute
    /// and any additional parameters such as the programming language, whether to
    /// clear the execution context, and other execution options. The structure of
    /// this parameter depends on the specific code interpreter being used.
    arguments: ?ToolArguments = null,

    /// The unique identifier of the code interpreter associated with the session.
    /// This must match the identifier used when creating the session with
    /// `StartCodeInterpreterSession`.
    code_interpreter_identifier: []const u8,

    /// The name of the code interpreter to invoke.
    name: ToolName,

    /// The unique identifier of the code interpreter session to use. This must be
    /// an active session created with `StartCodeInterpreterSession`. If the session
    /// has expired or been stopped, the request will fail.
    session_id: ?[]const u8 = null,

    /// The trace identifier for request tracking.
    trace_id: ?[]const u8 = null,

    /// The parent trace information for distributed tracing.
    trace_parent: ?[]const u8 = null,

    pub const json_field_names = .{
        .arguments = "arguments",
        .code_interpreter_identifier = "codeInterpreterIdentifier",
        .name = "name",
        .session_id = "sessionId",
        .trace_id = "traceId",
        .trace_parent = "traceParent",
    };
};

pub const InvokeCodeInterpreterOutput = struct {
    /// The identifier of the code interpreter session.
    session_id: ?[]const u8 = null,

    stream: aws.event_stream_reader.EventStreamReader = undefined,

    pub fn deinit(self: *InvokeCodeInterpreterOutput) void {
        self.stream.deinit();
    }

    pub const json_field_names = .{
        .session_id = "sessionId",
        .stream = "stream",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: InvokeCodeInterpreterInput, options: CallOptions) !InvokeCodeInterpreterOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "bedrock-agentcore", client.config.http_client.clock_skew_offset);

    var stream_resp = try client.config.http_client.sendStreamingRequestWithOptions(&request, client.options);

    if (!stream_resp.isSuccess()) {
        defer stream_resp.deinit();
        const error_body = stream_resp.body.readAll(client.allocator, 10 * 1024 * 1024) catch return error.RequestFailed;
        defer client.allocator.free(error_body);
        if (options.diagnostic) |d| {
            d.* = try parseErrorResponse(client.allocator, error_body, stream_resp.status);
        }
        return error.ServiceError;
    }

    errdefer stream_resp.deinit();
    const result = try deserializeStreamingResponse(allocator, &stream_resp);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: InvokeCodeInterpreterInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("bedrock-agentcore", "Bedrock AgentCore", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/code-interpreters/");
    try path_buf.appendSlice(allocator, input.code_interpreter_identifier);
    try path_buf.appendSlice(allocator, "/tools/invoke");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.arguments) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"arguments\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"name\":");
    try aws.json.writeValue(@TypeOf(input.name), input.name, allocator, &body_buf);
    has_prev = true;

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");
    if (input.session_id) |v| {
        try request.headers.put(allocator, "x-amzn-code-interpreter-session-id", v);
    }
    if (input.trace_id) |v| {
        try request.headers.put(allocator, "X-Amzn-Trace-Id", v);
    }
    if (input.trace_parent) |v| {
        try request.headers.put(allocator, "traceparent", v);
    }

    return request;
}

fn deserializeStreamingResponse(allocator: std.mem.Allocator, stream_resp: *aws.http.StreamingResponse) !InvokeCodeInterpreterOutput {
    var result: InvokeCodeInterpreterOutput = .{};
    errdefer {
        if (result.session_id) |value| allocator.free(value);
    }
    if (stream_resp.headers.get("x-amzn-code-interpreter-session-id")) |value| {
        result.session_id = try allocator.dupe(u8, value);
    }
    result.stream = try aws.event_stream_reader.EventStreamReader.init(
        allocator,
        stream_resp.body,
    );
    stream_resp.deinitHeaders();

    return result;
}
