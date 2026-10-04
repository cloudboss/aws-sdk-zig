const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const ListAllowedNodeTypeUpdatesInput = struct {
    /// The name of the cluster you want to scale. MemoryDB uses the cluster name to
    /// identify the current node type being used by this cluster, and from that to
    /// create a list of node types
    /// you can scale up to.
    cluster_name: []const u8,

    pub const json_field_names = .{
        .cluster_name = "ClusterName",
    };
};

pub const ListAllowedNodeTypeUpdatesOutput = struct {
    /// A list node types which you can use to scale down your cluster.
    scale_down_node_types: ?[]const []const u8 = null,

    /// A list node types which you can use to scale up your cluster.
    scale_up_node_types: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .scale_down_node_types = "ScaleDownNodeTypes",
        .scale_up_node_types = "ScaleUpNodeTypes",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListAllowedNodeTypeUpdatesInput, options: CallOptions) !ListAllowedNodeTypeUpdatesOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListAllowedNodeTypeUpdatesInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AmazonMemoryDB.ListAllowedNodeTypeUpdates");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListAllowedNodeTypeUpdatesOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListAllowedNodeTypeUpdatesOutput, body, allocator);
}
