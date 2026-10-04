const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ListSearchesFilters = @import("list_searches_filters.zig").ListSearchesFilters;
const SearchSummary = @import("search_summary.zig").SearchSummary;

pub const ListSearchesInput = struct {
    /// Optional filters that restrict which searches are returned.
    list_searches_filters: ?ListSearchesFilters = null,

    /// The maximum number of searches to return in a single page. Valid range is 1
    /// to 1,000; if
    /// omitted, a service-defined default is used.
    max_results: ?i32 = null,

    /// The pagination token returned by a previous ListSearches call. Provide it to
    /// retrieve the next
    /// page; omit it to retrieve the first page.
    next_token: ?[]const u8 = null,

    /// The name of the workspace whose searches are listed.
    workspace_name: []const u8,

    pub const json_field_names = .{
        .list_searches_filters = "listSearchesFilters",
        .max_results = "maxResults",
        .next_token = "nextToken",
        .workspace_name = "workspaceName",
    };
};

pub const ListSearchesOutput = struct {
    /// The pagination token to use in a subsequent ListSearches call to retrieve
    /// the next page. Absent
    /// when there are no more searches.
    next_token: ?[]const u8 = null,

    /// A page of search summaries, most recently started first.
    search_summaries: ?[]const SearchSummary = null,

    pub const json_field_names = .{
        .next_token = "nextToken",
        .search_summaries = "searchSummaries",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListSearchesInput, options: CallOptions) !ListSearchesOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListSearchesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("iotsitewise", "IoTSiteWise", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/workspaces/");
    try path_buf.appendSlice(allocator, input.workspace_name);
    try path_buf.appendSlice(allocator, "/searches/list");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.list_searches_filters) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"listSearchesFilters\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.max_results) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"maxResults\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.next_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"nextToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListSearchesOutput {
    const result: ListSearchesOutput = try aws.json.parseJsonObject(
        ListSearchesOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
