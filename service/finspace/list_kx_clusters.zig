const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const KxClusterType = @import("kx_cluster_type.zig").KxClusterType;
const KxCluster = @import("kx_cluster.zig").KxCluster;

pub const ListKxClustersInput = struct {
    /// Specifies the type of KDB database that is being created. The following
    /// types are available:
    ///
    /// * HDB – A Historical Database. The data is only accessible with read-only
    ///   permissions from one of the FinSpace managed kdb databases mounted to the
    ///   cluster.
    ///
    /// * RDB – A Realtime Database. This type of database captures all the data
    ///   from a ticker plant and stores it in memory until the end of day, after
    ///   which it writes all of its data to a disk and reloads the HDB. This
    ///   cluster type requires local storage for temporary storage of data during
    ///   the savedown process. If you specify this field in your request, you must
    ///   provide the `savedownStorageConfiguration` parameter.
    ///
    /// * GATEWAY – A gateway cluster allows you to access data across processes in
    ///   kdb systems. It allows you to create your own routing logic using the
    ///   initialization scripts and custom code. This type of cluster does not
    ///   require a writable local storage.
    ///
    /// * GP – A general purpose cluster allows you to quickly iterate on code
    ///   during development by granting greater access to system commands and
    ///   enabling a fast reload of custom code. This cluster type can optionally
    ///   mount databases including cache and savedown storage. For this cluster
    ///   type, the node count is fixed at 1. It does not support autoscaling and
    ///   supports only `SINGLE` AZ mode.
    ///
    /// * Tickerplant – A tickerplant cluster allows you to subscribe to feed
    ///   handlers based on IAM permissions. It can publish to RDBs, other
    ///   Tickerplants, and real-time subscribers (RTS). Tickerplants can persist
    ///   messages to log, which is readable by any RDB environment. It supports
    ///   only single-node that is only one kdb process.
    cluster_type: ?KxClusterType = null,

    /// A unique identifier for the kdb environment.
    environment_id: []const u8,

    /// The maximum number of results to return in this request.
    max_results: ?i32 = null,

    /// A token that indicates where a results page should begin.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .cluster_type = "clusterType",
        .environment_id = "environmentId",
        .max_results = "maxResults",
        .next_token = "nextToken",
    };
};

pub const ListKxClustersOutput = struct {
    /// Lists the cluster details.
    kx_cluster_summaries: ?[]const KxCluster = null,

    /// A token that indicates where a results page should begin.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .kx_cluster_summaries = "kxClusterSummaries",
        .next_token = "nextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListKxClustersInput, options: CallOptions) !ListKxClustersOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "finspace", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListKxClustersInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("finspace", "finspace", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/kx/environments/");
    try path_buf.appendSlice(allocator, input.environment_id);
    try path_buf.appendSlice(allocator, "/clusters");
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.cluster_type) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "clusterType=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v.wireName());
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListKxClustersOutput {
    const result: ListKxClustersOutput = try aws.json.parseJsonObject(
        ListKxClustersOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
