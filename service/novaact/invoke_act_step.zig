const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const CallResult = @import("call_result.zig").CallResult;
const Call = @import("call.zig").Call;

pub const InvokeActStepInput = struct {
    /// The unique identifier of the act to invoke the next step for.
    act_id: []const u8,

    /// The results from previous tool calls that the act requested.
    call_results: []const CallResult,

    /// The identifier of the previous step, used for tracking execution flow.
    previous_step_id: ?[]const u8 = null,

    /// The unique identifier of the session containing the act.
    session_id: []const u8,

    /// The name of the workflow definition containing the act.
    workflow_definition_name: []const u8,

    /// The unique identifier of the workflow run containing the act.
    workflow_run_id: []const u8,

    pub const json_field_names = .{
        .act_id = "actId",
        .call_results = "callResults",
        .previous_step_id = "previousStepId",
        .session_id = "sessionId",
        .workflow_definition_name = "workflowDefinitionName",
        .workflow_run_id = "workflowRunId",
    };
};

pub const InvokeActStepOutput = struct {
    /// A list of tool calls that the act wants to execute in this step.
    calls: ?[]const Call = null,

    /// The unique identifier for this execution step.
    step_id: []const u8,

    pub const json_field_names = .{
        .calls = "calls",
        .step_id = "stepId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: InvokeActStepInput, options: CallOptions) !InvokeActStepOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: InvokeActStepInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("nova-act", "Nova Act", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/workflow-definitions/");
    try path_buf.appendSlice(allocator, input.workflow_definition_name);
    try path_buf.appendSlice(allocator, "/workflow-runs/");
    try path_buf.appendSlice(allocator, input.workflow_run_id);
    try path_buf.appendSlice(allocator, "/sessions/");
    try path_buf.appendSlice(allocator, input.session_id);
    try path_buf.appendSlice(allocator, "/acts/");
    try path_buf.appendSlice(allocator, input.act_id);
    try path_buf.appendSlice(allocator, "/invoke-step/");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"callResults\":");
    try aws.json.writeValue(@TypeOf(input.call_results), input.call_results, allocator, &body_buf);
    has_prev = true;
    if (input.previous_step_id) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"previousStepId\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !InvokeActStepOutput {
    var result: InvokeActStepOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(InvokeActStepOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
