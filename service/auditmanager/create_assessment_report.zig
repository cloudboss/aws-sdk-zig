const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AssessmentReport = @import("assessment_report.zig").AssessmentReport;

pub const CreateAssessmentReportInput = struct {
    /// The identifier for the assessment.
    assessment_id: []const u8,

    /// The description of the assessment report.
    description: ?[]const u8 = null,

    /// The name of the new assessment report.
    name: []const u8,

    /// A SQL statement that represents an evidence finder query.
    ///
    /// Provide this parameter when you want to generate an assessment report from
    /// the results
    /// of an evidence finder search query. When you use this parameter, Audit
    /// Manager
    /// generates a one-time report using only the evidence from the query output.
    /// This report does
    /// not include any assessment evidence that was manually [added to a report
    /// using the
    /// console](https://docs.aws.amazon.com/audit-manager/latest/userguide/generate-assessment-report.html#generate-assessment-report-include-evidence), or [associated with a report using the API](https://docs.aws.amazon.com/audit-manager/latest/APIReference/API_BatchAssociateAssessmentReportEvidence.html).
    ///
    /// To use this parameter, the
    /// [enablementStatus](https://docs.aws.amazon.com/audit-manager/latest/APIReference/API_EvidenceFinderEnablement.html#auditmanager-Type-EvidenceFinderEnablement-enablementStatus) of evidence finder must be `ENABLED`.
    ///
    /// For examples and help resolving `queryStatement` validation exceptions, see
    /// [Troubleshooting evidence finder
    /// issues](https://docs.aws.amazon.com/audit-manager/latest/userguide/evidence-finder-issues.html#querystatement-exceptions) in the
    /// *Audit Manager User Guide.*
    query_statement: ?[]const u8 = null,

    pub const json_field_names = .{
        .assessment_id = "assessmentId",
        .description = "description",
        .name = "name",
        .query_statement = "queryStatement",
    };
};

pub const CreateAssessmentReportOutput = struct {
    /// The new assessment report that the `CreateAssessmentReport` API returned.
    assessment_report: ?AssessmentReport = null,

    pub const json_field_names = .{
        .assessment_report = "assessmentReport",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateAssessmentReportInput, options: CallOptions) !CreateAssessmentReportOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "auditmanager", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateAssessmentReportInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("auditmanager", "AuditManager", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/assessments/");
    try path_buf.appendSlice(allocator, input.assessment_id);
    try path_buf.appendSlice(allocator, "/reports");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"description\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"name\":");
    try aws.json.writeValue(@TypeOf(input.name), input.name, allocator, &body_buf);
    has_prev = true;
    if (input.query_statement) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"queryStatement\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateAssessmentReportOutput {
    var result: CreateAssessmentReportOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateAssessmentReportOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
