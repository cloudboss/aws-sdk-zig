const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ServiceUpdateRequest = @import("service_update_request.zig").ServiceUpdateRequest;
const Cluster = @import("cluster.zig").Cluster;
const UnprocessedCluster = @import("unprocessed_cluster.zig").UnprocessedCluster;

pub const BatchUpdateClusterInput = struct {
    /// The cluster names to apply the updates.
    cluster_names: []const []const u8,

    /// The unique ID of the service update
    service_update: ?ServiceUpdateRequest = null,

    pub const json_field_names = .{
        .cluster_names = "ClusterNames",
        .service_update = "ServiceUpdate",
    };
};

pub const BatchUpdateClusterOutput = struct {
    /// The list of clusters that have been updated.
    processed_clusters: ?[]const Cluster = null,

    /// The list of clusters where updates have not been applied.
    unprocessed_clusters: ?[]const UnprocessedCluster = null,

    pub const json_field_names = .{
        .processed_clusters = "ProcessedClusters",
        .unprocessed_clusters = "UnprocessedClusters",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: BatchUpdateClusterInput, options: CallOptions) !BatchUpdateClusterOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: BatchUpdateClusterInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AmazonMemoryDB.BatchUpdateCluster");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !BatchUpdateClusterOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(BatchUpdateClusterOutput, body, allocator);
}
