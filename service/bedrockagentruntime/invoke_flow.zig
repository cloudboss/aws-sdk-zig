const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
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

    event_reader: aws.event_stream_reader.EventStreamReader = undefined,
    _stream_body: aws.http.StreamingBody = undefined,

    pub fn deinit(self: *InvokeFlowOutput) void {
        self.event_reader.deinit();
        self._stream_body.deinit();
    }

    pub const json_field_names = .{
        .execution_id = "executionId",
        .response_stream = "responseStream",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: InvokeFlowInput, options: Options) !InvokeFlowOutput {
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

    stream_resp.deinitHeaders();
    errdefer stream_resp.body.deinit();

    const event_reader = try aws.event_stream_reader.EventStreamReader.init(allocator, stream_resp.body.reader());
    return .{ .event_reader = event_reader, ._stream_body = stream_resp.body };
}

fn serializeRequest(alloc: std.mem.Allocator, input: InvokeFlowInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("bedrockagentruntime", "Bedrock Agent Runtime", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(alloc, "/flows/");
    try path_buf.appendSlice(alloc, input.flow_identifier);
    try path_buf.appendSlice(alloc, "/aliases/");
    try path_buf.appendSlice(alloc, input.flow_alias_identifier);
    const path = try path_buf.toOwnedSlice(alloc);

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(alloc, "{");

    if (input.enable_trace) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"enableTrace\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.execution_id) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"executionId\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(alloc, ",");
    try body_buf.appendSlice(alloc, "\"inputs\":");
    try aws.json.writeValue(@TypeOf(input.inputs), input.inputs, alloc, &body_buf);
    has_prev = true;
    if (input.model_performance_configuration) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"modelPerformanceConfiguration\":");
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
