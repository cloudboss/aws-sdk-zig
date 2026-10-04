const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const FlowInput = @import("flow_input.zig").FlowInput;
const ModelPerformanceConfiguration = @import("model_performance_configuration.zig").ModelPerformanceConfiguration;
const FlowResponseStream = @import("flow_response_stream.zig").FlowResponseStream;

pub const InvokeFlowInput = struct {
    /// Specifies whether to return the trace for the flow or not. Traces track
    /// inputs and outputs for nodes in the flow. For more information, see [Track
    /// each step in your prompt flow by viewing its trace in Amazon
    /// Bedrock](https://docs.aws.amazon.com/bedrock/latest/userguide/flows-trace.html).
    enable_trace: ?bool = null,

    /// The unique identifier for the current flow execution. If you don't provide a
    /// value, Amazon Bedrock creates the identifier for you.
    execution_id: ?[]const u8 = null,

    /// The unique identifier of the flow alias.
    flow_alias_identifier: []const u8,

    /// The unique identifier of the flow.
    flow_identifier: []const u8,

    /// A list of objects, each containing information about an input into the flow.
    inputs: []const FlowInput,

    /// Model performance settings for the request.
    model_performance_configuration: ?ModelPerformanceConfiguration = null,

    pub const json_field_names = .{
        .enable_trace = "enableTrace",
        .execution_id = "executionId",
        .flow_alias_identifier = "flowAliasIdentifier",
        .flow_identifier = "flowIdentifier",
        .inputs = "inputs",
        .model_performance_configuration = "modelPerformanceConfiguration",
    };
};

pub const InvokeFlowOutput = struct {
    /// The unique identifier for the current flow execution.
    execution_id: ?[]const u8 = null,

    response_stream: aws.event_stream_reader.EventStreamReader = undefined,

    pub fn deinit(self: *InvokeFlowOutput) void {
        self.response_stream.deinit();
    }

    pub const json_field_names = .{
        .execution_id = "executionId",
        .response_stream = "responseStream",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: InvokeFlowInput, options: CallOptions) !InvokeFlowOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "bedrock", client.config.http_client.clock_skew_offset);

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

    const response_stream = try aws.event_stream_reader.EventStreamReader.init(allocator, stream_resp.body);
    return .{ .response_stream = response_stream };
}

fn serializeRequest(allocator: std.mem.Allocator, input: InvokeFlowInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("bedrock-agent-runtime", "Bedrock Agent Runtime", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/flows/");
    try path_buf.appendSlice(allocator, input.flow_identifier);
    try path_buf.appendSlice(allocator, "/aliases/");
    try path_buf.appendSlice(allocator, input.flow_alias_identifier);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.enable_trace) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"enableTrace\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.execution_id) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"executionId\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"inputs\":");
    try aws.json.writeValue(@TypeOf(input.inputs), input.inputs, allocator, &body_buf);
    has_prev = true;
    if (input.model_performance_configuration) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"modelPerformanceConfiguration\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}
