const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Currency = @import("currency.zig").Currency;
const MonetizationFilter = @import("monetization_filter.zig").MonetizationFilter;
const GroupByType = @import("group_by_type.zig").GroupByType;
const IntervalType = @import("interval_type.zig").IntervalType;
const Scope = @import("scope.zig").Scope;
const TimeSeriesStatisticType = @import("time_series_statistic_type.zig").TimeSeriesStatisticType;
const TimeWindow = @import("time_window.zig").TimeWindow;
const DataPointEntry = @import("data_point_entry.zig").DataPointEntry;

pub const GetRevenueStatisticsTimeSeriesInput = struct {
    /// The currency for the amounts in the response.
    currency: Currency,

    /// Optional filters to narrow the results.
    filters: ?[]const MonetizationFilter = null,

    /// The dimension to group results by.
    group_by: ?GroupByType = null,

    /// The time interval for aggregating data points: `MINUTELY`, `FIVE_MINUTELY`,
    /// `HOURLY`, or `DAILY`.
    interval: IntervalType,

    /// The maximum number of data points to return. Minimum: 1. Maximum: 10000.
    limit: ?i32 = null,

    /// When you get a paginated response, this marker indicates that additional
    /// results are available.
    next_marker: ?[]const u8 = null,

    /// Specifies whether this is for a Amazon CloudFront distribution
    /// (`CLOUDFRONT`) or for a regional application (`REGIONAL`).
    scope: Scope,

    /// The type of time series data to retrieve: `DATE_HISTOGRAM` for revenue over
    /// time, or `PAYMENT_TRAFFIC` for payment traffic patterns.
    statistic_type: TimeSeriesStatisticType,

    /// The time range for the query. Specify start and end timestamps.
    time_window: TimeWindow,

    pub const json_field_names = .{
        .currency = "Currency",
        .filters = "Filters",
        .group_by = "GroupBy",
        .interval = "Interval",
        .limit = "Limit",
        .next_marker = "NextMarker",
        .scope = "Scope",
        .statistic_type = "StatisticType",
        .time_window = "TimeWindow",
    };
};

pub const GetRevenueStatisticsTimeSeriesOutput = struct {
    /// The list of time series data points.
    data_points: ?[]const DataPointEntry = null,

    /// When you get a paginated response, this marker indicates that additional
    /// results are available.
    next_marker: ?[]const u8 = null,

    pub const json_field_names = .{
        .data_points = "DataPoints",
        .next_marker = "NextMarker",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetRevenueStatisticsTimeSeriesInput, options: CallOptions) !GetRevenueStatisticsTimeSeriesOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetRevenueStatisticsTimeSeriesInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSWAF_20190729.GetRevenueStatisticsTimeSeries");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetRevenueStatisticsTimeSeriesOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GetRevenueStatisticsTimeSeriesOutput, body, allocator);
}
