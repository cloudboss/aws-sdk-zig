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

pub const UpdateMaintenanceWindowTaskInput = struct {
    /// The CloudWatch alarm you want to apply to your maintenance window task.
    alarm_configuration: ?AlarmConfiguration = null,

    /// Indicates whether tasks should continue to run after the cutoff time
    /// specified in the
    /// maintenance windows is reached.
    ///
    /// * `CONTINUE_TASK`: When the cutoff time is reached, any tasks that are
    ///   running
    /// continue. The default value.
    ///
    /// * `CANCEL_TASK`:
    ///
    /// * For Automation, Lambda, Step Functions tasks: When the cutoff
    /// time is reached, any task invocations that are already running continue, but
    /// no new task
    /// invocations are started.
    ///
    /// * For Run Command tasks: When the cutoff time is reached, the system sends a
    ///   CancelCommand operation that attempts to cancel the command associated
    ///   with the
    /// task. However, there is no guarantee that the command will be terminated and
    /// the underlying
    /// process stopped.
    ///
    /// The status for tasks that are not completed is `TIMED_OUT`.
    cutoff_behavior: ?MaintenanceWindowTaskCutoffBehavior = null,

    /// The new task description to specify.
    description: ?[]const u8 = null,

    /// The new logging location in Amazon S3 to specify.
    ///
    /// `LoggingInfo` has been deprecated. To specify an Amazon Simple Storage
    /// Service (Amazon S3) bucket to contain logs, instead use the
    /// `OutputS3BucketName` and `OutputS3KeyPrefix` options in the
    /// `TaskInvocationParameters` structure.
    /// For information about how Amazon Web Services Systems Manager handles these
    /// options for the supported maintenance
    /// window task types, see MaintenanceWindowTaskInvocationParameters.
    logging_info: ?LoggingInfo = null,

    /// The new `MaxConcurrency` value you want to specify. `MaxConcurrency`
    /// is the number of targets that are allowed to run this task, in parallel.
    ///
    /// Although this element is listed as "Required: No", a value can be omitted
    /// only when you are
    /// registering or updating a [targetless
    /// task](https://docs.aws.amazon.com/systems-manager/latest/userguide/maintenance-windows-targetless-tasks.html) You must provide a value in all other cases.
    ///
    /// For maintenance window tasks without a target specified, you can't supply a
    /// value for this
    /// option. Instead, the system inserts a placeholder value of `1`. This value
    /// doesn't
    /// affect the running of your task.
    max_concurrency: ?[]const u8 = null,

    /// The new `MaxErrors` value to specify. `MaxErrors` is the maximum
    /// number of errors that are allowed before the task stops being scheduled.
    ///
    /// Although this element is listed as "Required: No", a value can be omitted
    /// only when you are
    /// registering or updating a [targetless
    /// task](https://docs.aws.amazon.com/systems-manager/latest/userguide/maintenance-windows-targetless-tasks.html) You must provide a value in all other cases.
    ///
    /// For maintenance window tasks without a target specified, you can't supply a
    /// value for this
    /// option. Instead, the system inserts a placeholder value of `1`. This value
    /// doesn't
    /// affect the running of your task.
    max_errors: ?[]const u8 = null,

    /// The new task name to specify.
    name: ?[]const u8 = null,

    /// The new task priority to specify. The lower the number, the higher the
    /// priority. Tasks that
    /// have the same priority are scheduled in parallel.
    priority: ?i32 = null,

    /// If True, then all fields that are required by the
    /// RegisterTaskWithMaintenanceWindow operation are also required for this API
    /// request.
    /// Optional fields that aren't specified are set to null.
    replace: ?bool = null,

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

    /// The targets (either managed nodes or tags) to modify. Managed nodes are
    /// specified using the
    /// format `Key=instanceids,Values=instanceID_1,instanceID_2`. Tags are
    /// specified using
    /// the format ` Key=tag_name,Values=tag_value`.
    ///
    /// One or more targets must be specified for maintenance window Run
    /// Command-type tasks.
    /// Depending on the task, targets are optional for other maintenance window
    /// task types (Automation,
    /// Lambda, and Step Functions). For more information about running tasks
    /// that don't specify targets, see [Registering
    /// maintenance window tasks without
    /// targets](https://docs.aws.amazon.com/systems-manager/latest/userguide/maintenance-windows-targetless-tasks.html) in the
    /// *Amazon Web Services Systems Manager User Guide*.
    targets: ?[]const Target = null,

    /// The task ARN to modify.
    task_arn: ?[]const u8 = null,

    /// The parameters that the task should use during execution. Populate only the
    /// fields that
    /// match the task type. All other fields should be empty.
    ///
    /// When you update a maintenance window task that has options specified in
    /// `TaskInvocationParameters`, you must provide again all the
    /// `TaskInvocationParameters` values that you want to retain. The values you
    /// don't
    /// specify again are removed. For example, suppose that when you registered a
    /// Run Command task, you
    /// specified `TaskInvocationParameters` values for `Comment`,
    /// `NotificationConfig`, and `OutputS3BucketName`. If you update the
    /// maintenance window task and specify only a different `OutputS3BucketName`
    /// value, the
    /// values for `Comment` and `NotificationConfig` are removed.
    task_invocation_parameters: ?MaintenanceWindowTaskInvocationParameters = null,

    /// The parameters to modify.
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
    /// Key: string, between 1 and 255 characters
    ///
    /// Value: an array of strings, each string is between 1 and 255 characters
    task_parameters: ?[]const aws.map.MapEntry(MaintenanceWindowTaskParameterValueExpression) = null,

    /// The maintenance window ID that contains the task to modify.
    window_id: []const u8,

    /// The task ID to modify.
    window_task_id: []const u8,

    pub const json_field_names = .{
        .alarm_configuration = "AlarmConfiguration",
        .cutoff_behavior = "CutoffBehavior",
        .description = "Description",
        .logging_info = "LoggingInfo",
        .max_concurrency = "MaxConcurrency",
        .max_errors = "MaxErrors",
        .name = "Name",
        .priority = "Priority",
        .replace = "Replace",
        .service_role_arn = "ServiceRoleArn",
        .targets = "Targets",
        .task_arn = "TaskArn",
        .task_invocation_parameters = "TaskInvocationParameters",
        .task_parameters = "TaskParameters",
        .window_id = "WindowId",
        .window_task_id = "WindowTaskId",
    };
};

pub const UpdateMaintenanceWindowTaskOutput = struct {
    /// The details for the CloudWatch alarm you applied to your maintenance window
    /// task.
    alarm_configuration: ?AlarmConfiguration = null,

    /// The specification for whether tasks should continue to run after the cutoff
    /// time specified
    /// in the maintenance windows is reached.
    cutoff_behavior: ?MaintenanceWindowTaskCutoffBehavior = null,

    /// The updated task description.
    description: ?[]const u8 = null,

    /// The updated logging information in Amazon S3.
    ///
    /// `LoggingInfo` has been deprecated. To specify an Amazon Simple Storage
    /// Service (Amazon S3) bucket to contain logs, instead use the
    /// `OutputS3BucketName` and `OutputS3KeyPrefix` options in the
    /// `TaskInvocationParameters` structure.
    /// For information about how Amazon Web Services Systems Manager handles these
    /// options for the supported maintenance
    /// window task types, see MaintenanceWindowTaskInvocationParameters.
    logging_info: ?LoggingInfo = null,

    /// The updated `MaxConcurrency` value.
    max_concurrency: ?[]const u8 = null,

    /// The updated `MaxErrors` value.
    max_errors: ?[]const u8 = null,

    /// The updated task name.
    name: ?[]const u8 = null,

    /// The updated priority value.
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

    /// The updated target values.
    targets: ?[]const Target = null,

    /// The updated task ARN value.
    task_arn: ?[]const u8 = null,

    /// The updated parameter values.
    task_invocation_parameters: ?MaintenanceWindowTaskInvocationParameters = null,

    /// The updated parameter values.
    ///
    /// `TaskParameters` has been deprecated. To specify parameters to pass to a
    /// task when it runs,
    /// instead use the `Parameters` option in the `TaskInvocationParameters`
    /// structure. For information
    /// about how Systems Manager handles these options for the supported
    /// maintenance window task
    /// types, see MaintenanceWindowTaskInvocationParameters.
    task_parameters: ?[]const aws.map.MapEntry(MaintenanceWindowTaskParameterValueExpression) = null,

    /// The ID of the maintenance window that was updated.
    window_id: ?[]const u8 = null,

    /// The task ID of the maintenance window that was updated.
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
        .window_id = "WindowId",
        .window_task_id = "WindowTaskId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateMaintenanceWindowTaskInput, options: CallOptions) !UpdateMaintenanceWindowTaskOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateMaintenanceWindowTaskInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AmazonSSM.UpdateMaintenanceWindowTask");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateMaintenanceWindowTaskOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(UpdateMaintenanceWindowTaskOutput, body, allocator);
}
