const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AlarmConfiguration = @import("alarm_configuration.zig").AlarmConfiguration;
const MaintenanceWindowTaskCutoffBehavior = @import("maintenance_window_task_cutoff_behavior.zig").MaintenanceWindowTaskCutoffBehavior;
const LoggingInfo = @import("logging_info.zig").LoggingInfo;
const Target = @import("target.zig").Target;
const MaintenanceWindowTaskInvocationParameters = @import("maintenance_window_task_invocation_parameters.zig").MaintenanceWindowTaskInvocationParameters;
const MaintenanceWindowTaskParameterValueExpression = @import("maintenance_window_task_parameter_value_expression.zig").MaintenanceWindowTaskParameterValueExpression;
const MaintenanceWindowTaskType = @import("maintenance_window_task_type.zig").MaintenanceWindowTaskType;

pub const GetMaintenanceWindowTaskInput = struct {
    /// The maintenance window ID that includes the task to retrieve.
    window_id: []const u8,

    /// The maintenance window task ID to retrieve.
    window_task_id: []const u8,

    pub const json_field_names = .{
        .window_id = "WindowId",
        .window_task_id = "WindowTaskId",
    };
};

pub const GetMaintenanceWindowTaskOutput = struct {
    /// The details for the CloudWatch alarm you applied to your maintenance window
    /// task.
    alarm_configuration: ?AlarmConfiguration = null,

    /// The action to take on tasks when the maintenance window cutoff time is
    /// reached.
    /// `CONTINUE_TASK` means that tasks continue to run. For Automation, Lambda,
    /// Step Functions tasks, `CANCEL_TASK` means that currently
    /// running task invocations continue, but no new task invocations are started.
    /// For Run Command
    /// tasks, `CANCEL_TASK` means the system attempts to stop the task by sending a
    /// `CancelCommand` operation.
    cutoff_behavior: ?MaintenanceWindowTaskCutoffBehavior = null,

    /// The retrieved task description.
    description: ?[]const u8 = null,

    /// The location in Amazon Simple Storage Service (Amazon S3) where the task
    /// results are
    /// logged.
    ///
    /// `LoggingInfo` has been deprecated. To specify an Amazon Simple Storage
    /// Service (Amazon S3) bucket to contain logs, instead use the
    /// `OutputS3BucketName` and `OutputS3KeyPrefix` options in the
    /// `TaskInvocationParameters` structure.
    /// For information about how Amazon Web Services Systems Manager handles these
    /// options for the supported maintenance
    /// window task types, see MaintenanceWindowTaskInvocationParameters.
    logging_info: ?LoggingInfo = null,

    /// The maximum number of targets allowed to run this task in parallel.
    ///
    /// For maintenance window tasks without a target specified, you can't supply a
    /// value for this
    /// option. Instead, the system inserts a placeholder value of `1`, which may be
    /// reported
    /// in the response to this command. This value doesn't affect the running of
    /// your task and can be
    /// ignored.
    max_concurrency: ?[]const u8 = null,

    /// The maximum number of errors allowed before the task stops being scheduled.
    ///
    /// For maintenance window tasks without a target specified, you can't supply a
    /// value for this
    /// option. Instead, the system inserts a placeholder value of `1`, which may be
    /// reported
    /// in the response to this command. This value doesn't affect the running of
    /// your task and can be
    /// ignored.
    max_errors: ?[]const u8 = null,

    /// The retrieved task name.
    name: ?[]const u8 = null,

    /// The priority of the task when it runs. The lower the number, the higher the
    /// priority. Tasks
    /// that have the same priority are scheduled in parallel.
    priority: ?i32 = null,

    /// The Amazon Resource Name (ARN) of the IAM service role for
    /// Amazon Web Services Systems Manager to assume when running a maintenance
    /// window task. If you do not specify a
    /// service role ARN, Systems Manager uses a service-linked role in your
    /// account. If no
    /// appropriate service-linked role for Systems Manager exists in your account,
    /// it is created when
    /// you run `RegisterTaskWithMaintenanceWindow`.
    ///
    /// However, for an improved security posture, we strongly recommend creating a
    /// custom
    /// policy and custom service role for running your maintenance window tasks.
    /// The policy
    /// can be crafted to provide only the permissions needed for your particular
    /// maintenance window tasks. For more information, see [Setting up Maintenance
    /// Windows](https://docs.aws.amazon.com/systems-manager/latest/userguide/sysman-maintenance-permissions.html) in the in the
    /// *Amazon Web Services Systems Manager User Guide*.
    service_role_arn: ?[]const u8 = null,

    /// The targets where the task should run.
    targets: ?[]const Target = null,

    /// The resource that the task used during execution. For `RUN_COMMAND` and
    /// `AUTOMATION` task types, the value of `TaskArn` is the SSM document
    /// name/ARN. For `LAMBDA` tasks, the value is the function name/ARN. For
    /// `STEP_FUNCTIONS` tasks, the value is the state machine ARN.
    task_arn: ?[]const u8 = null,

    /// The parameters to pass to the task when it runs.
    task_invocation_parameters: ?MaintenanceWindowTaskInvocationParameters = null,

    /// The parameters to pass to the task when it runs.
    ///
    /// `TaskParameters` has been deprecated. To specify parameters to pass to a
    /// task when it runs,
    /// instead use the `Parameters` option in the `TaskInvocationParameters`
    /// structure. For information
    /// about how Systems Manager handles these options for the supported
    /// maintenance window task
    /// types, see MaintenanceWindowTaskInvocationParameters.
    task_parameters: ?[]const aws.map.MapEntry(MaintenanceWindowTaskParameterValueExpression) = null,

    /// The type of task to run.
    task_type: ?MaintenanceWindowTaskType = null,

    /// The retrieved maintenance window ID.
    window_id: ?[]const u8 = null,

    /// The retrieved maintenance window task ID.
    window_task_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .alarm_configuration = "AlarmConfiguration",
        .cutoff_behavior = "CutoffBehavior",
        .description = "Description",
        .logging_info = "LoggingInfo",
        .max_concurrency = "MaxConcurrency",
        .max_errors = "MaxErrors",
        .name = "Name",
        .priority = "Priority",
        .service_role_arn = "ServiceRoleArn",
        .targets = "Targets",
        .task_arn = "TaskArn",
        .task_invocation_parameters = "TaskInvocationParameters",
        .task_parameters = "TaskParameters",
        .task_type = "TaskType",
        .window_id = "WindowId",
        .window_task_id = "WindowTaskId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetMaintenanceWindowTaskInput, options: CallOptions) !GetMaintenanceWindowTaskOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetMaintenanceWindowTaskInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AmazonSSM.GetMaintenanceWindowTask");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetMaintenanceWindowTaskOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GetMaintenanceWindowTaskOutput, body, allocator);
}
