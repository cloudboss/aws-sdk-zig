const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AlarmConfiguration = @import("alarm_configuration.zig").AlarmConfiguration;
const MaintenanceWindowExecutionStatus = @import("maintenance_window_execution_status.zig").MaintenanceWindowExecutionStatus;
const MaintenanceWindowTaskParameterValueExpression = @import("maintenance_window_task_parameter_value_expression.zig").MaintenanceWindowTaskParameterValueExpression;
const AlarmStateInformation = @import("alarm_state_information.zig").AlarmStateInformation;
const MaintenanceWindowTaskType = @import("maintenance_window_task_type.zig").MaintenanceWindowTaskType;

pub const GetMaintenanceWindowExecutionTaskInput = struct {
    /// The ID of the specific task execution in the maintenance window task that
    /// should be
    /// retrieved.
    task_id: []const u8,

    /// The ID of the maintenance window execution that includes the task.
    window_execution_id: []const u8,

    pub const json_field_names = .{
        .task_id = "TaskId",
        .window_execution_id = "WindowExecutionId",
    };
};

pub const GetMaintenanceWindowExecutionTaskOutput = struct {
    /// The details for the CloudWatch alarm you applied to your maintenance window
    /// task.
    alarm_configuration: ?AlarmConfiguration = null,

    /// The time the task execution completed.
    end_time: ?i64 = null,

    /// The defined maximum number of task executions that could be run in parallel.
    max_concurrency: ?[]const u8 = null,

    /// The defined maximum number of task execution errors allowed before
    /// scheduling of the task
    /// execution would have been stopped.
    max_errors: ?[]const u8 = null,

    /// The priority of the task.
    priority: ?i32 = null,

    /// The role that was assumed when running the task.
    service_role: ?[]const u8 = null,

    /// The time the task execution started.
    start_time: ?i64 = null,

    /// The status of the task.
    status: ?MaintenanceWindowExecutionStatus = null,

    /// The details explaining the status. Not available for all status values.
    status_details: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the task that ran.
    task_arn: ?[]const u8 = null,

    /// The ID of the specific task execution in the maintenance window task that
    /// was
    /// retrieved.
    task_execution_id: ?[]const u8 = null,

    /// The parameters passed to the task when it was run.
    ///
    /// `TaskParameters` has been deprecated. To specify parameters to pass to a
    /// task when it runs,
    /// instead use the `Parameters` option in the `TaskInvocationParameters`
    /// structure. For information
    /// about how Systems Manager handles these options for the supported
    /// maintenance window task
    /// types, see MaintenanceWindowTaskInvocationParameters.
    ///
    /// The map has the following format:
    ///
    /// * `Key`: string, between 1 and 255 characters
    ///
    /// * `Value`: an array of strings, each between 1 and 255 characters
    task_parameters: ?[]const []const aws.map.MapEntry(MaintenanceWindowTaskParameterValueExpression) = null,

    /// The CloudWatch alarms that were invoked by the maintenance window task.
    triggered_alarms: ?[]const AlarmStateInformation = null,

    /// The type of task that was run.
    @"type": ?MaintenanceWindowTaskType = null,

    /// The ID of the maintenance window execution that includes the task.
    window_execution_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .alarm_configuration = "AlarmConfiguration",
        .end_time = "EndTime",
        .max_concurrency = "MaxConcurrency",
        .max_errors = "MaxErrors",
        .priority = "Priority",
        .service_role = "ServiceRole",
        .start_time = "StartTime",
        .status = "Status",
        .status_details = "StatusDetails",
        .task_arn = "TaskArn",
        .task_execution_id = "TaskExecutionId",
        .task_parameters = "TaskParameters",
        .triggered_alarms = "TriggeredAlarms",
        .@"type" = "Type",
        .window_execution_id = "WindowExecutionId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetMaintenanceWindowExecutionTaskInput, options: CallOptions) !GetMaintenanceWindowExecutionTaskOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetMaintenanceWindowExecutionTaskInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AmazonSSM.GetMaintenanceWindowExecutionTask");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetMaintenanceWindowExecutionTaskOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GetMaintenanceWindowExecutionTaskOutput, body, allocator);
}
