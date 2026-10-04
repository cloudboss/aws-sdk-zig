const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const GetVpcEndpointServiceNameInput = struct {
    /// The ID of the cluster to retrieve.
    identifier: []const u8,

    pub const json_field_names = .{
        .identifier = "identifier",
    };
};

pub const GetVpcEndpointServiceNameOutput = struct {
    /// The VPC connection endpoint for the cluster.
    cluster_vpc_endpoint: ?[]const u8 = null,

    /// The VPC endpoint service name.
    service_name: []const u8,

    pub const json_field_names = .{
        .cluster_vpc_endpoint = "clusterVpcEndpoint",
        .service_name = "serviceName",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetVpcEndpointServiceNameInput, options: CallOptions) !GetVpcEndpointServiceNameOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "dsql", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetVpcEndpointServiceNameInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("dsql", "DSQL", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/clusters/");
    try path_buf.appendSlice(allocator, input.identifier);
    try path_buf.appendSlice(allocator, "/vpc-endpoint-service-name");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetVpcEndpointServiceNameOutput {
    const result: GetVpcEndpointServiceNameOutput = try aws.json.parseJsonObject(
        GetVpcEndpointServiceNameOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
