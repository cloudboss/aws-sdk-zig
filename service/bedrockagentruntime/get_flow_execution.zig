const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const FlowExecutionError = @import("flow_execution_error.zig").FlowExecutionError;
const FlowExecutionStatus = @import("flow_execution_status.zig").FlowExecutionStatus;

pub const GetFlowExecutionInput = struct {
    /// The unique identifier of the flow execution to retrieve.
    execution_identifier: []const u8,

    /// The unique identifier of the flow alias used for the execution.
    flow_alias_identifier: []const u8,

    /// The unique identifier of the flow.
    flow_identifier: []const u8,

    pub const json_field_names = .{
        .execution_identifier = "executionIdentifier",
        .flow_alias_identifier = "flowAliasIdentifier",
        .flow_identifier = "flowIdentifier",
    };
};

pub const GetFlowExecutionOutput = struct {
    /// The timestamp when the flow execution ended. This field is only populated
    /// when the execution has completed, failed, timed out, or been aborted.
    ended_at: ?i64 = null,

    /// A list of errors that occurred during the flow execution. Each error
    /// includes an error code, message, and the node where the error occurred, if
    /// applicable.
    errors: ?[]const FlowExecutionError = null,

    /// The Amazon Resource Name (ARN) that uniquely identifies the flow execution.
    execution_arn: []const u8,

    /// The unique identifier of the flow alias used for the execution.
    flow_alias_identifier: []const u8,

    /// The unique identifier of the flow.
    flow_identifier: []const u8,

    /// The version of the flow used for the execution.
    flow_version: []const u8,

    /// The timestamp when the flow execution started.
    started_at: i64,

    /// The current status of the flow execution.
    ///
    /// Flow executions time out after 24 hours.
    status: FlowExecutionStatus,

    pub const json_field_names = .{
        .ended_at = "endedAt",
        .errors = "errors",
        .execution_arn = "executionArn",
        .flow_alias_identifier = "flowAliasIdentifier",
        .flow_identifier = "flowIdentifier",
        .flow_version = "flowVersion",
        .started_at = "startedAt",
        .status = "status",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetFlowExecutionInput, options: CallOptions) !GetFlowExecutionOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "bedrock", client.config.http_client.clock_skew_offset);

    var response = try client.config.http_client.sendRequestWithOptions(&request, client.options);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = try parseErrorResponse(client.allocator, response.body, response.status);
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: GetFlowExecutionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("bedrock-agent-runtime", "Bedrock Agent Runtime", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/flows/");
    try path_buf.appendSlice(allocator, input.flow_identifier);
    try path_buf.appendSlice(allocator, "/aliases/");
    try path_buf.appendSlice(allocator, input.flow_alias_identifier);
    try path_buf.appendSlice(allocator, "/executions/");
    try path_buf.appendSlice(allocator, input.execution_identifier);
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetFlowExecutionOutput {
    const result: GetFlowExecutionOutput = try aws.json.parseJsonObject(
        GetFlowExecutionOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
