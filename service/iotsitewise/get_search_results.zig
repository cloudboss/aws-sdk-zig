const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const SearchResult = @import("search_result.zig").SearchResult;

pub const GetSearchResultsInput = struct {
    /// The maximum number of results to return in a single page. Valid range is 1
    /// to 10,000; if
    /// omitted, a service-defined default is used.
    max_results: ?i32 = null,

    /// The pagination token returned by a previous GetSearchResults call. Provide
    /// it to retrieve the
    /// next page of results; omit it to retrieve the first page.
    next_token: ?[]const u8 = null,

    /// The identifier of the search whose results are retrieved.
    search_id: []const u8,

    /// The name of the workspace the search belongs to.
    workspace_name: []const u8,

    pub const json_field_names = .{
        .max_results = "maxResults",
        .next_token = "nextToken",
        .search_id = "searchId",
        .workspace_name = "workspaceName",
    };
};

pub const GetSearchResultsOutput = struct {
    /// The pagination token to use in a subsequent GetSearchResults call to
    /// retrieve the next page.
    /// Absent when there are no more results.
    next_token: ?[]const u8 = null,

    /// A page of search results, ordered by descending relevance score.
    search_results: ?[]const SearchResult = null,

    pub const json_field_names = .{
        .next_token = "nextToken",
        .search_results = "searchResults",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetSearchResultsInput, options: CallOptions) !GetSearchResultsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "iotsitewise", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetSearchResultsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("iotsitewise", "IoTSiteWise", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/workspaces/");
    try path_buf.appendSlice(allocator, input.workspace_name);
    try path_buf.appendSlice(allocator, "/searches/");
    try path_buf.appendSlice(allocator, input.search_id);
    try path_buf.appendSlice(allocator, "/results");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetSearchResultsOutput {
    const result: GetSearchResultsOutput = try aws.json.parseJsonObject(
        GetSearchResultsOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
