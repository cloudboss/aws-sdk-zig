const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const SearchSampleQueriesSearchResult = @import("search_sample_queries_search_result.zig").SearchSampleQueriesSearchResult;

pub const SearchSampleQueriesInput = struct {
    /// The maximum number of results to return on a single page. The default value
    /// is 10.
    max_results: ?i32 = null,

    /// A token you can use to get the next page of results. The length constraint
    /// is in characters, not words.
    next_token: ?[]const u8 = null,

    /// The natural language phrase to use for the semantic search. The phrase must
    /// be in English. The length constraint is in characters, not words.
    search_phrase: []const u8,

    pub const json_field_names = .{
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .search_phrase = "SearchPhrase",
    };
};

pub const SearchSampleQueriesOutput = struct {
    /// A token you can use to get the next page of results.
    next_token: ?[]const u8 = null,

    /// A list of objects containing the search results ordered from most relevant
    /// to least relevant.
    search_results: ?[]const SearchSampleQueriesSearchResult = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .search_results = "SearchResults",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: SearchSampleQueriesInput, options: CallOptions) !SearchSampleQueriesOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "cloudtrail", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: SearchSampleQueriesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("cloudtrail", "CloudTrail", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "CloudTrail_20131101.SearchSampleQueries");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !SearchSampleQueriesOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(SearchSampleQueriesOutput, body, allocator);
}
