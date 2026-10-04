const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ControlMappingSource = @import("control_mapping_source.zig").ControlMappingSource;
const Control = @import("control.zig").Control;

pub const UpdateControlInput = struct {
    /// The recommended actions to carry out if the control isn't fulfilled.
    action_plan_instructions: ?[]const u8 = null,

    /// The title of the action plan for remediating the control.
    action_plan_title: ?[]const u8 = null,

    /// The identifier for the control.
    control_id: []const u8,

    /// The data mapping sources for the control.
    control_mapping_sources: []const ControlMappingSource,

    /// The optional description of the control.
    description: ?[]const u8 = null,

    /// The name of the updated control.
    name: []const u8,

    /// The steps that you should follow to determine if the control is met.
    testing_information: ?[]const u8 = null,

    pub const json_field_names = .{
        .action_plan_instructions = "actionPlanInstructions",
        .action_plan_title = "actionPlanTitle",
        .control_id = "controlId",
        .control_mapping_sources = "controlMappingSources",
        .description = "description",
        .name = "name",
        .testing_information = "testingInformation",
    };
};

pub const UpdateControlOutput = struct {
    /// The name of the updated control set that the `UpdateControl` API returned.
    control: ?Control = null,

    pub const json_field_names = .{
        .control = "control",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateControlInput, options: CallOptions) !UpdateControlOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateControlInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("auditmanager", "AuditManager", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/controls/");
    try path_buf.appendSlice(allocator, input.control_id);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.action_plan_instructions) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"actionPlanInstructions\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.action_plan_title) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"actionPlanTitle\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"controlMappingSources\":");
    try aws.json.writeValue(@TypeOf(input.control_mapping_sources), input.control_mapping_sources, allocator, &body_buf);
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
    if (input.testing_information) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"testingInformation\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateControlOutput {
    const result: UpdateControlOutput = try aws.json.parseJsonObject(
        UpdateControlOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
