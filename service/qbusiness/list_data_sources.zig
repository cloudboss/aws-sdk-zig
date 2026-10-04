const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DataSource = @import("data_source.zig").DataSource;

pub const ListDataSourcesInput = struct {
    /// The identifier of the Amazon Q Business application linked to the data
    /// source connectors.
    application_id: []const u8,

    /// The identifier of the index used with one or more data source connectors.
    index_id: []const u8,

    /// The maximum number of data source connectors to return.
    max_results: ?i32 = null,

    /// If the `maxResults` response was incomplete because there is more data to
    /// retrieve, Amazon Q Business returns a pagination token in the response. You
    /// can use this pagination token to retrieve the next set of Amazon Q Business
    /// data source connectors.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .application_id = "applicationId",
        .index_id = "indexId",
        .max_results = "maxResults",
        .next_token = "nextToken",
    };
};

pub const ListDataSourcesOutput = struct {
    /// An array of summary information for one or more data source connector.
    data_sources: ?[]const DataSource = null,

    /// If the response is truncated, Amazon Q Business returns this token. You can
    /// use this token in a subsequent request to retrieve the next set of data
    /// source connectors.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .data_sources = "dataSources",
        .next_token = "nextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListDataSourcesInput, options: CallOptions) !ListDataSourcesOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "qbusiness", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListDataSourcesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("qbusiness", "QBusiness", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/applications/");
    try path_buf.appendSlice(allocator, input.application_id);
    try path_buf.appendSlice(allocator, "/indices/");
    try path_buf.appendSlice(allocator, input.index_id);
    try path_buf.appendSlice(allocator, "/datasources");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListDataSourcesOutput {
    const result: ListDataSourcesOutput = try aws.json.parseJsonObject(
        ListDataSourcesOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
