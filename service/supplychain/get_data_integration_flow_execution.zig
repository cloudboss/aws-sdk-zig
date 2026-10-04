const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DataIntegrationFlowExecution = @import("data_integration_flow_execution.zig").DataIntegrationFlowExecution;

pub const GetDataIntegrationFlowExecutionInput = struct {
    /// The flow execution identifier.
    execution_id: []const u8,

    /// The flow name.
    flow_name: []const u8,

    /// The AWS Supply Chain instance identifier.
    instance_id: []const u8,

    pub const json_field_names = .{
        .execution_id = "executionId",
        .flow_name = "flowName",
        .instance_id = "instanceId",
    };
};

pub const GetDataIntegrationFlowExecutionOutput = struct {
    /// The flow execution details.
    flow_execution: ?DataIntegrationFlowExecution = null,

    pub const json_field_names = .{
        .flow_execution = "flowExecution",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetDataIntegrationFlowExecutionInput, options: CallOptions) !GetDataIntegrationFlowExecutionOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "scn", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetDataIntegrationFlowExecutionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("scn", "SupplyChain", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/api-data/data-integration/instance/");
    try path_buf.appendSlice(allocator, input.instance_id);
    try path_buf.appendSlice(allocator, "/data-integration-flows/");
    try path_buf.appendSlice(allocator, input.flow_name);
    try path_buf.appendSlice(allocator, "/executions/");
    try path_buf.appendSlice(allocator, input.execution_id);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetDataIntegrationFlowExecutionOutput {
    var result: GetDataIntegrationFlowExecutionOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetDataIntegrationFlowExecutionOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
