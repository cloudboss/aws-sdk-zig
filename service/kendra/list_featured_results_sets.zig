const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const FeaturedResultsSetSummary = @import("featured_results_set_summary.zig").FeaturedResultsSetSummary;

pub const ListFeaturedResultsSetsInput = struct {
    /// The identifier of the index used for featuring results.
    index_id: []const u8,

    /// The maximum number of featured results sets to return.
    max_results: ?i32 = null,

    /// If the response is truncated, Amazon Kendra returns a pagination token
    /// in the response. You can use this pagination token to retrieve the next set
    /// of featured results sets.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .index_id = "IndexId",
        .max_results = "MaxResults",
        .next_token = "NextToken",
    };
};

pub const ListFeaturedResultsSetsOutput = struct {
    /// An array of summary information for one or more featured results sets.
    featured_results_set_summary_items: ?[]const FeaturedResultsSetSummary = null,

    /// If the response is truncated, Amazon Kendra returns a pagination token
    /// in the response.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .featured_results_set_summary_items = "FeaturedResultsSetSummaryItems",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListFeaturedResultsSetsInput, options: CallOptions) !ListFeaturedResultsSetsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "kendra", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListFeaturedResultsSetsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("kendra", "kendra", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWSKendraFrontendService.ListFeaturedResultsSets");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListFeaturedResultsSetsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListFeaturedResultsSetsOutput, body, allocator);
}
