const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Filter = @import("filter.zig").Filter;
const OrderBy = @import("order_by.zig").OrderBy;
const Recommendation = @import("recommendation.zig").Recommendation;

pub const ListRecommendationsInput = struct {
    /// The constraints that you want all returned recommendations to match.
    filter: ?Filter = null,

    /// List of all recommendations for a resource, or a single recommendation if
    /// de-duped by `resourceId`.
    include_all_recommendations: ?bool = null,

    /// The maximum number of recommendations that are returned for the request.
    max_results: ?i32 = null,

    /// The token to retrieve the next set of results.
    next_token: ?[]const u8 = null,

    /// The ordering of recommendations by a dimension.
    order_by: ?OrderBy = null,

    pub const json_field_names = .{
        .filter = "filter",
        .include_all_recommendations = "includeAllRecommendations",
        .max_results = "maxResults",
        .next_token = "nextToken",
        .order_by = "orderBy",
    };
};

pub const ListRecommendationsOutput = struct {
    /// List of all savings recommendations.
    items: ?[]const Recommendation = null,

    /// The token to retrieve the next set of results.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .items = "items",
        .next_token = "nextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListRecommendationsInput, options: CallOptions) !ListRecommendationsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "costoptimizationhubservice", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListRecommendationsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("cost-optimization-hub", "Cost Optimization Hub", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "CostOptimizationHubService.ListRecommendations");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListRecommendationsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListRecommendationsOutput, body, allocator);
}
