const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Crawler = @import("crawler.zig").Crawler;

pub const BatchGetCrawlersInput = struct {
    /// A list of crawler names, which might be the names returned from the
    /// `ListCrawlers` operation.
    crawler_names: []const []const u8,

    pub const json_field_names = .{
        .crawler_names = "CrawlerNames",
    };
};

pub const BatchGetCrawlersOutput = struct {
    /// A list of crawler definitions.
    crawlers: ?[]const Crawler = null,

    /// A list of names of crawlers that were not found.
    crawlers_not_found: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .crawlers = "Crawlers",
        .crawlers_not_found = "CrawlersNotFound",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: BatchGetCrawlersInput, options: CallOptions) !BatchGetCrawlersOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: BatchGetCrawlersInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSGlue.BatchGetCrawlers");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !BatchGetCrawlersOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(BatchGetCrawlersOutput, body, allocator);
}
