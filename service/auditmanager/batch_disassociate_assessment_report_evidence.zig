const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AssessmentReportEvidenceError = @import("assessment_report_evidence_error.zig").AssessmentReportEvidenceError;

pub const BatchDisassociateAssessmentReportEvidenceInput = struct {
    /// The identifier for the assessment.
    assessment_id: []const u8,

    /// The identifier for the folder that the evidence is stored in.
    evidence_folder_id: []const u8,

    /// The list of evidence identifiers.
    evidence_ids: []const []const u8,

    pub const json_field_names = .{
        .assessment_id = "assessmentId",
        .evidence_folder_id = "evidenceFolderId",
        .evidence_ids = "evidenceIds",
    };
};

pub const BatchDisassociateAssessmentReportEvidenceOutput = struct {
    /// A list of errors that the `BatchDisassociateAssessmentReportEvidence` API
    /// returned.
    errors: ?[]const AssessmentReportEvidenceError = null,

    /// The identifier for the evidence.
    evidence_ids: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .errors = "errors",
        .evidence_ids = "evidenceIds",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: BatchDisassociateAssessmentReportEvidenceInput, options: CallOptions) !BatchDisassociateAssessmentReportEvidenceOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: BatchDisassociateAssessmentReportEvidenceInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("auditmanager", "AuditManager", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/assessments/");
    try path_buf.appendSlice(allocator, input.assessment_id);
    try path_buf.appendSlice(allocator, "/batchDisassociateFromAssessmentReport");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"evidenceFolderId\":");
    try aws.json.writeValue(@TypeOf(input.evidence_folder_id), input.evidence_folder_id, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"evidenceIds\":");
    try aws.json.writeValue(@TypeOf(input.evidence_ids), input.evidence_ids, allocator, &body_buf);
    has_prev = true;

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .PUT;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !BatchDisassociateAssessmentReportEvidenceOutput {
    const result: BatchDisassociateAssessmentReportEvidenceOutput = try aws.json.parseJsonObject(
        BatchDisassociateAssessmentReportEvidenceOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
