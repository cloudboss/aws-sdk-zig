const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AssessmentReportsDestination = @import("assessment_reports_destination.zig").AssessmentReportsDestination;
const Role = @import("role.zig").Role;
const Scope = @import("scope.zig").Scope;
const Assessment = @import("assessment.zig").Assessment;

pub const UpdateAssessmentInput = struct {
    /// The description of the assessment.
    assessment_description: ?[]const u8 = null,

    /// The unique identifier for the assessment.
    assessment_id: []const u8,

    /// The name of the assessment to be updated.
    assessment_name: ?[]const u8 = null,

    /// The assessment report storage destination for the assessment that's being
    /// updated.
    assessment_reports_destination: ?AssessmentReportsDestination = null,

    /// The list of roles for the assessment.
    roles: ?[]const Role = null,

    /// The scope of the assessment.
    scope: Scope,

    pub const json_field_names = .{
        .assessment_description = "assessmentDescription",
        .assessment_id = "assessmentId",
        .assessment_name = "assessmentName",
        .assessment_reports_destination = "assessmentReportsDestination",
        .roles = "roles",
        .scope = "scope",
    };
};

pub const UpdateAssessmentOutput = struct {
    /// The response object for the `UpdateAssessment` API. This is the name of the
    /// updated assessment.
    assessment: ?Assessment = null,

    pub const json_field_names = .{
        .assessment = "assessment",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateAssessmentInput, options: CallOptions) !UpdateAssessmentOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateAssessmentInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("auditmanager", "AuditManager", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/assessments/");
    try path_buf.appendSlice(allocator, input.assessment_id);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.assessment_description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"assessmentDescription\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.assessment_name) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"assessmentName\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.assessment_reports_destination) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"assessmentReportsDestination\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.roles) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"roles\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"scope\":");
    try aws.json.writeValue(@TypeOf(input.scope), input.scope, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateAssessmentOutput {
    var result: UpdateAssessmentOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(UpdateAssessmentOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
