const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const PrivateGraphEndpointStatus = @import("private_graph_endpoint_status.zig").PrivateGraphEndpointStatus;

pub const DeletePrivateGraphEndpointInput = struct {
    /// The unique identifier of the Neptune Analytics graph.
    graph_identifier: []const u8,

    /// The ID of the VPC where the private endpoint is located.
    vpc_id: []const u8,

    pub const json_field_names = .{
        .graph_identifier = "graphIdentifier",
        .vpc_id = "vpcId",
    };
};

pub const DeletePrivateGraphEndpointOutput = struct {
    /// The status of the delete operation.
    status: PrivateGraphEndpointStatus,

    /// The subnet IDs involved.
    subnet_ids: ?[]const []const u8 = null,

    /// The ID of the VPC endpoint that was deleted.
    vpc_endpoint_id: ?[]const u8 = null,

    /// The ID of the VPC where the private endpoint was deleted.
    vpc_id: []const u8,

    pub const json_field_names = .{
        .status = "status",
        .subnet_ids = "subnetIds",
        .vpc_endpoint_id = "vpcEndpointId",
        .vpc_id = "vpcId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DeletePrivateGraphEndpointInput, options: CallOptions) !DeletePrivateGraphEndpointOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "neptune-graph", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DeletePrivateGraphEndpointInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("neptune-graph", "Neptune Graph", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/graphs/");
    try path_buf.appendSlice(allocator, input.graph_identifier);
    try path_buf.appendSlice(allocator, "/endpoints/");
    try path_buf.appendSlice(allocator, input.vpc_id);
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .DELETE;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DeletePrivateGraphEndpointOutput {
    const result: DeletePrivateGraphEndpointOutput = try aws.json.parseJsonObject(
        DeletePrivateGraphEndpointOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
