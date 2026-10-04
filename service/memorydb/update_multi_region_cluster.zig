const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ShardConfigurationRequest = @import("shard_configuration_request.zig").ShardConfigurationRequest;
const UpdateStrategy = @import("update_strategy.zig").UpdateStrategy;
const MultiRegionCluster = @import("multi_region_cluster.zig").MultiRegionCluster;

pub const UpdateMultiRegionClusterInput = struct {
    /// A new description for the multi-Region cluster.
    description: ?[]const u8 = null,

    /// The new engine version to be used for the multi-Region cluster.
    engine_version: ?[]const u8 = null,

    /// The name of the multi-Region cluster to be updated.
    multi_region_cluster_name: []const u8,

    /// The new multi-Region parameter group to be associated with the cluster.
    multi_region_parameter_group_name: ?[]const u8 = null,

    /// The new node type to be used for the multi-Region cluster.
    node_type: ?[]const u8 = null,

    shard_configuration: ?ShardConfigurationRequest = null,

    /// The strategy to use for the update operation. Supported values are
    /// "coordinated" or "uncoordinated".
    update_strategy: ?UpdateStrategy = null,

    pub const json_field_names = .{
        .description = "Description",
        .engine_version = "EngineVersion",
        .multi_region_cluster_name = "MultiRegionClusterName",
        .multi_region_parameter_group_name = "MultiRegionParameterGroupName",
        .node_type = "NodeType",
        .shard_configuration = "ShardConfiguration",
        .update_strategy = "UpdateStrategy",
    };
};

pub const UpdateMultiRegionClusterOutput = struct {
    /// The status of updating the multi-Region cluster.
    multi_region_cluster: ?MultiRegionCluster = null,

    pub const json_field_names = .{
        .multi_region_cluster = "MultiRegionCluster",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateMultiRegionClusterInput, options: CallOptions) !UpdateMultiRegionClusterOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateMultiRegionClusterInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AmazonMemoryDB.UpdateMultiRegionCluster");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateMultiRegionClusterOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(UpdateMultiRegionClusterOutput, body, allocator);
}
