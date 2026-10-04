const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const StreamSummary = @import("stream_summary.zig").StreamSummary;

pub const ListStreamsInput = struct {
    /// The ID of the cluster for which to list streams.
    cluster_identifier: []const u8,

    /// An optional parameter that specifies the maximum number of results to
    /// return. You can use nextToken to display the next page of results. Default:
    /// 10.
    max_results: ?i32 = null,

    /// If your initial ListStreams operation returns a nextToken, you can include
    /// the returned nextToken in following ListStreams operations, which returns
    /// results in the next page.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .cluster_identifier = "clusterIdentifier",
        .max_results = "maxResults",
        .next_token = "nextToken",
    };
};

pub const ListStreamsOutput = struct {
    /// If nextToken is returned, there are more results available. The value of
    /// nextToken is a unique pagination token for each page. To retrieve the next
    /// page, make the call again using the returned token.
    next_token: ?[]const u8 = null,

    /// An array of the returned streams.
    streams: ?[]const StreamSummary = null,

    pub const json_field_names = .{
        .next_token = "nextToken",
        .streams = "streams",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListStreamsInput, options: CallOptions) !ListStreamsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "dsql", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListStreamsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("dsql", "DSQL", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/stream/");
    try path_buf.appendSlice(allocator, input.cluster_identifier);
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.max_results) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "max-results=");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try query_buf.appendSlice(allocator, num_str);
        }
        query_has_prev = true;
    }
    if (input.next_token) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "next-token=");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListStreamsOutput {
    const result: ListStreamsOutput = try aws.json.parseJsonObject(
        ListStreamsOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
