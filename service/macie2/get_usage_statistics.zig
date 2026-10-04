const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const UsageStatisticsFilter = @import("usage_statistics_filter.zig").UsageStatisticsFilter;
const UsageStatisticsSortBy = @import("usage_statistics_sort_by.zig").UsageStatisticsSortBy;
const TimeRange = @import("time_range.zig").TimeRange;
const UsageRecord = @import("usage_record.zig").UsageRecord;

pub const GetUsageStatisticsInput = struct {
    /// An array of objects, one for each condition to use to filter the query
    /// results. If you specify more than one condition, Amazon Macie uses an AND
    /// operator to join the conditions.
    filter_by: ?[]const UsageStatisticsFilter = null,

    /// The maximum number of items to include in each page of the response.
    max_results: ?i32 = null,

    /// The nextToken string that specifies which page of results to return in a
    /// paginated response.
    next_token: ?[]const u8 = null,

    /// The criteria to use to sort the query results.
    sort_by: ?UsageStatisticsSortBy = null,

    /// The inclusive time period to query usage data for. Valid values are:
    /// MONTH_TO_DATE, for the current calendar month to date; and, PAST_30_DAYS,
    /// for the preceding 30 days. If you don't specify a value, Amazon Macie
    /// provides usage data for the preceding 30 days.
    time_range: ?TimeRange = null,

    pub const json_field_names = .{
        .filter_by = "filterBy",
        .max_results = "maxResults",
        .next_token = "nextToken",
        .sort_by = "sortBy",
        .time_range = "timeRange",
    };
};

pub const GetUsageStatisticsOutput = struct {
    /// The string to use in a subsequent request to get the next page of results in
    /// a paginated response. This value is null if there are no additional pages.
    next_token: ?[]const u8 = null,

    /// An array of objects that contains the results of the query. Each object
    /// contains the data for an account that matches the filter criteria specified
    /// in the request.
    records: ?[]const UsageRecord = null,

    /// The inclusive time period that the usage data applies to. Possible values
    /// are: MONTH_TO_DATE, for the current calendar month to date; and,
    /// PAST_30_DAYS, for the preceding 30 days.
    time_range: ?TimeRange = null,

    pub const json_field_names = .{
        .next_token = "nextToken",
        .records = "records",
        .time_range = "timeRange",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetUsageStatisticsInput, options: CallOptions) !GetUsageStatisticsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "macie2", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetUsageStatisticsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("macie2", "Macie2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/usage/statistics";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.filter_by) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"filterBy\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.max_results) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"maxResults\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.next_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"nextToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.sort_by) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"sortBy\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.time_range) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"timeRange\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetUsageStatisticsOutput {
    var result: GetUsageStatisticsOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetUsageStatisticsOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
