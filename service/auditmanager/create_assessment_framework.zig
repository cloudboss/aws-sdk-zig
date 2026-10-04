const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const CreateAssessmentFrameworkControlSet = @import("create_assessment_framework_control_set.zig").CreateAssessmentFrameworkControlSet;
const Framework = @import("framework.zig").Framework;

pub const CreateAssessmentFrameworkInput = struct {
    /// The compliance type that the new custom framework supports, such as CIS or
    /// HIPAA.
    compliance_type: ?[]const u8 = null,

    /// The control sets that are associated with the framework.
    ///
    /// The `Controls` object returns a partial response when called through
    /// Framework
    /// APIs. For a complete `Controls` object, use `GetControl`.
    control_sets: []const CreateAssessmentFrameworkControlSet,

    /// An optional description for the new custom framework.
    description: ?[]const u8 = null,

    /// The name of the new custom framework.
    name: []const u8,

    /// The tags that are associated with the framework.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .compliance_type = "complianceType",
        .control_sets = "controlSets",
        .description = "description",
        .name = "name",
        .tags = "tags",
    };
};

pub const CreateAssessmentFrameworkOutput = struct {
    /// The new framework object that the `CreateAssessmentFramework` API returned.
    framework: ?Framework = null,

    pub const json_field_names = .{
        .framework = "framework",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateAssessmentFrameworkInput, options: CallOptions) !CreateAssessmentFrameworkOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateAssessmentFrameworkInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("auditmanager", "AuditManager", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/assessmentFrameworks";

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
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"tags\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateAssessmentFrameworkOutput {
    const result: CreateAssessmentFrameworkOutput = try aws.json.parseJsonObject(
        CreateAssessmentFrameworkOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
