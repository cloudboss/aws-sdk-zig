const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const WorkflowStepOutput = @import("workflow_step_output.zig").WorkflowStepOutput;
const StepStatus = @import("step_status.zig").StepStatus;
const StepActionType = @import("step_action_type.zig").StepActionType;
const WorkflowStepAutomationConfiguration = @import("workflow_step_automation_configuration.zig").WorkflowStepAutomationConfiguration;

pub const UpdateWorkflowStepInput = struct {
    /// The description of the step.
    description: ?[]const u8 = null,

    /// The ID of the step.
    id: []const u8,

    /// The name of the step.
    name: ?[]const u8 = null,

    /// The next step.
    next: ?[]const []const u8 = null,

    /// The outputs of a step.
    outputs: ?[]const WorkflowStepOutput = null,

    /// The previous step.
    previous: ?[]const []const u8 = null,

    /// The status of the step.
    status: ?StepStatus = null,

    /// The action type of the step. You must run and update the status of a manual
    /// step for
    /// the workflow to continue after the completion of the step.
    step_action_type: ?StepActionType = null,

    /// The ID of the step group.
    step_group_id: []const u8,

    /// The servers on which a step will be run.
    step_target: ?[]const []const u8 = null,

    /// The ID of the migration workflow.
    workflow_id: []const u8,

    /// The custom script to run tests on the source and target environments.
    workflow_step_automation_configuration: ?WorkflowStepAutomationConfiguration = null,

    pub const json_field_names = .{
        .description = "description",
        .id = "id",
        .name = "name",
        .next = "next",
        .outputs = "outputs",
        .previous = "previous",
        .status = "status",
        .step_action_type = "stepActionType",
        .step_group_id = "stepGroupId",
        .step_target = "stepTarget",
        .workflow_id = "workflowId",
        .workflow_step_automation_configuration = "workflowStepAutomationConfiguration",
    };
};

pub const UpdateWorkflowStepOutput = struct {
    /// The ID of the step.
    id: ?[]const u8 = null,

    /// The name of the step.
    name: ?[]const u8 = null,

    /// The ID of the step group.
    step_group_id: ?[]const u8 = null,

    /// The ID of the migration workflow.
    workflow_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .id = "id",
        .name = "name",
        .step_group_id = "stepGroupId",
        .workflow_id = "workflowId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateWorkflowStepInput, options: CallOptions) !UpdateWorkflowStepOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateWorkflowStepInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("migrationhub-orchestrator", "MigrationHubOrchestrator", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/workflowstep/");
    try path_buf.appendSlice(allocator, input.id);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"description\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.name) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"name\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.next) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"next\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.outputs) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"outputs\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.previous) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"previous\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.status) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"status\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.step_action_type) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"stepActionType\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"stepGroupId\":");
    try aws.json.writeValue(@TypeOf(input.step_group_id), input.step_group_id, allocator, &body_buf);
    has_prev = true;
    if (input.step_target) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"stepTarget\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"workflowId\":");
    try aws.json.writeValue(@TypeOf(input.workflow_id), input.workflow_id, allocator, &body_buf);
    has_prev = true;
    if (input.workflow_step_automation_configuration) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"workflowStepAutomationConfiguration\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateWorkflowStepOutput {
    const result: UpdateWorkflowStepOutput = try aws.json.parseJsonObject(
        UpdateWorkflowStepOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
