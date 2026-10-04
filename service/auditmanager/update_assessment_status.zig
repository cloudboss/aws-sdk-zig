const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AssessmentStatus = @import("assessment_status.zig").AssessmentStatus;
const Assessment = @import("assessment.zig").Assessment;

pub const UpdateAssessmentStatusInput = struct {
    /// The unique identifier for the assessment.
    assessment_id: []const u8,

    /// The current status of the assessment.
    status: AssessmentStatus,

    pub const json_field_names = .{
        .assessment_id = "assessmentId",
        .status = "status",
    };
};

pub const UpdateAssessmentStatusOutput = struct {
    /// The name of the updated assessment that the `UpdateAssessmentStatus` API
    /// returned.
    assessment: ?Assessment = null,

    pub const json_field_names = .{
        .assessment = "assessment",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateAssessmentStatusInput, options: CallOptions) !UpdateAssessmentStatusOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateAssessmentStatusInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("auditmanager", "AuditManager", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/assessments/");
    try path_buf.appendSlice(allocator, input.assessment_id);
    try path_buf.appendSlice(allocator, "/status");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"status\":");
    try aws.json.writeValue(@TypeOf(input.status), input.status, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateAssessmentStatusOutput {
    const result: UpdateAssessmentStatusOutput = try aws.json.parseJsonObject(
        UpdateAssessmentStatusOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
