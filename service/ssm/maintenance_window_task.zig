const aws = @import("aws");

const AlarmConfiguration = @import("alarm_configuration.zig").AlarmConfiguration;
const MaintenanceWindowTaskCutoffBehavior = @import("maintenance_window_task_cutoff_behavior.zig").MaintenanceWindowTaskCutoffBehavior;
const LoggingInfo = @import("logging_info.zig").LoggingInfo;
const Target = @import("target.zig").Target;
const MaintenanceWindowTaskParameterValueExpression = @import("maintenance_window_task_parameter_value_expression.zig").MaintenanceWindowTaskParameterValueExpression;
const MaintenanceWindowTaskType = @import("maintenance_window_task_type.zig").MaintenanceWindowTaskType;

/// Information about a task defined for a maintenance window.
pub const MaintenanceWindowTask = struct {
    /// The details for the CloudWatch alarm applied to your maintenance window
    /// task.
    alarm_configuration: ?AlarmConfiguration,

    /// The specification for whether tasks should continue to run after the cutoff
    /// time specified
    /// in the maintenance windows is reached.
    cutoff_behavior: ?MaintenanceWindowTaskCutoffBehavior,

    /// A description of the task.
    description: ?[]const u8,

    /// Information about an S3 bucket to write task-level logs to.
    ///
    /// `LoggingInfo` has been deprecated. To specify an Amazon Simple Storage
    /// Service (Amazon S3) bucket to contain logs, instead use the
    /// `OutputS3BucketName` and `OutputS3KeyPrefix` options in the
    /// `TaskInvocationParameters` structure.
    /// For information about how Amazon Web Services Systems Manager handles these
    /// options for the supported maintenance
    /// window task types, see MaintenanceWindowTaskInvocationParameters.
    logging_info: ?LoggingInfo,

    /// The maximum number of targets this task can be run for, in parallel.
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
    max_concurrency: ?[]const u8,

    /// The maximum number of errors allowed before this task stops being scheduled.
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
    max_errors: ?[]const u8,

    /// The task name.
    name: ?[]const u8,

    /// The priority of the task in the maintenance window. The lower the number,
    /// the higher the
    /// priority. Tasks that have the same priority are scheduled in parallel.
    priority: i32 = 0,

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
    service_role_arn: ?[]const u8,

    /// The targets (either managed nodes or tags). Managed nodes are specified
    /// using
    /// `Key=instanceids,Values=,`. Tags are specified
    /// using `Key=,Values=`.
    targets: ?[]const Target,

    /// The resource that the task uses during execution. For `RUN_COMMAND` and
    /// `AUTOMATION` task types, `TaskArn` is the Amazon Web Services Systems
    /// Manager (SSM document) name or
    /// ARN. For `LAMBDA` tasks, it's the function name or ARN. For
    /// `STEP_FUNCTIONS` tasks, it's the state machine ARN.
    task_arn: ?[]const u8,

    /// The parameters that should be passed to the task when it is run.
    ///
    /// `TaskParameters` has been deprecated. To specify parameters to pass to a
    /// task when it runs,
    /// instead use the `Parameters` option in the `TaskInvocationParameters`
    /// structure. For information
    /// about how Systems Manager handles these options for the supported
    /// maintenance window task
    /// types, see MaintenanceWindowTaskInvocationParameters.
    task_parameters: ?[]const aws.map.MapEntry(MaintenanceWindowTaskParameterValueExpression),

    /// The type of task.
    @"type": ?MaintenanceWindowTaskType,

    /// The ID of the maintenance window where the task is registered.
    window_id: ?[]const u8,

    /// The task ID.
    window_task_id: ?[]const u8,

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
        .task_parameters = "TaskParameters",
        .@"type" = "Type",
        .window_id = "WindowId",
        .window_task_id = "WindowTaskId",
    };
};
