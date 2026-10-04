const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ClusterInList = @import("cluster_in_list.zig").ClusterInList;

pub const ListClustersInput = struct {
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

    pub const json_field_names = .{
        .max_results = "maxResults",
        .next_token = "nextToken",
    };
};

pub const ListClustersOutput = struct {
    /// A list of Amazon DocumentDB elastic clusters.
    clusters: ?[]const ClusterInList = null,

    /// A pagination token provided by a previous request.
    /// If this parameter is specified, the response includes only records beyond
    /// this token, up to the value specified by `max-results`.
    ///
    /// If there is no more data in the responce, the `nextToken` will not be
    /// returned.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .clusters = "clusters",
        .next_token = "nextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListClustersInput, options: CallOptions) !ListClustersOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListClustersInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("docdb-elastic", "DocDB Elastic", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/clusters";

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListClustersOutput {
    const result: ListClustersOutput = try aws.json.parseJsonObject(
        ListClustersOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
