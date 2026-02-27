const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const DependencyCounts = @import("dependency_counts.zig").DependencyCounts;
const StepLifecycleStatus = @import("step_lifecycle_status.zig").StepLifecycleStatus;
const ParameterSpace = @import("parameter_space.zig").ParameterSpace;
const StepRequiredCapabilities = @import("step_required_capabilities.zig").StepRequiredCapabilities;
const StepTargetTaskRunStatus = @import("step_target_task_run_status.zig").StepTargetTaskRunStatus;
const TaskRunStatus = @import("task_run_status.zig").TaskRunStatus;

pub const GetStepInput = struct {
    /// The farm ID for the step.
    farm_id: []const u8,

    /// The job ID for the step.
    job_id: []const u8,

    /// The queue ID for the step.
    queue_id: []const u8,

    /// The step ID.
    step_id: []const u8,

    pub const json_field_names = .{
        .farm_id = "farmId",
        .job_id = "jobId",
        .queue_id = "queueId",
        .step_id = "stepId",
    };
};

pub const GetStepOutput = struct {
    /// The date and time the resource was created.
    created_at: i64,

    /// The user or system that created this resource.
    created_by: []const u8,

    /// The number of dependencies in the step.
    dependency_counts: ?DependencyCounts = null,

    /// The description of the step.
    ///
    /// This field can store any content. Escape or encode this content before
    /// displaying it on a webpage or any other system that might interpret the
    /// content of this field.
    description: ?[]const u8 = null,

    /// The date and time the resource ended running.
    ended_at: ?i64 = null,

    /// The life cycle status of the step.
    lifecycle_status: StepLifecycleStatus,

    /// A message that describes the lifecycle status of the step.
    lifecycle_status_message: ?[]const u8 = null,

    /// The name of the step.
    name: []const u8,

    /// A list of step parameters and the combination expression for the step.
    parameter_space: ?ParameterSpace = null,

    /// The required capabilities of the step.
    required_capabilities: ?StepRequiredCapabilities = null,

    /// The date and time the resource started running.
    started_at: ?i64 = null,

    /// The step ID.
    step_id: []const u8,

    /// The task status with which the job started.
    target_task_run_status: ?StepTargetTaskRunStatus = null,

    /// The total number of times tasks from the step failed and were retried.
    task_failure_retry_count: ?i32 = null,

    /// The task run status for the job.
    task_run_status: TaskRunStatus,

    /// The number of tasks running on the job.
    task_run_status_counts: ?[]const aws.map.MapEntry(i32) = null,

    /// The date and time the resource was updated.
    updated_at: ?i64 = null,

    /// The user or system that updated this resource.
    updated_by: ?[]const u8 = null,

    pub const json_field_names = .{
        .created_at = "createdAt",
        .created_by = "createdBy",
        .dependency_counts = "dependencyCounts",
        .description = "description",
        .ended_at = "endedAt",
        .lifecycle_status = "lifecycleStatus",
        .lifecycle_status_message = "lifecycleStatusMessage",
        .name = "name",
        .parameter_space = "parameterSpace",
        .required_capabilities = "requiredCapabilities",
        .started_at = "startedAt",
        .step_id = "stepId",
        .target_task_run_status = "targetTaskRunStatus",
        .task_failure_retry_count = "taskFailureRetryCount",
        .task_run_status = "taskRunStatus",
        .task_run_status_counts = "taskRunStatusCounts",
        .updated_at = "updatedAt",
        .updated_by = "updatedBy",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetStepInput, options: Options) !GetStepOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "deadline");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(response.body, response.status, client.allocator) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(response.body, response.status, response.headers, allocator);
    return result;
}

fn serializeRequest(alloc: std.mem.Allocator, input: GetStepInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("deadline", "deadline", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(alloc, "/2023-10-12/farms/");
    try path_buf.appendSlice(alloc, input.farm_id);
    try path_buf.appendSlice(alloc, "/queues/");
    try path_buf.appendSlice(alloc, input.queue_id);
    try path_buf.appendSlice(alloc, "/jobs/");
    try path_buf.appendSlice(alloc, input.job_id);
    try path_buf.appendSlice(alloc, "/steps/");
    try path_buf.appendSlice(alloc, input.step_id);
    const path = try path_buf.toOwnedSlice(alloc);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(host);
    request.method = .GET;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(alloc, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !GetStepOutput {
    var result: GetStepOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetStepOutput, body, alloc);
    }
    _ = status;
    _ = headers;

    return result;
}

fn parseErrorResponse(body: []const u8, status: u16, alloc: std.mem.Allocator) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(alloc);
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
    if (std.mem.eql(u8, error_code, "InternalServerErrorException")) {
        return .{ .arena = arena, .kind = .{ .internal_server_error_exception = .{
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
    if (std.mem.eql(u8, error_code, "ServiceQuotaExceededException")) {
        return .{ .arena = arena, .kind = .{ .service_quota_exceeded_exception = .{
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
