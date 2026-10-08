const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const EmissionsType = @import("emissions_type.zig").EmissionsType;
const FilterExpression = @import("filter_expression.zig").FilterExpression;
const TimeGranularity = @import("time_granularity.zig").TimeGranularity;
const GranularityConfiguration = @import("granularity_configuration.zig").GranularityConfiguration;
const Dimension = @import("dimension.zig").Dimension;
const TimePeriod = @import("time_period.zig").TimePeriod;
const EstimatedCarbonEmissions = @import("estimated_carbon_emissions.zig").EstimatedCarbonEmissions;

pub const GetEstimatedCarbonEmissionsInput = struct {
    /// The emission types to include in the results. If absent, returns
    /// `TOTAL_LBM_CARBON_EMISSIONS` and `TOTAL_MBM_CARBON_EMISSIONS` emissions
    /// types.
    emissions_types: ?[]const EmissionsType = null,

    /// The criteria for filtering estimated carbon emissions. To determine which
    /// dimensions are available to be filtered by, you can first call
    /// GetEstimatedCarbonEmissionsDimensionValues
    filter_by: ?FilterExpression = null,

    /// The time granularity for the results. If absent, uses `MONTHLY` time
    /// granularity. The smallest supported granularity for carbon emissions is
    /// `MONTHLY`.
    ///
    /// If requesting partial time periods, data will be returned based on the
    /// smallest supported granularity. For example, requesting
    /// `2025-04-01T00:00:00Z` to `2026-04-01T00:00:00Z` with `YEARLY_CALENDAR`
    /// granularity will return the last 9 months for 2025 and the first 3 months of
    /// 2026.
    granularity: ?TimeGranularity = null,

    /// Configuration for fiscal year calculations when using `YEARLY_FISCAL` or
    /// `QUARTERLY_FISCAL` granularity.
    granularity_configuration: ?GranularityConfiguration = null,

    /// The dimensions available for grouping estimated carbon emissions.
    group_by: ?[]const Dimension = null,

    /// The maximum number of results to return in a single call. Default is 1000.
    max_results: ?i32 = null,

    /// The pagination token specifying which page of results to return in the
    /// response. If no token is provided, the default page is the first page.
    next_token: ?[]const u8 = null,

    /// The date range for fetching estimated carbon emissions. The range must
    /// include the start date of a month for that month's data to be included in
    /// the response.
    time_period: TimePeriod,

    pub const json_field_names = .{
        .emissions_types = "EmissionsTypes",
        .filter_by = "FilterBy",
        .granularity = "Granularity",
        .granularity_configuration = "GranularityConfiguration",
        .group_by = "GroupBy",
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .time_period = "TimePeriod",
    };
};

pub const GetEstimatedCarbonEmissionsOutput = struct {
    /// The pagination token indicating there are additional pages available. You
    /// can use the token in a following request to fetch the next set of results.
    next_token: ?[]const u8 = null,

    /// The result of the requested inputs.
    results: ?[]const EstimatedCarbonEmissions = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .results = "Results",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetEstimatedCarbonEmissionsInput, options: CallOptions) !GetEstimatedCarbonEmissionsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "sustainability", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetEstimatedCarbonEmissionsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("sustainability", "Sustainability", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/v1/estimated-carbon-emissions";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.emissions_types) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"EmissionsTypes\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.filter_by) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"FilterBy\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.granularity) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Granularity\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.granularity_configuration) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"GranularityConfiguration\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.group_by) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"GroupBy\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.max_results) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"MaxResults\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.next_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"NextToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"TimePeriod\":");
    try aws.json.writeValue(@TypeOf(input.time_period), input.time_period, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetEstimatedCarbonEmissionsOutput {
    const result: GetEstimatedCarbonEmissionsOutput = try aws.json.parseJsonObject(
        GetEstimatedCarbonEmissionsOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
