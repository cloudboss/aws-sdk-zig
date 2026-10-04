const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ReportGroupTrendFieldType = @import("report_group_trend_field_type.zig").ReportGroupTrendFieldType;
const ReportWithRawData = @import("report_with_raw_data.zig").ReportWithRawData;
const ReportGroupTrendStats = @import("report_group_trend_stats.zig").ReportGroupTrendStats;

pub const GetReportGroupTrendInput = struct {
    /// The number of reports to analyze. This operation always retrieves the most
    /// recent
    /// reports.
    ///
    /// If this parameter is omitted, the most recent 100 reports are analyzed.
    num_of_reports: ?i32 = null,

    /// The ARN of the report group that contains the reports to analyze.
    report_group_arn: []const u8,

    /// The test report value to accumulate. This must be one of the following
    /// values:
    ///
    /// **Test reports:**
    ///
    /// **DURATION**
    ///
    /// Accumulate the test run times for the specified
    /// reports.
    ///
    /// **PASS_RATE**
    ///
    /// Accumulate the percentage of tests that passed for the
    /// specified test reports.
    ///
    /// **TOTAL**
    ///
    /// Accumulate the total number of tests for the specified test
    /// reports.
    ///
    /// **Code coverage reports:**
    ///
    /// **BRANCH_COVERAGE**
    ///
    /// Accumulate the branch coverage percentages for the specified
    /// test reports.
    ///
    /// **BRANCHES_COVERED**
    ///
    /// Accumulate the branches covered values for the specified test
    /// reports.
    ///
    /// **BRANCHES_MISSED**
    ///
    /// Accumulate the branches missed values for the specified test
    /// reports.
    ///
    /// **LINE_COVERAGE**
    ///
    /// Accumulate the line coverage percentages for the specified
    /// test reports.
    ///
    /// **LINES_COVERED**
    ///
    /// Accumulate the lines covered values for the specified test
    /// reports.
    ///
    /// **LINES_MISSED**
    ///
    /// Accumulate the lines not covered values for the specified test
    /// reports.
    trend_field: ReportGroupTrendFieldType,

    pub const json_field_names = .{
        .num_of_reports = "numOfReports",
        .report_group_arn = "reportGroupArn",
        .trend_field = "trendField",
    };
};

pub const GetReportGroupTrendOutput = struct {
    /// An array that contains the raw data for each report.
    raw_data: ?[]const ReportWithRawData = null,

    /// Contains the accumulated trend data.
    stats: ?ReportGroupTrendStats = null,

    pub const json_field_names = .{
        .raw_data = "rawData",
        .stats = "stats",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetReportGroupTrendInput, options: CallOptions) !GetReportGroupTrendOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "codebuild", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetReportGroupTrendInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("codebuild", "CodeBuild", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "CodeBuild_20161006.GetReportGroupTrend");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetReportGroupTrendOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GetReportGroupTrendOutput, body, allocator);
}
