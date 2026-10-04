const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const FlowStatus = @import("flow_status.zig").FlowStatus;

pub const PrepareFlowInput = struct {
    /// The unique identifier of the flow.
    flow_identifier: []const u8,

    pub const json_field_names = .{
        .flow_identifier = "flowIdentifier",
    };
};

pub const PrepareFlowOutput = struct {
    /// The unique identifier of the flow.
    id: []const u8,

    /// The status of the flow. When you submit this request, the status will be
    /// `NotPrepared`. If preparation succeeds, the status becomes `Prepared`. If it
    /// fails, the status becomes `FAILED`.
    status: FlowStatus,

    pub const json_field_names = .{
        .id = "id",
        .status = "status",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: PrepareFlowInput, options: CallOptions) !PrepareFlowOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: PrepareFlowInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("bedrock-agent", "Bedrock Agent", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/flows/");
    try path_buf.appendSlice(allocator, input.flow_identifier);
    try path_buf.appendSlice(allocator, "/");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !PrepareFlowOutput {
    const result: PrepareFlowOutput = try aws.json.parseJsonObject(
        PrepareFlowOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
