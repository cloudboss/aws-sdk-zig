const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ResourcesTrendsFilters = @import("resources_trends_filters.zig").ResourcesTrendsFilters;
const GranularityField = @import("granularity_field.zig").GranularityField;
const ResourcesTrendsMetricsResult = @import("resources_trends_metrics_result.zig").ResourcesTrendsMetricsResult;

pub const GetResourcesTrendsV2Input = struct {
    /// The ending timestamp for the time period to analyze resources trends, in ISO
    /// 8601 format.
    end_time: i64,

    /// The filters to apply to the resources trend data.
    filters: ?ResourcesTrendsFilters = null,

    /// The maximum number of trend data points to return in a single response.
    max_results: ?i32 = null,

    /// The token to use for paginating results. This value is returned in the
    /// response if more results are available.
    next_token: ?[]const u8 = null,

    /// The starting timestamp for the time period to analyze resources trends, in
    /// ISO 8601 format.
    start_time: i64,

    pub const json_field_names = .{
        .end_time = "EndTime",
        .filters = "Filters",
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .start_time = "StartTime",
    };
};

pub const GetResourcesTrendsV2Output = struct {
    /// The time interval granularity for the returned trend data (such as DAILY or
    /// WEEKLY).
    granularity: GranularityField,

    /// The token to use for retrieving the next page of results, if more trend data
    /// is available.
    next_token: ?[]const u8 = null,

    /// The collection of time-series trend metrics, including counts of resources
    /// across the specified time period.
    trends_metrics: ?[]const ResourcesTrendsMetricsResult = null,

    pub const json_field_names = .{
        .granularity = "Granularity",
        .next_token = "NextToken",
        .trends_metrics = "TrendsMetrics",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetResourcesTrendsV2Input, options: CallOptions) !GetResourcesTrendsV2Output {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "securityhub", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetResourcesTrendsV2Input, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("securityhub", "SecurityHub", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/resourcesTrendsv2";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"EndTime\":");
    try aws.json.writeValue(@TypeOf(input.end_time), input.end_time, allocator, &body_buf);
    has_prev = true;
    if (input.filters) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Filters\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetResourcesTrendsV2Output {
    var result: GetResourcesTrendsV2Output = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetResourcesTrendsV2Output, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
