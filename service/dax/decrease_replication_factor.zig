const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Cluster = @import("cluster.zig").Cluster;

pub const DecreaseReplicationFactorInput = struct {
    /// The Availability Zone(s) from which to remove nodes.
    availability_zones: ?[]const []const u8 = null,

    /// The name of the DAX cluster from which you want to remove
    /// nodes.
    cluster_name: []const u8,

    /// The new number of nodes for the DAX cluster.
    new_replication_factor: ?i32 = null,

    /// The unique identifiers of the nodes to be removed from the cluster.
    node_ids_to_remove: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .availability_zones = "AvailabilityZones",
        .cluster_name = "ClusterName",
        .new_replication_factor = "NewReplicationFactor",
        .node_ids_to_remove = "NodeIdsToRemove",
    };
};

pub const DecreaseReplicationFactorOutput = struct {
    /// A description of the DAX cluster, after you have decreased its
    /// replication factor.
    cluster: ?Cluster = null,

    pub const json_field_names = .{
        .cluster = "Cluster",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DecreaseReplicationFactorInput, options: CallOptions) !DecreaseReplicationFactorOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "dax", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DecreaseReplicationFactorInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("dax", "DAX", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AmazonDAXV3.DecreaseReplicationFactor");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DecreaseReplicationFactorOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DecreaseReplicationFactorOutput, body, allocator);
}
