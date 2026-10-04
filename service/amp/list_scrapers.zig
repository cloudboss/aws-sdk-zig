const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ScraperSummary = @import("scraper_summary.zig").ScraperSummary;

pub const ListScrapersInput = struct {
    /// (Optional) A list of key-value pairs to filter the list of scrapers
    /// returned. Keys include `status`, `sourceArn`, `destinationArn`, and `alias`.
    ///
    /// Filters on the same key are `OR`'d together, and filters on different keys
    /// are `AND`'d together. For example,
    /// `status=ACTIVE&status=CREATING&alias=Test`, will return all scrapers that
    /// have the alias Test, and are either in status ACTIVE or CREATING.
    ///
    /// To find all active scrapers that are sending metrics to a specific Amazon
    /// Managed Service for Prometheus workspace, you would use the ARN of the
    /// workspace in a query:
    ///
    /// `status=ACTIVE&destinationArn=arn:aws:aps:us-east-1:123456789012:workspace/ws-example1-1234-abcd-56ef-123456789012`
    ///
    /// If this is included, it filters the results to only the scrapers that match
    /// the filter.
    filters: ?[]const aws.map.MapEntry([]const []const u8) = null,

    /// Optional) The maximum number of scrapers to return in one `ListScrapers`
    /// operation. The range is 1-1000.
    ///
    /// If you omit this parameter, the default of 100 is used.
    max_results: ?i32 = null,

    /// (Optional) The token for the next set of items to return. (You received this
    /// token from a previous call.)
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .filters = "filters",
        .max_results = "maxResults",
        .next_token = "nextToken",
    };
};

pub const ListScrapersOutput = struct {
    /// A token indicating that there are more results to retrieve. You can use this
    /// token as part of your next `ListScrapers` operation to retrieve those
    /// results.
    next_token: ?[]const u8 = null,

    /// A list of `ScraperSummary` structures giving information about scrapers in
    /// the account that match the filters provided.
    scrapers: ?[]const ScraperSummary = null,

    pub const json_field_names = .{
        .next_token = "nextToken",
        .scrapers = "scrapers",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListScrapersInput, options: CallOptions) !ListScrapersOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "aps", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListScrapersInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("aps", "amp", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/scrapers";

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

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.filters) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"filters\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListScrapersOutput {
    var result: ListScrapersOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(ListScrapersOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
