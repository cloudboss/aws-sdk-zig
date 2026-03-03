const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const MigrationWorkflowStatusEnum = @import("migration_workflow_status_enum.zig").MigrationWorkflowStatusEnum;
const Tool = @import("tool.zig").Tool;
const StepInput = @import("step_input.zig").StepInput;

pub const GetWorkflowInput = struct {
    /// The ID of the migration workflow.
    id: []const u8,

    pub const json_field_names = .{
        .id = "id",
    };
};

pub const GetWorkflowOutput = struct {
    /// The configuration ID of the application configured in Application Discovery
    /// Service.
    ads_application_configuration_id: ?[]const u8 = null,

    /// The name of the application configured in Application Discovery Service.
    ads_application_name: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the migration workflow.
    arn: ?[]const u8 = null,

    /// Get a list of completed steps in the migration workflow.
    completed_steps: ?i32 = null,

    /// The time at which the migration workflow was created.
    creation_time: ?i64 = null,

    /// The description of the migration workflow.
    description: ?[]const u8 = null,

    /// The time at which the migration workflow ended.
    end_time: ?i64 = null,

    /// The ID of the migration workflow.
    id: ?[]const u8 = null,

    /// The time at which the migration workflow was last modified.
    last_modified_time: ?i64 = null,

    /// The time at which the migration workflow was last started.
    last_start_time: ?i64 = null,

    /// The time at which the migration workflow was last stopped.
    last_stop_time: ?i64 = null,

    /// The name of the migration workflow.
    name: ?[]const u8 = null,

    /// The status of the migration workflow.
    status: ?MigrationWorkflowStatusEnum = null,

    /// The status message of the migration workflow.
    status_message: ?[]const u8 = null,

    /// The tags added to the migration workflow.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// The ID of the template.
    template_id: ?[]const u8 = null,

    /// List of AWS services utilized in a migration workflow.
    tools: ?[]const Tool = null,

    /// The total number of steps in the migration workflow.
    total_steps: ?i32 = null,

    /// The Amazon S3 bucket where the migration logs are stored.
    workflow_bucket: ?[]const u8 = null,

    /// The inputs required for creating the migration workflow.
    workflow_inputs: ?[]const aws.map.MapEntry(StepInput) = null,

    pub const json_field_names = .{
        .ads_application_configuration_id = "adsApplicationConfigurationId",
        .ads_application_name = "adsApplicationName",
        .arn = "arn",
        .completed_steps = "completedSteps",
        .creation_time = "creationTime",
        .description = "description",
        .end_time = "endTime",
        .id = "id",
        .last_modified_time = "lastModifiedTime",
        .last_start_time = "lastStartTime",
        .last_stop_time = "lastStopTime",
        .name = "name",
        .status = "status",
        .status_message = "statusMessage",
        .tags = "tags",
        .template_id = "templateId",
        .tools = "tools",
        .total_steps = "totalSteps",
        .workflow_bucket = "workflowBucket",
        .workflow_inputs = "workflowInputs",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetWorkflowInput, options: CallOptions) !GetWorkflowOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "migrationhuborchestrator");

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetWorkflowInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("migrationhuborchestrator", "MigrationHubOrchestrator", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(allocator, "/migrationworkflow/");
    try path_buf.appendSlice(allocator, input.id);
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(host);
    request.method = .GET;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetWorkflowOutput {
    var result: GetWorkflowOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetWorkflowOutput, body, allocator);
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
