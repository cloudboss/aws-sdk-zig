const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const PrivateGraphEndpointSummary = @import("private_graph_endpoint_summary.zig").PrivateGraphEndpointSummary;

pub const ListPrivateGraphEndpointsInput = struct {
    /// The unique identifier of the Neptune Analytics graph.
    graph_identifier: []const u8,

    /// The total number of records to return in the command's output.
    ///
    /// If the total number of records available is more than the value specified,
    /// `nextToken` is provided in the command's output. To resume pagination,
    /// provide the `nextToken` output value in the `nextToken` argument of a
    /// subsequent command. Do not use the `nextToken` response element directly
    /// outside of the Amazon CLI.
    max_results: ?i32 = null,

    /// Pagination token used to paginate output.
    ///
    /// When this value is provided as input, the service returns results from where
    /// the previous response left off. When this value is present in output, it
    /// indicates that there are more results to retrieve.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .graph_identifier = "graphIdentifier",
        .max_results = "maxResults",
        .next_token = "nextToken",
    };
};

pub const ListPrivateGraphEndpointsOutput = struct {
    /// Pagination token used to paginate output.
    ///
    /// When this value is provided as input, the service returns results from where
    /// the previous response left off. When this value is present in output, it
    /// indicates that there are more results to retrieve.
    next_token: ?[]const u8 = null,

    /// A list of private endpoints for the specified Neptune Analytics graph.
    private_graph_endpoints: ?[]const PrivateGraphEndpointSummary = null,

    pub const json_field_names = .{
        .next_token = "nextToken",
        .private_graph_endpoints = "privateGraphEndpoints",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListPrivateGraphEndpointsInput, options: CallOptions) !ListPrivateGraphEndpointsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "neptune-graph", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListPrivateGraphEndpointsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("neptune-graph", "Neptune Graph", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/graphs/");
    try path_buf.appendSlice(allocator, input.graph_identifier);
    try path_buf.appendSlice(allocator, "/endpoints/");
    const path = try path_buf.toOwnedSlice(allocator);

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListPrivateGraphEndpointsOutput {
    const result: ListPrivateGraphEndpointsOutput = try aws.json.parseJsonObject(
        ListPrivateGraphEndpointsOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
