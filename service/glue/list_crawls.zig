const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const CrawlsFilter = @import("crawls_filter.zig").CrawlsFilter;
const CrawlerHistory = @import("crawler_history.zig").CrawlerHistory;

pub const ListCrawlsInput = struct {
    /// The name of the crawler whose runs you want to retrieve.
    crawler_name: []const u8,

    /// Filters the crawls by the criteria you specify in a list of `CrawlsFilter`
    /// objects.
    filters: ?[]const CrawlsFilter = null,

    /// The maximum number of results to return. The default is 20, and maximum is
    /// 100.
    max_results: ?i32 = null,

    /// A continuation token, if this is a continuation call.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .crawler_name = "CrawlerName",
        .filters = "Filters",
        .max_results = "MaxResults",
        .next_token = "NextToken",
    };
};

pub const ListCrawlsOutput = struct {
    /// A list of `CrawlerHistory` objects representing the crawl runs that meet
    /// your criteria.
    crawls: ?[]const CrawlerHistory = null,

    /// A continuation token for paginating the returned list of tokens, returned if
    /// the current segment of the list is not the last.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .crawls = "Crawls",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListCrawlsInput, options: CallOptions) !ListCrawlsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "glue", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListCrawlsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("glue", "Glue", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWSGlue.ListCrawls");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListCrawlsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListCrawlsOutput, body, allocator);
}
