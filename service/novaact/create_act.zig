const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ToolSpec = @import("tool_spec.zig").ToolSpec;
const ActStatus = @import("act_status.zig").ActStatus;

pub const CreateActInput = struct {
    /// A unique, case-sensitive identifier that you provide to ensure the
    /// idempotency of the request.
    client_token: ?[]const u8 = null,

    /// The unique identifier of the session to create the act in.
    session_id: []const u8,

    /// The task description that defines what the act should accomplish.
    task: []const u8,

    /// A list of tool specifications that the act can invoke to complete its task.
    tool_specs: ?[]const ToolSpec = null,

    /// The name of the workflow definition containing the session.
    workflow_definition_name: []const u8,

    /// The unique identifier of the workflow run containing the session.
    workflow_run_id: []const u8,

    pub const json_field_names = .{
        .client_token = "clientToken",
        .session_id = "sessionId",
        .task = "task",
        .tool_specs = "toolSpecs",
        .workflow_definition_name = "workflowDefinitionName",
        .workflow_run_id = "workflowRunId",
    };
};

pub const CreateActOutput = struct {
    /// The unique identifier for the created act.
    act_id: []const u8,

    /// The initial status of the act after creation.
    status: ActStatus,

    pub const json_field_names = .{
        .act_id = "actId",
        .status = "status",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateActInput, options: CallOptions) !CreateActOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "nova-act", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateActInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("nova-act", "Nova Act", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/workflow-definitions/");
    try path_buf.appendSlice(allocator, input.workflow_definition_name);
    try path_buf.appendSlice(allocator, "/workflow-runs/");
    try path_buf.appendSlice(allocator, input.workflow_run_id);
    try path_buf.appendSlice(allocator, "/sessions/");
    try path_buf.appendSlice(allocator, input.session_id);
    try path_buf.appendSlice(allocator, "/acts");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.client_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"clientToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"task\":");
    try aws.json.writeValue(@TypeOf(input.task), input.task, allocator, &body_buf);
    has_prev = true;
    if (input.tool_specs) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"toolSpecs\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateActOutput {
    const result: CreateActOutput = try aws.json.parseJsonObject(
        CreateActOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
