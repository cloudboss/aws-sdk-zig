const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const FeedSummary = @import("feed_summary.zig").FeedSummary;

pub const ListFeedsInput = struct {
    /// The maximum number of results to return per API request.
    ///
    /// For example, you submit a list request with MaxResults set at 5. Although 20
    /// items match your request, the service returns no more than the first 5
    /// items. (The service also returns a NextToken value that you can use to fetch
    /// the next batch of results.)
    ///
    /// The service might return fewer results than the MaxResults value. If
    /// MaxResults is not included in the request, the service defaults to
    /// pagination with a maximum of 10 results per page.
    ///
    /// Valid Range: Minimum value of 1. Maximum value of 1000.
    max_results: ?i32 = null,

    /// The token that identifies the batch of results that you want to see.
    ///
    /// For example, you submit a ListFeeds request with MaxResults set at 5. The
    /// service returns the first batch of results (up to 5) and a NextToken value.
    /// To see the next batch of results, you can submit the ListFeeds request a
    /// second time and specify the NextToken value.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .max_results = "maxResults",
        .next_token = "nextToken",
    };
};

pub const ListFeedsOutput = struct {
    /// A list of FeedSummary objects.
    feeds: ?[]const FeedSummary = null,

    /// The token that identifies the batch of results that you want to see. For
    /// example, you submit a list request with MaxResults set at 5. The service
    /// returns the first batch of results (up to 5) and a NextToken value. To see
    /// the next batch of results, you can submit the list request a second time and
    /// specify the NextToken value.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .feeds = "feeds",
        .next_token = "nextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListFeedsInput, options: CallOptions) !ListFeedsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "elemental-inference", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListFeedsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("elemental-inference", "ElementalInference", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/v1/feeds";

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListFeedsOutput {
    const result: ListFeedsOutput = try aws.json.parseJsonObject(
        ListFeedsOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
