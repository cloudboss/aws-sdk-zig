const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Filter = @import("filter.zig").Filter;
const SummaryMetrics = @import("summary_metrics.zig").SummaryMetrics;
const RecommendationSummary = @import("recommendation_summary.zig").RecommendationSummary;
const SummaryMetricsResult = @import("summary_metrics_result.zig").SummaryMetricsResult;

pub const ListRecommendationSummariesInput = struct {
    filter: ?Filter = null,

    /// The grouping of recommendations by a dimension.
    group_by: []const u8,

    /// The maximum number of recommendations to be returned for the request.
    max_results: ?i32 = null,

    /// Additional metrics to be returned for the request. The only valid value is
    /// `savingsPercentage`.
    metrics: ?[]const SummaryMetrics = null,

    /// The token to retrieve the next set of results.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .filter = "filter",
        .group_by = "groupBy",
        .max_results = "maxResults",
        .metrics = "metrics",
        .next_token = "nextToken",
    };
};

pub const ListRecommendationSummariesOutput = struct {
    /// The currency code used for the recommendation.
    currency_code: ?[]const u8 = null,

    /// The total overall savings for the aggregated view.
    estimated_total_deduped_savings: ?f64 = null,

    /// The dimension used to group the recommendations by.
    group_by: ?[]const u8 = null,

    /// A list of all savings recommendations.
    items: ?[]const RecommendationSummary = null,

    /// The results or descriptions for the additional metrics, based on whether the
    /// metrics were or were not requested.
    metrics: ?SummaryMetricsResult = null,

    /// The token to retrieve the next set of results.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .currency_code = "currencyCode",
        .estimated_total_deduped_savings = "estimatedTotalDedupedSavings",
        .group_by = "groupBy",
        .items = "items",
        .metrics = "metrics",
        .next_token = "nextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListRecommendationSummariesInput, options: CallOptions) !ListRecommendationSummariesOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListRecommendationSummariesInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "CostOptimizationHubService.ListRecommendationSummaries");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListRecommendationSummariesOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListRecommendationSummariesOutput, body, allocator);
}
