const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const UpdateAssessmentFrameworkControlSet = @import("update_assessment_framework_control_set.zig").UpdateAssessmentFrameworkControlSet;
const Framework = @import("framework.zig").Framework;

pub const UpdateAssessmentFrameworkInput = struct {
    /// The compliance type that the new custom framework supports, such as CIS or
    /// HIPAA.
    compliance_type: ?[]const u8 = null,

    /// The control sets that are associated with the framework.
    ///
    /// The `Controls` object returns a partial response when called through
    /// Framework
    /// APIs. For a complete `Controls` object, use `GetControl`.
    control_sets: []const UpdateAssessmentFrameworkControlSet,

    /// The description of the updated framework.
    description: ?[]const u8 = null,

    /// The unique identifier for the framework.
    framework_id: []const u8,

    /// The name of the framework to be updated.
    name: []const u8,

    pub const json_field_names = .{
        .compliance_type = "complianceType",
        .control_sets = "controlSets",
        .description = "description",
        .framework_id = "frameworkId",
        .name = "name",
    };
};

pub const UpdateAssessmentFrameworkOutput = struct {
    /// The framework object.
    framework: ?Framework = null,

    pub const json_field_names = .{
        .framework = "framework",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateAssessmentFrameworkInput, options: CallOptions) !UpdateAssessmentFrameworkOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateAssessmentFrameworkInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("auditmanager", "AuditManager", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/assessmentFrameworks/");
    try path_buf.appendSlice(allocator, input.framework_id);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.compliance_type) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"complianceType\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"controlSets\":");
    try aws.json.writeValue(@TypeOf(input.control_sets), input.control_sets, allocator, &body_buf);
    has_prev = true;
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateAssessmentFrameworkOutput {
    var result: UpdateAssessmentFrameworkOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(UpdateAssessmentFrameworkOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
