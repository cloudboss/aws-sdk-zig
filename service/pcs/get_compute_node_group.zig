const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ComputeNodeGroup = @import("compute_node_group.zig").ComputeNodeGroup;

pub const GetComputeNodeGroupInput = struct {
    /// The name or ID of the cluster.
    cluster_identifier: []const u8,

    /// The name or ID of the compute node group.
    compute_node_group_identifier: []const u8,

    pub const json_field_names = .{
        .cluster_identifier = "clusterIdentifier",
        .compute_node_group_identifier = "computeNodeGroupIdentifier",
    };
};

pub const GetComputeNodeGroupOutput = struct {
    compute_node_group: ?ComputeNodeGroup = null,

    pub const json_field_names = .{
        .compute_node_group = "computeNodeGroup",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetComputeNodeGroupInput, options: CallOptions) !GetComputeNodeGroupOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "pcs", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetComputeNodeGroupInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("pcs", "PCS", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "AWSParallelComputingService.GetComputeNodeGroup");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetComputeNodeGroupOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GetComputeNodeGroupOutput, body, allocator);
}
