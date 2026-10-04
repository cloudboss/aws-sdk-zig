const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const SourceLocation = @import("source_location.zig").SourceLocation;

pub const ListSourceLocationsInput = struct {
    /// The maximum number of source locations that you want MediaTailor to return
    /// in response to the current request. If there are more than `MaxResults`
    /// source locations, use the value of `NextToken` in the response to get the
    /// next page of results.
    ///
    /// The default value is 100. MediaTailor uses DynamoDB-based pagination, which
    /// means that a response might contain fewer than `MaxResults` items, including
    /// 0 items, even when more results are available. To retrieve all results, you
    /// must continue making requests using the `NextToken` value from each response
    /// until the response no longer includes a `NextToken` value.
    max_results: ?i32 = null,

    /// Pagination token returned by the list request when results exceed the
    /// maximum allowed. Use the token to fetch the next page of results.
    ///
    /// For the first `ListSourceLocations` request, omit this value. For subsequent
    /// requests, get the value of `NextToken` from the previous response and
    /// specify that value for `NextToken` in the request. Continue making requests
    /// until the response no longer includes a `NextToken` value, which indicates
    /// that all results have been retrieved.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .max_results = "MaxResults",
        .next_token = "NextToken",
    };
};

pub const ListSourceLocationsOutput = struct {
    /// A list of source locations.
    items: ?[]const SourceLocation = null,

    /// Pagination token returned by the list request when results exceed the
    /// maximum allowed. Use the token to fetch the next page of results.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .items = "Items",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListSourceLocationsInput, options: CallOptions) !ListSourceLocationsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "mediatailor", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListSourceLocationsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("api.mediatailor", "MediaTailor", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/sourceLocations";

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListSourceLocationsOutput {
    const result: ListSourceLocationsOutput = try aws.json.parseJsonObject(
        ListSourceLocationsOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
