const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Cluster = @import("cluster.zig").Cluster;

pub const DescribeClustersInput = struct {
    /// One or more filters to limit the items returned in the response.
    ///
    /// Use the `clusterIds` filter to return only the specified clusters. Specify
    /// clusters by their cluster identifier (ID).
    ///
    /// Use the `vpcIds` filter to return only the clusters in the specified virtual
    /// private clouds (VPCs). Specify VPCs by their VPC identifier (ID).
    ///
    /// Use the `states` filter to return only clusters that match the specified
    /// state.
    filters: ?[]const aws.map.MapEntry([]const []const u8) = null,

    /// The maximum number of clusters to return in the response. When there are
    /// more clusters
    /// than the number you specify, the response contains a `NextToken` value.
    max_results: ?i32 = null,

    /// The `NextToken` value that you received in the previous response. Use this
    /// value to get more clusters.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .filters = "Filters",
        .max_results = "MaxResults",
        .next_token = "NextToken",
    };
};

pub const DescribeClustersOutput = struct {
    /// A list of clusters.
    clusters: ?[]const Cluster = null,

    /// An opaque string that indicates that the response contains only a subset of
    /// clusters.
    /// Use this value in a subsequent `DescribeClusters` request to get more
    /// clusters.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .clusters = "Clusters",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeClustersInput, options: CallOptions) !DescribeClustersOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "cloudhsm", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeClustersInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("cloudhsmv2", "CloudHSM V2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "BaldrApiService.DescribeClusters");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeClustersOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeClustersOutput, body, allocator);
}
