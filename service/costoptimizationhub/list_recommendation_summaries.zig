const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
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

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListRecommendationSummariesInput, options: Options) !ListRecommendationSummariesOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "costoptimizationhub");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: ListRecommendationSummariesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("costoptimizationhub", "Cost Optimization Hub", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = "/";
    request.tls = tls;
    request.port = port;
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

fn parseErrorResponse(allocator: std.mem.Allocator, body: []const u8, status: u16) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(allocator);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, "");

    if (std.mem.eql(u8, error_code, "AccessDeniedException")) {
        return .{ .arena = arena, .kind = .{ .access_denied_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InternalServerException")) {
        return .{ .arena = arena, .kind = .{ .internal_server_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .resource_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ThrottlingException")) {
        return .{ .arena = arena, .kind = .{ .throttling_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ValidationException")) {
        return .{ .arena = arena, .kind = .{ .validation_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
