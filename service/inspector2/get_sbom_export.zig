const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ReportingErrorCode = @import("reporting_error_code.zig").ReportingErrorCode;
const ResourceFilterCriteria = @import("resource_filter_criteria.zig").ResourceFilterCriteria;
const SbomReportFormat = @import("sbom_report_format.zig").SbomReportFormat;
const Destination = @import("destination.zig").Destination;
const ExternalReportStatus = @import("external_report_status.zig").ExternalReportStatus;

pub const GetSbomExportInput = struct {
    /// The report ID of the SBOM export to get details for.
    report_id: []const u8,

    pub const json_field_names = .{
        .report_id = "reportId",
    };
};

pub const GetSbomExportOutput = struct {
    /// An error code.
    error_code: ?ReportingErrorCode = null,

    /// An error message.
    error_message: ?[]const u8 = null,

    /// Contains details about the resource filter criteria used for the software
    /// bill of
    /// materials (SBOM) report.
    filter_criteria: ?ResourceFilterCriteria = null,

    /// The format of the software bill of materials (SBOM) report.
    format: ?SbomReportFormat = null,

    /// The report ID of the software bill of materials (SBOM) report.
    report_id: ?[]const u8 = null,

    /// Contains details of the Amazon S3 bucket and KMS key used to export findings
    s_3_destination: ?Destination = null,

    /// The status of the software bill of materials (SBOM) report.
    status: ?ExternalReportStatus = null,

    pub const json_field_names = .{
        .error_code = "errorCode",
        .error_message = "errorMessage",
        .filter_criteria = "filterCriteria",
        .format = "format",
        .report_id = "reportId",
        .s_3_destination = "s3Destination",
        .status = "status",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetSbomExportInput, options: CallOptions) !GetSbomExportOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "inspector2", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetSbomExportInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("inspector2", "Inspector2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/sbomexport/get";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"reportId\":");
    try aws.json.writeValue(@TypeOf(input.report_id), input.report_id, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetSbomExportOutput {
    var result: GetSbomExportOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetSbomExportOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
