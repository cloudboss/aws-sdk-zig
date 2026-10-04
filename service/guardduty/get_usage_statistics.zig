const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const UsageCriteria = @import("usage_criteria.zig").UsageCriteria;
const UsageStatisticType = @import("usage_statistic_type.zig").UsageStatisticType;
const UsageStatistics = @import("usage_statistics.zig").UsageStatistics;

pub const GetUsageStatisticsInput = struct {
    /// The ID of the detector that specifies the GuardDuty service whose usage
    /// statistics you want to retrieve.
    ///
    /// To find the `detectorId` in the current Region, see the Settings page in the
    /// GuardDuty console, or run the
    /// [ListDetectors](https://docs.aws.amazon.com/guardduty/latest/APIReference/API_ListDetectors.html) API.
    detector_id: []const u8,

    /// The maximum number of results to return in the response.
    max_results: ?i32 = null,

    /// A token to use for paginating results that are returned in the response. Set
    /// the value of this parameter to null for the first request to a list action.
    /// For subsequent calls, use the NextToken value returned from the previous
    /// request to continue listing results after the first page.
    next_token: ?[]const u8 = null,

    /// The currency unit you would like to view your usage statistics in. Current
    /// valid values are USD.
    unit: ?[]const u8 = null,

    /// Represents the criteria used for querying usage.
    usage_criteria: UsageCriteria,

    /// The type of usage statistics to retrieve.
    usage_statistic_type: UsageStatisticType,

    pub const json_field_names = .{
        .detector_id = "DetectorId",
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .unit = "Unit",
        .usage_criteria = "UsageCriteria",
        .usage_statistic_type = "UsageStatisticType",
    };
};

pub const GetUsageStatisticsOutput = struct {
    /// The pagination parameter to be used on the next list operation to retrieve
    /// more items.
    next_token: ?[]const u8 = null,

    /// The usage statistics object. If a UsageStatisticType was provided, the
    /// objects representing other types will be null.
    usage_statistics: ?UsageStatistics = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .usage_statistics = "UsageStatistics",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetUsageStatisticsInput, options: CallOptions) !GetUsageStatisticsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetUsageStatisticsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("guardduty", "GuardDuty", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/detector/");
    try path_buf.appendSlice(allocator, input.detector_id);
    try path_buf.appendSlice(allocator, "/usage/statistics");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

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
    if (input.unit) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Unit\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"UsageCriteria\":");
    try aws.json.writeValue(@TypeOf(input.usage_criteria), input.usage_criteria, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"UsageStatisticType\":");
    try aws.json.writeValue(@TypeOf(input.usage_statistic_type), input.usage_statistic_type, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetUsageStatisticsOutput {
    const result: GetUsageStatisticsOutput = try aws.json.parseJsonObject(
        GetUsageStatisticsOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
