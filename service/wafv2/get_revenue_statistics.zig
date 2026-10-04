const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Currency = @import("currency.zig").Currency;
const MonetizationFilter = @import("monetization_filter.zig").MonetizationFilter;
const GroupByType = @import("group_by_type.zig").GroupByType;
const Scope = @import("scope.zig").Scope;
const RankingSortBy = @import("ranking_sort_by.zig").RankingSortBy;
const SortOrder = @import("sort_order.zig").SortOrder;
const RankingStatisticType = @import("ranking_statistic_type.zig").RankingStatisticType;
const TimeWindow = @import("time_window.zig").TimeWindow;
const RevenuePathStatistics = @import("revenue_path_statistics.zig").RevenuePathStatistics;
const SourceStatistics = @import("source_statistics.zig").SourceStatistics;

pub const GetRevenueStatisticsInput = struct {
    /// The currency for the revenue amounts in the response.
    currency: Currency,

    /// Optional filters to narrow the results.
    filters: ?[]const MonetizationFilter = null,

    /// The dimension to group results by: `NAME`, `CATEGORY`, `INTENT`,
    /// `ORGANIZATION`, or `WEBACL`. Required when `StatisticType` is
    /// `TOP_SOURCES_BY_REVENUE`. Not required for `TOP_PATHS_BY_REVENUE`, where
    /// results are grouped by content path. If `StatisticType` is
    /// `TOP_SOURCES_BY_REVENUE` and `GroupBy` is omitted, the request is rejected
    /// with a `WAFInvalidParameterException`.
    group_by: ?GroupByType = null,

    /// The maximum number of results to return.
    limit: ?i32 = null,

    /// When you get a paginated response, this marker indicates that additional
    /// results are available. Use it in a subsequent request to retrieve the next
    /// page of results.
    next_marker: ?[]const u8 = null,

    /// Specifies whether this is for a Amazon CloudFront distribution
    /// (`CLOUDFRONT`) or for a regional application (`REGIONAL`).
    scope: Scope,

    /// The field to sort results by: `REVENUE`, `PERCENTAGE`, or `NAME`.
    sort_by: ?RankingSortBy = null,

    /// The sort order: `ASC` for ascending or `DESC` for descending.
    sort_order: ?SortOrder = null,

    /// `TOP_SOURCES_BY_REVENUE` ranks revenue from AI bot traffic, grouped by the
    /// dimension you specify in the `GroupBy` parameter (`NAME`, `CATEGORY`,
    /// `INTENT`, `ORGANIZATION`, or `WEBACL`); `GroupBy` is required for this
    /// statistic type. `TOP_PATHS_BY_REVENUE` ranks revenue by path.
    statistic_type: RankingStatisticType,

    /// The time range for the query. Specify start and end timestamps.
    time_window: TimeWindow,

    pub const json_field_names = .{
        .currency = "Currency",
        .filters = "Filters",
        .group_by = "GroupBy",
        .limit = "Limit",
        .next_marker = "NextMarker",
        .scope = "Scope",
        .sort_by = "SortBy",
        .sort_order = "SortOrder",
        .statistic_type = "StatisticType",
        .time_window = "TimeWindow",
    };
};

pub const GetRevenueStatisticsOutput = struct {
    /// When you get a paginated response, this marker indicates that additional
    /// results are available.
    next_marker: ?[]const u8 = null,

    /// Statistics for top revenue paths. Populated when `StatisticType` is
    /// `TOP_PATHS_BY_REVENUE`.
    revenue_path_statistics: ?[]const RevenuePathStatistics = null,

    /// Statistics for top revenue sources (AI bots). Populated when `StatisticType`
    /// is `TOP_SOURCES_BY_REVENUE`.
    source_statistics: ?[]const SourceStatistics = null,

    pub const json_field_names = .{
        .next_marker = "NextMarker",
        .revenue_path_statistics = "RevenuePathStatistics",
        .source_statistics = "SourceStatistics",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetRevenueStatisticsInput, options: CallOptions) !GetRevenueStatisticsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "wafv2", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetRevenueStatisticsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("wafv2", "WAFV2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWSWAF_20190729.GetRevenueStatistics");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetRevenueStatisticsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GetRevenueStatisticsOutput, body, allocator);
}
