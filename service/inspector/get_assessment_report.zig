const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ReportFileFormat = @import("report_file_format.zig").ReportFileFormat;
const ReportType = @import("report_type.zig").ReportType;
const ReportStatus = @import("report_status.zig").ReportStatus;

pub const GetAssessmentReportInput = struct {
    /// The ARN that specifies the assessment run for which you want to generate a
    /// report.
    assessment_run_arn: []const u8,

    /// Specifies the file format (html or pdf) of the assessment report that you
    /// want to
    /// generate.
    report_file_format: ReportFileFormat,

    /// Specifies the type of the assessment report that you want to generate. There
    /// are two
    /// types of assessment reports: a finding report and a full report. For more
    /// information, see
    /// [Assessment
    /// Reports](https://docs.aws.amazon.com/inspector/latest/userguide/inspector_reports.html).
    report_type: ReportType,

    pub const json_field_names = .{
        .assessment_run_arn = "assessmentRunArn",
        .report_file_format = "reportFileFormat",
        .report_type = "reportType",
    };
};

pub const GetAssessmentReportOutput = struct {
    /// Specifies the status of the request to generate an assessment report.
    status: ReportStatus,

    /// Specifies the URL where you can find the generated assessment report. This
    /// parameter
    /// is only returned if the report is successfully generated.
    url: ?[]const u8 = null,

    pub const json_field_names = .{
        .status = "status",
        .url = "url",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetAssessmentReportInput, options: CallOptions) !GetAssessmentReportOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "inspector", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetAssessmentReportInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("inspector", "Inspector", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "InspectorService.GetAssessmentReport");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetAssessmentReportOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(GetAssessmentReportOutput, body, allocator);
}
