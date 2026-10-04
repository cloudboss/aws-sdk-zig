const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Evidence = @import("evidence.zig").Evidence;

pub const GetEvidenceInput = struct {
    /// The unique identifier for the assessment.
    assessment_id: []const u8,

    /// The unique identifier for the control set.
    control_set_id: []const u8,

    /// The unique identifier for the folder that the evidence is stored in.
    evidence_folder_id: []const u8,

    /// The unique identifier for the evidence.
    evidence_id: []const u8,

    pub const json_field_names = .{
        .assessment_id = "assessmentId",
        .control_set_id = "controlSetId",
        .evidence_folder_id = "evidenceFolderId",
        .evidence_id = "evidenceId",
    };
};

pub const GetEvidenceOutput = struct {
    /// The evidence that the `GetEvidence` API returned.
    evidence: ?Evidence = null,

    pub const json_field_names = .{
        .evidence = "evidence",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetEvidenceInput, options: CallOptions) !GetEvidenceOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetEvidenceInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("auditmanager", "AuditManager", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/assessments/");
    try path_buf.appendSlice(allocator, input.assessment_id);
    try path_buf.appendSlice(allocator, "/controlSets/");
    try path_buf.appendSlice(allocator, input.control_set_id);
    try path_buf.appendSlice(allocator, "/evidenceFolders/");
    try path_buf.appendSlice(allocator, input.evidence_folder_id);
    try path_buf.appendSlice(allocator, "/evidence/");
    try path_buf.appendSlice(allocator, input.evidence_id);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetEvidenceOutput {
    var result: GetEvidenceOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetEvidenceOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
