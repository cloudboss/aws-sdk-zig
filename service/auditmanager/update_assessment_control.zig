const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ControlStatus = @import("control_status.zig").ControlStatus;
const AssessmentControl = @import("assessment_control.zig").AssessmentControl;

pub const UpdateAssessmentControlInput = struct {
    /// The unique identifier for the assessment.
    assessment_id: []const u8,

    /// The comment body text for the control.
    comment_body: ?[]const u8 = null,

    /// The unique identifier for the control.
    control_id: []const u8,

    /// The unique identifier for the control set.
    control_set_id: []const u8,

    /// The status of the control.
    control_status: ?ControlStatus = null,

    pub const json_field_names = .{
        .assessment_id = "assessmentId",
        .comment_body = "commentBody",
        .control_id = "controlId",
        .control_set_id = "controlSetId",
        .control_status = "controlStatus",
    };
};

pub const UpdateAssessmentControlOutput = struct {
    /// The name of the updated control set that the `UpdateAssessmentControl` API
    /// returned.
    control: ?AssessmentControl = null,

    pub const json_field_names = .{
        .control = "control",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateAssessmentControlInput, options: CallOptions) !UpdateAssessmentControlOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateAssessmentControlInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("auditmanager", "AuditManager", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/assessments/");
    try path_buf.appendSlice(allocator, input.assessment_id);
    try path_buf.appendSlice(allocator, "/controlSets/");
    try path_buf.appendSlice(allocator, input.control_set_id);
    try path_buf.appendSlice(allocator, "/controls/");
    try path_buf.appendSlice(allocator, input.control_id);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.comment_body) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"commentBody\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.control_status) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"controlStatus\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateAssessmentControlOutput {
    const result: UpdateAssessmentControlOutput = try aws.json.parseJsonObject(
        UpdateAssessmentControlOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
