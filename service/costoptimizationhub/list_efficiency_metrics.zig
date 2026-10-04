const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const GranularityType = @import("granularity_type.zig").GranularityType;
const OrderBy = @import("order_by.zig").OrderBy;
const TimePeriod = @import("time_period.zig").TimePeriod;
const EfficiencyMetricsByGroup = @import("efficiency_metrics_by_group.zig").EfficiencyMetricsByGroup;

pub const ListEfficiencyMetricsInput = struct {
    /// The time granularity for the cost efficiency metrics. Specify `Daily` for
    /// metrics aggregated by day, or `Monthly` for metrics aggregated by month.
    granularity: GranularityType,

    /// The dimension by which to group the cost efficiency metrics. Valid values
    /// include account ID, Amazon Web Services Region. When no grouping is
    /// specified, metrics are aggregated across all resources in the specified time
    /// period.
    group_by: ?[]const u8 = null,

    /// The maximum number of groups to return in the response. Valid values range
    /// from 0 to 1000. Use in conjunction with `nextToken` to paginate through
    /// results when the total number of groups exceeds this limit.
    max_results: ?i32 = null,

    /// The token to retrieve the next page of results. This value is returned in
    /// the response when the number of groups exceeds the specified `maxResults`
    /// value.
    next_token: ?[]const u8 = null,

    /// The ordering specification for the results. Defines which dimension to sort
    /// by and whether to sort in ascending or descending order.
    order_by: ?OrderBy = null,

    /// The time period for which to retrieve the cost efficiency metrics. The start
    /// date is inclusive and the end date is exclusive. Dates can be specified in
    /// either YYYY-MM-DD format or YYYY-MM format depending on the desired
    /// granularity.
    time_period: TimePeriod,

    pub const json_field_names = .{
        .granularity = "granularity",
        .group_by = "groupBy",
        .max_results = "maxResults",
        .next_token = "nextToken",
        .order_by = "orderBy",
        .time_period = "timePeriod",
    };
};

pub const ListEfficiencyMetricsOutput = struct {
    /// A list of cost efficiency metrics grouped by the specified dimension. Each
    /// group contains time-series data points with cost efficiency, potential
    /// savings, and optimzable spend for the specified time period.
    efficiency_metrics_by_group: ?[]const EfficiencyMetricsByGroup = null,

    /// The token to retrieve the next page of results. When this value is present
    /// in the response, additional groups are available. Pass this token in the
    /// `nextToken` parameter of a subsequent request to retrieve the next page.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .efficiency_metrics_by_group = "efficiencyMetricsByGroup",
        .next_token = "nextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListEfficiencyMetricsInput, options: CallOptions) !ListEfficiencyMetricsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListEfficiencyMetricsInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "CostOptimizationHubService.ListEfficiencyMetrics");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListEfficiencyMetricsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListEfficiencyMetricsOutput, body, allocator);
}
