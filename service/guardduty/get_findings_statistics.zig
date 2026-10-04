const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const FindingCriteria = @import("finding_criteria.zig").FindingCriteria;
const FindingStatisticType = @import("finding_statistic_type.zig").FindingStatisticType;
const GroupByType = @import("group_by_type.zig").GroupByType;
const OrderBy = @import("order_by.zig").OrderBy;
const FindingStatistics = @import("finding_statistics.zig").FindingStatistics;

pub const GetFindingsStatisticsInput = struct {
    /// The ID of the detector whose findings statistics you want to retrieve.
    ///
    /// To find the `detectorId` in the current Region, see the Settings page in the
    /// GuardDuty console, or run the
    /// [ListDetectors](https://docs.aws.amazon.com/guardduty/latest/APIReference/API_ListDetectors.html) API.
    detector_id: []const u8,

    /// Represents the criteria that is used for querying findings.
    finding_criteria: ?FindingCriteria = null,

    /// The types of finding statistics to retrieve.
    finding_statistic_types: ?[]const FindingStatisticType = null,

    /// Displays the findings statistics grouped by one of the listed valid values.
    group_by: ?GroupByType = null,

    /// The maximum number of results to be returned in the response. The default
    /// value is 25.
    ///
    /// You can use this parameter only with the `groupBy` parameter.
    max_results: ?i32 = null,

    /// Displays the sorted findings in the requested order. The default value of
    /// `orderBy` is `DESC`.
    ///
    /// You can use this parameter only with the `groupBy` parameter.
    order_by: ?OrderBy = null,

    pub const json_field_names = .{
        .detector_id = "DetectorId",
        .finding_criteria = "FindingCriteria",
        .finding_statistic_types = "FindingStatisticTypes",
        .group_by = "GroupBy",
        .max_results = "MaxResults",
        .order_by = "OrderBy",
    };
};

pub const GetFindingsStatisticsOutput = struct {
    /// The finding statistics object.
    finding_statistics: ?FindingStatistics = null,

    /// The pagination parameter to be used on the next list operation to retrieve
    /// more items.
    ///
    /// This parameter is currently not supported.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .finding_statistics = "FindingStatistics",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetFindingsStatisticsInput, options: CallOptions) !GetFindingsStatisticsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "guardduty", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetFindingsStatisticsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("guardduty", "GuardDuty", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/detector/");
    try path_buf.appendSlice(allocator, input.detector_id);
    try path_buf.appendSlice(allocator, "/findings/statistics");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.finding_criteria) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"FindingCriteria\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.finding_statistic_types) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"FindingStatisticTypes\":");
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
    if (input.order_by) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"OrderBy\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetFindingsStatisticsOutput {
    const result: GetFindingsStatisticsOutput = try aws.json.parseJsonObject(
        GetFindingsStatisticsOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
