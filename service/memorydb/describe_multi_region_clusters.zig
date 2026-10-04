const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const MultiRegionCluster = @import("multi_region_cluster.zig").MultiRegionCluster;

pub const DescribeMultiRegionClustersInput = struct {
    /// The maximum number of results to return.
    max_results: ?i32 = null,

    /// The name of a specific multi-Region cluster to describe.
    multi_region_cluster_name: ?[]const u8 = null,

    /// A token to specify where to start paginating.
    next_token: ?[]const u8 = null,

    /// Details about the multi-Region cluster.
    show_cluster_details: ?bool = null,

    pub const json_field_names = .{
        .max_results = "MaxResults",
        .multi_region_cluster_name = "MultiRegionClusterName",
        .next_token = "NextToken",
        .show_cluster_details = "ShowClusterDetails",
    };
};

pub const DescribeMultiRegionClustersOutput = struct {
    /// A list of multi-Region clusters.
    multi_region_clusters: ?[]const MultiRegionCluster = null,

    /// A token to use to retrieve the next page of results.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .multi_region_clusters = "MultiRegionClusters",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeMultiRegionClustersInput, options: CallOptions) !DescribeMultiRegionClustersOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeMultiRegionClustersInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AmazonMemoryDB.DescribeMultiRegionClusters");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeMultiRegionClustersOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeMultiRegionClustersOutput, body, allocator);
}
