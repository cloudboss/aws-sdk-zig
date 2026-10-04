const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const ListAllowedMultiRegionClusterUpdatesInput = struct {
    /// The name of the multi-Region cluster.
    multi_region_cluster_name: []const u8,

    pub const json_field_names = .{
        .multi_region_cluster_name = "MultiRegionClusterName",
    };
};

pub const ListAllowedMultiRegionClusterUpdatesOutput = struct {
    /// The node types that the cluster can be scaled down to.
    scale_down_node_types: ?[]const []const u8 = null,

    /// The node types that the cluster can be scaled up to.
    scale_up_node_types: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .scale_down_node_types = "ScaleDownNodeTypes",
        .scale_up_node_types = "ScaleUpNodeTypes",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListAllowedMultiRegionClusterUpdatesInput, options: CallOptions) !ListAllowedMultiRegionClusterUpdatesOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "memorydb", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListAllowedMultiRegionClusterUpdatesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("memory-db", "MemoryDB", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AmazonMemoryDB.ListAllowedMultiRegionClusterUpdates");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListAllowedMultiRegionClusterUpdatesOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListAllowedMultiRegionClusterUpdatesOutput, body, allocator);
}
