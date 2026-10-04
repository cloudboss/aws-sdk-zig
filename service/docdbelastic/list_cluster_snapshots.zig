const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ClusterSnapshotInList = @import("cluster_snapshot_in_list.zig").ClusterSnapshotInList;

pub const ListClusterSnapshotsInput = struct {
    /// The ARN identifier of the elastic cluster.
    cluster_arn: ?[]const u8 = null,

    /// The maximum number of elastic cluster snapshot results to receive in the
    /// response.
    max_results: ?i32 = null,

    /// A pagination token provided by a previous request.
    /// If this parameter is specified, the response includes only records beyond
    /// this token, up to the value specified by `max-results`.
    ///
    /// If there is no more data in the responce, the `nextToken` will not be
    /// returned.
    next_token: ?[]const u8 = null,

    /// The type of cluster snapshots to be returned. You can specify one of the
    /// following values:
    ///
    /// * `automated` - Return all cluster snapshots that Amazon DocumentDB has
    ///   automatically created for your Amazon Web Services account.
    ///
    /// * `manual` - Return all cluster snapshots that you have manually created for
    ///   your Amazon Web Services account.
    snapshot_type: ?[]const u8 = null,

    pub const json_field_names = .{
        .cluster_arn = "clusterArn",
        .max_results = "maxResults",
        .next_token = "nextToken",
        .snapshot_type = "snapshotType",
    };
};

pub const ListClusterSnapshotsOutput = struct {
    /// A pagination token provided by a previous request.
    /// If this parameter is specified, the response includes only records beyond
    /// this token, up to the value specified by `max-results`.
    ///
    /// If there is no more data in the responce, the `nextToken` will not be
    /// returned.
    next_token: ?[]const u8 = null,

    /// A list of snapshots for a specified elastic cluster.
    snapshots: ?[]const ClusterSnapshotInList = null,

    pub const json_field_names = .{
        .next_token = "nextToken",
        .snapshots = "snapshots",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListClusterSnapshotsInput, options: CallOptions) !ListClusterSnapshotsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "docdb-elastic", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListClusterSnapshotsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("docdb-elastic", "DocDB Elastic", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/cluster-snapshots";

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.cluster_arn) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "clusterArn=");
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
    if (input.snapshot_type) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "snapshotType=");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListClusterSnapshotsOutput {
    const result: ListClusterSnapshotsOutput = try aws.json.parseJsonObject(
        ListClusterSnapshotsOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
