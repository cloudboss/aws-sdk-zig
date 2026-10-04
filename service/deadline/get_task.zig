const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const TaskParameterValue = @import("task_parameter_value.zig").TaskParameterValue;
const TaskRunStatus = @import("task_run_status.zig").TaskRunStatus;
const TaskTargetRunStatus = @import("task_target_run_status.zig").TaskTargetRunStatus;

pub const GetTaskInput = struct {
    /// The farm ID of the farm connected to the task.
    farm_id: []const u8,

    /// The job ID of the job connected to the task.
    job_id: []const u8,

    /// The queue ID for the queue connected to the task.
    queue_id: []const u8,

    /// The step ID for the step connected to the task.
    step_id: []const u8,

    /// The task ID.
    task_id: []const u8,

    pub const json_field_names = .{
        .farm_id = "farmId",
        .job_id = "jobId",
        .queue_id = "queueId",
        .step_id = "stepId",
        .task_id = "taskId",
    };
};

pub const GetTaskOutput = struct {
    /// The date and time the resource was created.
    created_at: i64,

    /// The user or system that created this resource.
    created_by: []const u8,

    /// The date and time the resource ended running.
    ended_at: ?i64 = null,

    /// The number of times that the task failed and was retried.
    failure_retry_count: ?i32 = null,

    /// The latest session action ID for the task.
    latest_session_action_id: ?[]const u8 = null,

    /// The parameters for the task.
    parameters: ?[]const aws.map.MapEntry(TaskParameterValue) = null,

    /// The run status for the task.
    run_status: TaskRunStatus,

    /// The date and time the resource started running.
    started_at: ?i64 = null,

    /// The run status with which to start the task.
    target_run_status: ?TaskTargetRunStatus = null,

    /// The task ID.
    task_id: []const u8,

    /// The date and time the resource was updated.
    updated_at: ?i64 = null,

    /// The user or system that updated this resource.
    updated_by: ?[]const u8 = null,

    pub const json_field_names = .{
        .created_at = "createdAt",
        .created_by = "createdBy",
        .ended_at = "endedAt",
        .failure_retry_count = "failureRetryCount",
        .latest_session_action_id = "latestSessionActionId",
        .parameters = "parameters",
        .run_status = "runStatus",
        .started_at = "startedAt",
        .target_run_status = "targetRunStatus",
        .task_id = "taskId",
        .updated_at = "updatedAt",
        .updated_by = "updatedBy",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetTaskInput, options: CallOptions) !GetTaskOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "deadline", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetTaskInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("deadline", "deadline", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/2023-10-12/farms/");
    try path_buf.appendSlice(allocator, input.farm_id);
    try path_buf.appendSlice(allocator, "/queues/");
    try path_buf.appendSlice(allocator, input.queue_id);
    try path_buf.appendSlice(allocator, "/jobs/");
    try path_buf.appendSlice(allocator, input.job_id);
    try path_buf.appendSlice(allocator, "/steps/");
    try path_buf.appendSlice(allocator, input.step_id);
    try path_buf.appendSlice(allocator, "/tasks/");
    try path_buf.appendSlice(allocator, input.task_id);
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetTaskOutput {
    var result: GetTaskOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetTaskOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
