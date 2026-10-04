const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ClusterState = @import("cluster_state.zig").ClusterState;
const ClusterSummary = @import("cluster_summary.zig").ClusterSummary;

pub const ListClustersInput = struct {
    /// The cluster state filters to apply when listing clusters. Clusters that
    /// change state
    /// while this action runs may be not be returned as expected in the list of
    /// clusters.
    cluster_states: ?[]const ClusterState = null,

    /// The creation date and time beginning value filter for listing clusters.
    created_after: ?i64 = null,

    /// The creation date and time end value filter for listing clusters.
    created_before: ?i64 = null,

    /// The pagination token that indicates the next set of results to retrieve.
    marker: ?[]const u8 = null,

    pub const json_field_names = .{
        .cluster_states = "ClusterStates",
        .created_after = "CreatedAfter",
        .created_before = "CreatedBefore",
        .marker = "Marker",
    };
};

pub const ListClustersOutput = struct {
    /// The list of clusters for the account based on the given filters.
    clusters: ?[]const ClusterSummary = null,

    /// The pagination token that indicates the next set of results to retrieve.
    marker: ?[]const u8 = null,

    pub const json_field_names = .{
        .clusters = "Clusters",
        .marker = "Marker",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListClustersInput, options: CallOptions) !ListClustersOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "elasticmapreduce", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListClustersInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("elasticmapreduce", "EMR", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "ElasticMapReduce.ListClusters");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListClustersOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListClustersOutput, body, allocator);
}
