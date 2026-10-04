const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ControlSetStatus = @import("control_set_status.zig").ControlSetStatus;
const AssessmentControlSet = @import("assessment_control_set.zig").AssessmentControlSet;

pub const UpdateAssessmentControlSetStatusInput = struct {
    /// The unique identifier for the assessment.
    assessment_id: []const u8,

    /// The comment that's related to the status update.
    comment: []const u8,

    /// The unique identifier for the control set.
    control_set_id: []const u8,

    /// The status of the control set that's being updated.
    status: ControlSetStatus,

    pub const json_field_names = .{
        .assessment_id = "assessmentId",
        .comment = "comment",
        .control_set_id = "controlSetId",
        .status = "status",
    };
};

pub const UpdateAssessmentControlSetStatusOutput = struct {
    /// The name of the updated control set that the
    /// `UpdateAssessmentControlSetStatus` API returned.
    control_set: ?AssessmentControlSet = null,

    pub const json_field_names = .{
        .control_set = "controlSet",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateAssessmentControlSetStatusInput, options: CallOptions) !UpdateAssessmentControlSetStatusOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateAssessmentControlSetStatusInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("auditmanager", "AuditManager", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/assessments/");
    try path_buf.appendSlice(allocator, input.assessment_id);
    try path_buf.appendSlice(allocator, "/controlSets/");
    try path_buf.appendSlice(allocator, input.control_set_id);
    try path_buf.appendSlice(allocator, "/status");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"comment\":");
    try aws.json.writeValue(@TypeOf(input.comment), input.comment, allocator, &body_buf);
    has_prev = true;
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateAssessmentControlSetStatusOutput {
    const result: UpdateAssessmentControlSetStatusOutput = try aws.json.parseJsonObject(
        UpdateAssessmentControlSetStatusOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
