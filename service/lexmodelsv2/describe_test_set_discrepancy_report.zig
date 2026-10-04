const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const TestSetDiscrepancyReportResourceTarget = @import("test_set_discrepancy_report_resource_target.zig").TestSetDiscrepancyReportResourceTarget;
const TestSetDiscrepancyReportStatus = @import("test_set_discrepancy_report_status.zig").TestSetDiscrepancyReportStatus;
const TestSetDiscrepancyErrors = @import("test_set_discrepancy_errors.zig").TestSetDiscrepancyErrors;

pub const DescribeTestSetDiscrepancyReportInput = struct {
    /// The unique identifier of the test set discrepancy report.
    test_set_discrepancy_report_id: []const u8,

    pub const json_field_names = .{
        .test_set_discrepancy_report_id = "testSetDiscrepancyReportId",
    };
};

pub const DescribeTestSetDiscrepancyReportOutput = struct {
    /// The time and date of creation for the test set discrepancy report.
    creation_date_time: ?i64 = null,

    /// The failure report for the test set discrepancy report generation action.
    failure_reasons: ?[]const []const u8 = null,

    /// The date and time of the last update for the test set discrepancy report.
    last_updated_data_time: ?i64 = null,

    /// The target bot location for the test set discrepancy report.
    target: ?TestSetDiscrepancyReportResourceTarget = null,

    /// Pre-signed Amazon S3 URL to download the test set discrepancy report.
    test_set_discrepancy_raw_output_url: ?[]const u8 = null,

    /// The unique identifier of the test set discrepancy report to describe.
    test_set_discrepancy_report_id: ?[]const u8 = null,

    /// The status for the test set discrepancy report.
    test_set_discrepancy_report_status: ?TestSetDiscrepancyReportStatus = null,

    /// The top 200 error results from the test set discrepancy report.
    test_set_discrepancy_top_errors: ?TestSetDiscrepancyErrors = null,

    /// The test set Id for the test set discrepancy report.
    test_set_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .creation_date_time = "creationDateTime",
        .failure_reasons = "failureReasons",
        .last_updated_data_time = "lastUpdatedDataTime",
        .target = "target",
        .test_set_discrepancy_raw_output_url = "testSetDiscrepancyRawOutputUrl",
        .test_set_discrepancy_report_id = "testSetDiscrepancyReportId",
        .test_set_discrepancy_report_status = "testSetDiscrepancyReportStatus",
        .test_set_discrepancy_top_errors = "testSetDiscrepancyTopErrors",
        .test_set_id = "testSetId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeTestSetDiscrepancyReportInput, options: CallOptions) !DescribeTestSetDiscrepancyReportOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "lex", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeTestSetDiscrepancyReportInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("models-v2-lex", "Lex Models V2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/testsetdiscrepancy/");
    try path_buf.appendSlice(allocator, input.test_set_discrepancy_report_id);
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeTestSetDiscrepancyReportOutput {
    const result: DescribeTestSetDiscrepancyReportOutput = try aws.json.parseJsonObject(
        DescribeTestSetDiscrepancyReportOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
