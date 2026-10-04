const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AssessmentReportType = @import("assessment_report_type.zig").AssessmentReportType;
const ExportMetadataModelAssessmentResultEntry = @import("export_metadata_model_assessment_result_entry.zig").ExportMetadataModelAssessmentResultEntry;

pub const ExportMetadataModelAssessmentInput = struct {
    /// The file format of the assessment file.
    assessment_report_types: ?[]const AssessmentReportType = null,

    /// The name of the assessment file to create in your Amazon S3 bucket.
    file_name: ?[]const u8 = null,

    /// The migration project name or Amazon Resource Name (ARN).
    migration_project_identifier: []const u8,

    /// A value that specifies the database objects to assess.
    selection_rules: []const u8,

    pub const json_field_names = .{
        .assessment_report_types = "AssessmentReportTypes",
        .file_name = "FileName",
        .migration_project_identifier = "MigrationProjectIdentifier",
        .selection_rules = "SelectionRules",
    };
};

pub const ExportMetadataModelAssessmentOutput = struct {
    /// The Amazon S3 details for an assessment exported in CSV format.
    csv_report: ?ExportMetadataModelAssessmentResultEntry = null,

    /// The Amazon S3 details for an assessment exported in PDF format.
    pdf_report: ?ExportMetadataModelAssessmentResultEntry = null,

    pub const json_field_names = .{
        .csv_report = "CsvReport",
        .pdf_report = "PdfReport",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ExportMetadataModelAssessmentInput, options: CallOptions) !ExportMetadataModelAssessmentOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "dms", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ExportMetadataModelAssessmentInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("dms", "Database Migration Service", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AmazonDMSv20160101.ExportMetadataModelAssessment");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ExportMetadataModelAssessmentOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ExportMetadataModelAssessmentOutput, body, allocator);
}
