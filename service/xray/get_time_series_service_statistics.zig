const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const TimeSeriesServiceStatistics = @import("time_series_service_statistics.zig").TimeSeriesServiceStatistics;

pub const GetTimeSeriesServiceStatisticsInput = struct {
    /// The end of the time frame for which to aggregate statistics.
    end_time: i64,

    /// A filter expression defining entities that will be aggregated for
    /// statistics.
    /// Supports ID, service, and edge functions. If no selector expression is
    /// specified, edge
    /// statistics are returned.
    entity_selector_expression: ?[]const u8 = null,

    /// The forecasted high and low fault count values. Forecast enabled requests
    /// require the
    /// EntitySelectorExpression ID be provided.
    forecast_statistics: ?bool = null,

    /// The Amazon Resource Name (ARN) of the group for which to pull statistics
    /// from.
    group_arn: ?[]const u8 = null,

    /// The case-sensitive name of the group for which to pull statistics from.
    group_name: ?[]const u8 = null,

    /// Pagination token.
    next_token: ?[]const u8 = null,

    /// Aggregation period in seconds.
    period: ?i32 = null,

    /// The start of the time frame for which to aggregate statistics.
    start_time: i64,

    pub const json_field_names = .{
        .end_time = "EndTime",
        .entity_selector_expression = "EntitySelectorExpression",
        .forecast_statistics = "ForecastStatistics",
        .group_arn = "GroupARN",
        .group_name = "GroupName",
        .next_token = "NextToken",
        .period = "Period",
        .start_time = "StartTime",
    };
};

pub const GetTimeSeriesServiceStatisticsOutput = struct {
    /// A flag indicating whether or not a group's filter expression has been
    /// consistent, or if a returned
    /// aggregation might show statistics from an older version of the group's
    /// filter expression.
    contains_old_group_versions: ?bool = null,

    /// Pagination token.
    next_token: ?[]const u8 = null,

    /// The collection of statistics.
    time_series_service_statistics: ?[]const TimeSeriesServiceStatistics = null,

    pub const json_field_names = .{
        .contains_old_group_versions = "ContainsOldGroupVersions",
        .next_token = "NextToken",
        .time_series_service_statistics = "TimeSeriesServiceStatistics",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetTimeSeriesServiceStatisticsInput, options: CallOptions) !GetTimeSeriesServiceStatisticsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "xray", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetTimeSeriesServiceStatisticsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("xray", "XRay", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/TimeSeriesServiceStatistics";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"EndTime\":");
    try aws.json.writeValue(@TypeOf(input.end_time), input.end_time, allocator, &body_buf);
    has_prev = true;
    if (input.entity_selector_expression) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"EntitySelectorExpression\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.forecast_statistics) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ForecastStatistics\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.group_arn) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"GroupARN\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.group_name) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"GroupName\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.next_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"NextToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.period) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Period\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"StartTime\":");
    try aws.json.writeValue(@TypeOf(input.start_time), input.start_time, allocator, &body_buf);
    has_prev = true;

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetTimeSeriesServiceStatisticsOutput {
    var result: GetTimeSeriesServiceStatisticsOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetTimeSeriesServiceStatisticsOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
