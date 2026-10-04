const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const MaintenanceWindowExecutionStatus = @import("maintenance_window_execution_status.zig").MaintenanceWindowExecutionStatus;
const MaintenanceWindowTaskType = @import("maintenance_window_task_type.zig").MaintenanceWindowTaskType;

pub const GetMaintenanceWindowExecutionTaskInvocationInput = struct {
    /// The invocation ID to retrieve.
    invocation_id: []const u8,

    /// The ID of the specific task in the maintenance window task that should be
    /// retrieved.
    task_id: []const u8,

    /// The ID of the maintenance window execution for which the task is a part.
    window_execution_id: []const u8,

    pub const json_field_names = .{
        .invocation_id = "InvocationId",
        .task_id = "TaskId",
        .window_execution_id = "WindowExecutionId",
    };
};

pub const GetMaintenanceWindowExecutionTaskInvocationOutput = struct {
    /// The time that the task finished running on the target.
    end_time: ?i64 = null,

    /// The execution ID.
    execution_id: ?[]const u8 = null,

    /// The invocation ID.
    invocation_id: ?[]const u8 = null,

    /// User-provided value to be included in any Amazon CloudWatch Events or Amazon
    /// EventBridge
    /// events raised while running tasks for these targets in this maintenance
    /// window.
    owner_information: ?[]const u8 = null,

    /// The parameters used at the time that the task ran.
    parameters: ?[]const u8 = null,

    /// The time that the task started running on the target.
    start_time: ?i64 = null,

    /// The task status for an invocation.
    status: ?MaintenanceWindowExecutionStatus = null,

    /// The details explaining the status. Details are only available for certain
    /// status
    /// values.
    status_details: ?[]const u8 = null,

    /// The task execution ID.
    task_execution_id: ?[]const u8 = null,

    /// Retrieves the task type for a maintenance window.
    task_type: ?MaintenanceWindowTaskType = null,

    /// The maintenance window execution ID.
    window_execution_id: ?[]const u8 = null,

    /// The maintenance window target ID.
    window_target_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .end_time = "EndTime",
        .execution_id = "ExecutionId",
        .invocation_id = "InvocationId",
        .owner_information = "OwnerInformation",
        .parameters = "Parameters",
        .start_time = "StartTime",
        .status = "Status",
        .status_details = "StatusDetails",
        .task_execution_id = "TaskExecutionId",
        .task_type = "TaskType",
        .window_execution_id = "WindowExecutionId",
        .window_target_id = "WindowTargetId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetMaintenanceWindowExecutionTaskInvocationInput, options: CallOptions) !GetMaintenanceWindowExecutionTaskInvocationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "ssm", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetMaintenanceWindowExecutionTaskInvocationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ssm", "SSM", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AmazonSSM.GetMaintenanceWindowExecutionTaskInvocation");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetMaintenanceWindowExecutionTaskInvocationOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GetMaintenanceWindowExecutionTaskInvocationOutput, body, allocator);
}
