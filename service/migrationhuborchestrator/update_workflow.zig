const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const StepInput = @import("step_input.zig").StepInput;
const MigrationWorkflowStatusEnum = @import("migration_workflow_status_enum.zig").MigrationWorkflowStatusEnum;

pub const UpdateWorkflowInput = struct {
    /// The description of the migration workflow.
    description: ?[]const u8 = null,

    /// The ID of the migration workflow.
    id: []const u8,

    /// The input parameters required to update a migration workflow.
    input_parameters: ?[]const aws.map.MapEntry(StepInput) = null,

    /// The name of the migration workflow.
    name: ?[]const u8 = null,

    /// The servers on which a step will be run.
    step_targets: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .description = "description",
        .id = "id",
        .input_parameters = "inputParameters",
        .name = "name",
        .step_targets = "stepTargets",
    };
};

pub const UpdateWorkflowOutput = struct {
    /// The ID of the application configured in Application Discovery Service.
    ads_application_configuration_id: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the migration workflow.
    arn: ?[]const u8 = null,

    /// The time at which the migration workflow was created.
    creation_time: ?i64 = null,

    /// The description of the migration workflow.
    description: ?[]const u8 = null,

    /// The ID of the migration workflow.
    id: ?[]const u8 = null,

    /// The time at which the migration workflow was last modified.
    last_modified_time: ?i64 = null,

    /// The name of the migration workflow.
    name: ?[]const u8 = null,

    /// The status of the migration workflow.
    status: ?MigrationWorkflowStatusEnum = null,

    /// The servers on which a step will be run.
    step_targets: ?[]const []const u8 = null,

    /// The tags added to the migration workflow.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// The ID of the template.
    template_id: ?[]const u8 = null,

    /// The inputs required to update a migration workflow.
    workflow_inputs: ?[]const aws.map.MapEntry(StepInput) = null,

    pub const json_field_names = .{
        .ads_application_configuration_id = "adsApplicationConfigurationId",
        .arn = "arn",
        .creation_time = "creationTime",
        .description = "description",
        .id = "id",
        .last_modified_time = "lastModifiedTime",
        .name = "name",
        .status = "status",
        .step_targets = "stepTargets",
        .tags = "tags",
        .template_id = "templateId",
        .workflow_inputs = "workflowInputs",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateWorkflowInput, options: CallOptions) !UpdateWorkflowOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateWorkflowInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("migrationhub-orchestrator", "MigrationHubOrchestrator", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/migrationworkflow/");
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
    if (input.input_parameters) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"inputParameters\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.name) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"name\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.step_targets) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"stepTargets\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateWorkflowOutput {
    const result: UpdateWorkflowOutput = try aws.json.parseJsonObject(
        UpdateWorkflowOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
