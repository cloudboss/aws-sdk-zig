const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const HarnessEndpoint = @import("harness_endpoint.zig").HarnessEndpoint;

pub const GetHarnessEndpointInput = struct {
    /// The name of the endpoint to retrieve.
    endpoint_name: []const u8,

    /// The ID of the harness that the endpoint belongs to.
    harness_id: []const u8,

    pub const json_field_names = .{
        .endpoint_name = "endpointName",
        .harness_id = "harnessId",
    };
};

pub const GetHarnessEndpointOutput = struct {
    /// The endpoint resource.
    endpoint: ?HarnessEndpoint = null,

    pub const json_field_names = .{
        .endpoint = "endpoint",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetHarnessEndpointInput, options: CallOptions) !GetHarnessEndpointOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "bedrock-agentcore", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetHarnessEndpointInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("bedrock-agentcore-control", "Bedrock AgentCore Control", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/harnesses/");
    try path_buf.appendSlice(allocator, input.harness_id);
    try path_buf.appendSlice(allocator, "/endpoints/");
    try path_buf.appendSlice(allocator, input.endpoint_name);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetHarnessEndpointOutput {
    const result: GetHarnessEndpointOutput = try aws.json.parseJsonObject(
        GetHarnessEndpointOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
