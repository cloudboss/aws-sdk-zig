const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const StepOutput = @import("step_output.zig").StepOutput;
const StepActionType = @import("step_action_type.zig").StepActionType;
const StepAutomationConfiguration = @import("step_automation_configuration.zig").StepAutomationConfiguration;

pub const GetTemplateStepInput = struct {
    /// The ID of the step.
    id: []const u8,

    /// The ID of the step group.
    step_group_id: []const u8,

    /// The ID of the template.
    template_id: []const u8,

    pub const json_field_names = .{
        .id = "id",
        .step_group_id = "stepGroupId",
        .template_id = "templateId",
    };
};

pub const GetTemplateStepOutput = struct {
    /// The time at which the step was created.
    creation_time: ?[]const u8 = null,

    /// The description of the step.
    description: ?[]const u8 = null,

    /// The ID of the step.
    id: ?[]const u8 = null,

    /// The name of the step.
    name: ?[]const u8 = null,

    /// The next step.
    next: ?[]const []const u8 = null,

    /// The outputs of the step.
    outputs: ?[]const StepOutput = null,

    /// The previous step.
    previous: ?[]const []const u8 = null,

    /// The action type of the step. You must run and update the status of a manual
    /// step for
    /// the workflow to continue after the completion of the step.
    step_action_type: ?StepActionType = null,

    /// The custom script to run tests on source or target environments.
    step_automation_configuration: ?StepAutomationConfiguration = null,

    /// The ID of the step group.
    step_group_id: ?[]const u8 = null,

    /// The ID of the template.
    template_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .creation_time = "creationTime",
        .description = "description",
        .id = "id",
        .name = "name",
        .next = "next",
        .outputs = "outputs",
        .previous = "previous",
        .step_action_type = "stepActionType",
        .step_automation_configuration = "stepAutomationConfiguration",
        .step_group_id = "stepGroupId",
        .template_id = "templateId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetTemplateStepInput, options: CallOptions) !GetTemplateStepOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetTemplateStepInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("migrationhub-orchestrator", "MigrationHubOrchestrator", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/templatestep/");
    try path_buf.appendSlice(allocator, input.id);
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (query_has_prev) try query_buf.appendSlice(allocator, "&");
    try query_buf.appendSlice(allocator, "stepGroupId=");
    try aws.url.appendUrlEncoded(allocator, &query_buf, input.step_group_id);
    query_has_prev = true;
    if (query_has_prev) try query_buf.appendSlice(allocator, "&");
    try query_buf.appendSlice(allocator, "templateId=");
    try aws.url.appendUrlEncoded(allocator, &query_buf, input.template_id);
    query_has_prev = true;
    const query = try query_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetTemplateStepOutput {
    const result: GetTemplateStepOutput = try aws.json.parseJsonObject(
        GetTemplateStepOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
