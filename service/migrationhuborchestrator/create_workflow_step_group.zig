const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Tool = @import("tool.zig").Tool;

pub const CreateWorkflowStepGroupInput = struct {
    /// The description of the step group.
    description: ?[]const u8 = null,

    /// The name of the step group.
    name: []const u8,

    /// The next step group.
    next: ?[]const []const u8 = null,

    /// The previous step group.
    previous: ?[]const []const u8 = null,

    /// The ID of the migration workflow that will contain the step group.
    workflow_id: []const u8,

    pub const json_field_names = .{
        .description = "description",
        .name = "name",
        .next = "next",
        .previous = "previous",
        .workflow_id = "workflowId",
    };
};

pub const CreateWorkflowStepGroupOutput = struct {
    /// The time at which the step group is created.
    creation_time: ?i64 = null,

    /// The description of the step group.
    description: ?[]const u8 = null,

    /// The ID of the step group.
    id: ?[]const u8 = null,

    /// The name of the step group.
    name: ?[]const u8 = null,

    /// The next step group.
    next: ?[]const []const u8 = null,

    /// The previous step group.
    previous: ?[]const []const u8 = null,

    /// List of AWS services utilized in a migration workflow.
    tools: ?[]const Tool = null,

    /// The ID of the migration workflow that contains the step group.
    workflow_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .creation_time = "creationTime",
        .description = "description",
        .id = "id",
        .name = "name",
        .next = "next",
        .previous = "previous",
        .tools = "tools",
        .workflow_id = "workflowId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateWorkflowStepGroupInput, options: CallOptions) !CreateWorkflowStepGroupOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "migrationhub-orchestrator", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateWorkflowStepGroupInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("migrationhub-orchestrator", "MigrationHubOrchestrator", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/workflowstepgroups";

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
    if (input.next) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"next\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.previous) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"previous\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"workflowId\":");
    try aws.json.writeValue(@TypeOf(input.workflow_id), input.workflow_id, allocator, &body_buf);
    has_prev = true;

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateWorkflowStepGroupOutput {
    const result: CreateWorkflowStepGroupOutput = try aws.json.parseJsonObject(
        CreateWorkflowStepGroupOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
