const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const WorkflowStepOutput = @import("workflow_step_output.zig").WorkflowStepOutput;
const Owner = @import("owner.zig").Owner;
const StepStatus = @import("step_status.zig").StepStatus;
const StepActionType = @import("step_action_type.zig").StepActionType;
const WorkflowStepAutomationConfiguration = @import("workflow_step_automation_configuration.zig").WorkflowStepAutomationConfiguration;

pub const GetWorkflowStepInput = struct {
    /// The ID of the step.
    id: []const u8,

    /// The ID of the step group.
    step_group_id: []const u8,

    /// The ID of the migration workflow.
    workflow_id: []const u8,

    pub const json_field_names = .{
        .id = "id",
        .step_group_id = "stepGroupId",
        .workflow_id = "workflowId",
    };
};

pub const GetWorkflowStepOutput = struct {
    /// The time at which the step was created.
    creation_time: ?i64 = null,

    /// The description of the step.
    description: ?[]const u8 = null,

    /// The time at which the step ended.
    end_time: ?i64 = null,

    /// The time at which the workflow was last started.
    last_start_time: ?i64 = null,

    /// The name of the step.
    name: ?[]const u8 = null,

    /// The next step.
    next: ?[]const []const u8 = null,

    /// The number of servers that have been migrated.
    no_of_srv_completed: ?i32 = null,

    /// The number of servers that have failed to migrate.
    no_of_srv_failed: ?i32 = null,

    /// The outputs of the step.
    outputs: ?[]const WorkflowStepOutput = null,

    /// The owner of the step.
    owner: ?Owner = null,

    /// The previous step.
    previous: ?[]const []const u8 = null,

    /// The output location of the script.
    script_output_location: ?[]const u8 = null,

    /// The status of the step.
    status: ?StepStatus = null,

    /// The status message of the migration workflow.
    status_message: ?[]const u8 = null,

    /// The action type of the step. You must run and update the status of a manual
    /// step for
    /// the workflow to continue after the completion of the step.
    step_action_type: ?StepActionType = null,

    /// The ID of the step group.
    step_group_id: ?[]const u8 = null,

    /// The ID of the step.
    step_id: ?[]const u8 = null,

    /// The servers on which a step will be run.
    step_target: ?[]const []const u8 = null,

    /// The total number of servers that have been migrated.
    total_no_of_srv: ?i32 = null,

    /// The ID of the migration workflow.
    workflow_id: ?[]const u8 = null,

    /// The custom script to run tests on source or target environments.
    workflow_step_automation_configuration: ?WorkflowStepAutomationConfiguration = null,

    pub const json_field_names = .{
        .creation_time = "creationTime",
        .description = "description",
        .end_time = "endTime",
        .last_start_time = "lastStartTime",
        .name = "name",
        .next = "next",
        .no_of_srv_completed = "noOfSrvCompleted",
        .no_of_srv_failed = "noOfSrvFailed",
        .outputs = "outputs",
        .owner = "owner",
        .previous = "previous",
        .script_output_location = "scriptOutputLocation",
        .status = "status",
        .status_message = "statusMessage",
        .step_action_type = "stepActionType",
        .step_group_id = "stepGroupId",
        .step_id = "stepId",
        .step_target = "stepTarget",
        .total_no_of_srv = "totalNoOfSrv",
        .workflow_id = "workflowId",
        .workflow_step_automation_configuration = "workflowStepAutomationConfiguration",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetWorkflowStepInput, options: CallOptions) !GetWorkflowStepOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "migrationhub-orchestrator");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: GetWorkflowStepInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("migrationhub-orchestrator", "MigrationHubOrchestrator", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(allocator, "/workflowstep/");
    try path_buf.appendSlice(allocator, input.id);
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .{};
    var query_has_prev = false;
    if (query_has_prev) try query_buf.appendSlice(allocator, "&");
    try query_buf.appendSlice(allocator, "stepGroupId=");
    try aws.url.appendUrlEncoded(allocator, &query_buf, input.step_group_id);
    query_has_prev = true;
    if (query_has_prev) try query_buf.appendSlice(allocator, "&");
    try query_buf.appendSlice(allocator, "workflowId=");
    try aws.url.appendUrlEncoded(allocator, &query_buf, input.workflow_id);
    query_has_prev = true;
    const query = try query_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(host);
    request.method = .GET;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetWorkflowStepOutput {
    var result: GetWorkflowStepOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetWorkflowStepOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}

fn parseErrorResponse(allocator: std.mem.Allocator, body: []const u8, status: u16) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(allocator);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, "");

    if (std.mem.eql(u8, error_code, "AccessDeniedException")) {
        return .{ .arena = arena, .kind = .{ .access_denied_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ConflictException")) {
        return .{ .arena = arena, .kind = .{ .conflict_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InternalServerException")) {
        return .{ .arena = arena, .kind = .{ .internal_server_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .resource_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ThrottlingException")) {
        return .{ .arena = arena, .kind = .{ .throttling_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ValidationException")) {
        return .{ .arena = arena, .kind = .{ .validation_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
