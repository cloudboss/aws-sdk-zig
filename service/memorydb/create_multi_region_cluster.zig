const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Tag = @import("tag.zig").Tag;
const MultiRegionCluster = @import("multi_region_cluster.zig").MultiRegionCluster;

pub const CreateMultiRegionClusterInput = struct {
    /// A description for the multi-Region cluster.
    description: ?[]const u8 = null,

    /// The name of the engine to be used for the multi-Region cluster.
    engine: ?[]const u8 = null,

    /// The version of the engine to be used for the multi-Region cluster.
    engine_version: ?[]const u8 = null,

    /// A suffix to be added to the Multi-Region cluster name. Amazon MemoryDB
    /// automatically applies a prefix to the Multi-Region cluster Name when it is
    /// created. Each Amazon Region has its own prefix. For instance, a Multi-Region
    /// cluster Name created in the US-West-1 region will begin with "virxk", along
    /// with the suffix name you provide. The suffix guarantees uniqueness of the
    /// Multi-Region cluster name across multiple regions.
    multi_region_cluster_name_suffix: []const u8,

    /// The name of the multi-Region parameter group to be associated with the
    /// cluster.
    multi_region_parameter_group_name: ?[]const u8 = null,

    /// The node type to be used for the multi-Region cluster.
    node_type: []const u8,

    /// The number of shards for the multi-Region cluster.
    num_shards: ?i32 = null,

    /// A list of tags to be applied to the multi-Region cluster.
    tags: ?[]const Tag = null,

    /// Whether to enable TLS encryption for the multi-Region cluster.
    tls_enabled: ?bool = null,

    pub const json_field_names = .{
        .description = "Description",
        .engine = "Engine",
        .engine_version = "EngineVersion",
        .multi_region_cluster_name_suffix = "MultiRegionClusterNameSuffix",
        .multi_region_parameter_group_name = "MultiRegionParameterGroupName",
        .node_type = "NodeType",
        .num_shards = "NumShards",
        .tags = "Tags",
        .tls_enabled = "TLSEnabled",
    };
};

pub const CreateMultiRegionClusterOutput = struct {
    /// Details about the newly created multi-Region cluster.
    multi_region_cluster: ?MultiRegionCluster = null,

    pub const json_field_names = .{
        .multi_region_cluster = "MultiRegionCluster",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateMultiRegionClusterInput, options: CallOptions) !CreateMultiRegionClusterOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateMultiRegionClusterInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AmazonMemoryDB.CreateMultiRegionCluster");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateMultiRegionClusterOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateMultiRegionClusterOutput, body, allocator);
}
