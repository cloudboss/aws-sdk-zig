const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AppBundleSummary = @import("app_bundle_summary.zig").AppBundleSummary;

pub const ListAppBundlesInput = struct {
    /// The maximum number of results that are returned per call. You can use
    /// `nextToken` to obtain further pages of results.
    ///
    /// This is only an upper limit. The actual number of results returned per call
    /// might be
    /// fewer than the specified maximum.
    max_results: ?i32 = null,

    /// If `nextToken` is returned, there are more results available. The value of
    /// `nextToken` is a unique pagination token for each page. Make the call again
    /// using the returned token to retrieve the next page. Keep all other arguments
    /// unchanged.
    /// Each pagination token expires after 24 hours. Using an expired pagination
    /// token will return
    /// an *HTTP 400 InvalidToken error*.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .max_results = "maxResults",
        .next_token = "nextToken",
    };
};

pub const ListAppBundlesOutput = struct {
    /// Contains a list of app bundle summaries.
    app_bundle_summary_list: ?[]const AppBundleSummary = null,

    /// If `nextToken` is returned, there are more results available. The value of
    /// `nextToken` is a unique pagination token for each page. Make the call again
    /// using the returned token to retrieve the next page. Keep all other arguments
    /// unchanged.
    /// Each pagination token expires after 24 hours. Using an expired pagination
    /// token will return
    /// an *HTTP 400 InvalidToken error*.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .app_bundle_summary_list = "appBundleSummaryList",
        .next_token = "nextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListAppBundlesInput, options: CallOptions) !ListAppBundlesOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "appfabric", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListAppBundlesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("appfabric", "AppFabric", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/appbundles";

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListAppBundlesOutput {
    const result: ListAppBundlesOutput = try aws.json.parseJsonObject(
        ListAppBundlesOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
