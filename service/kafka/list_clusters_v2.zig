const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Cluster = @import("cluster.zig").Cluster;

pub const ListClustersV2Input = struct {
    /// Specify a prefix of the names of the clusters that you want to list. The
    /// service lists all the clusters whose names start with this prefix.
    cluster_name_filter: ?[]const u8 = null,

    /// Specify either PROVISIONED or SERVERLESS.
    cluster_type_filter: ?[]const u8 = null,

    /// The maximum number of results to return in the response. If there are more
    /// results, the response includes a NextToken parameter.
    max_results: ?i32 = null,

    /// The paginated results marker. When the result of the operation is truncated,
    /// the call returns NextToken in the response.
    /// To get the next batch, provide this token in your next request.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .cluster_name_filter = "ClusterNameFilter",
        .cluster_type_filter = "ClusterTypeFilter",
        .max_results = "MaxResults",
        .next_token = "NextToken",
    };
};

pub const ListClustersV2Output = struct {
    /// Information on each of the MSK clusters in the response.
    cluster_info_list: ?[]const Cluster = null,

    /// The paginated results marker. When the result of a ListClusters operation is
    /// truncated, the call returns NextToken in the response.
    /// To get another batch of clusters, provide this token in your next request.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .cluster_info_list = "ClusterInfoList",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListClustersV2Input, options: CallOptions) !ListClustersV2Output {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "kafka", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListClustersV2Input, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("kafka", "Kafka", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/api/v2/clusters";

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.cluster_name_filter) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "clusterNameFilter=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.cluster_type_filter) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "clusterTypeFilter=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.max_results) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "maxResults=");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try query_buf.appendSlice(allocator, num_str);
        }
        query_has_prev = true;
    }
    if (input.next_token) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "nextToken=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    const query = try query_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListClustersV2Output {
    const result: ListClustersV2Output = try aws.json.parseJsonObject(
        ListClustersV2Output,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
