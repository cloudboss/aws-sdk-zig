const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const FlowExecutionStatus = @import("flow_execution_status.zig").FlowExecutionStatus;

pub const StopFlowExecutionInput = struct {
    /// The unique identifier of the flow execution to stop.
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

pub const StopFlowExecutionOutput = struct {
    /// The Amazon Resource Name (ARN) that uniquely identifies the flow execution
    /// that was stopped.
    execution_arn: ?[]const u8 = null,

    /// The updated status of the flow execution after the stop request. This will
    /// typically be ABORTED if the execution was successfully stopped.
    status: FlowExecutionStatus,

    pub const json_field_names = .{
        .execution_arn = "executionArn",
        .status = "status",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: StopFlowExecutionInput, options: CallOptions) !StopFlowExecutionOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: StopFlowExecutionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("bedrock-agent-runtime", "Bedrock Agent Runtime", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/flows/");
    try path_buf.appendSlice(allocator, input.flow_identifier);
    try path_buf.appendSlice(allocator, "/aliases/");
    try path_buf.appendSlice(allocator, input.flow_alias_identifier);
    try path_buf.appendSlice(allocator, "/executions/");
    try path_buf.appendSlice(allocator, input.execution_identifier);
    try path_buf.appendSlice(allocator, "/stop");
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !StopFlowExecutionOutput {
    var result: StopFlowExecutionOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(StopFlowExecutionOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
