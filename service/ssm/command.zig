const aws = @import("aws");

const AlarmConfiguration = @import("alarm_configuration.zig").AlarmConfiguration;
const CloudWatchOutputConfig = @import("cloud_watch_output_config.zig").CloudWatchOutputConfig;
const NotificationConfig = @import("notification_config.zig").NotificationConfig;
const CommandStatus = @import("command_status.zig").CommandStatus;
const Target = @import("target.zig").Target;
const AlarmStateInformation = @import("alarm_state_information.zig").AlarmStateInformation;

/// Describes a command request.
pub const Command = struct {
    /// The details for the CloudWatch alarm applied to your command.
    alarm_configuration: ?AlarmConfiguration,

    /// Amazon CloudWatch Logs information where you want Amazon Web Services
    /// Systems Manager to send the command
    /// output.
    cloud_watch_output_config: ?CloudWatchOutputConfig,

    /// A unique identifier for this command.
    command_id: ?[]const u8,

    /// User-specified information about the command, such as a brief description of
    /// what the
    /// command should do.
    comment: ?[]const u8,

    /// The number of targets for which the command invocation reached a terminal
    /// state. Terminal
    /// states include the following: Success, Failed, Execution Timed Out, Delivery
    /// Timed Out,
    /// Cancelled, Terminated, or Undeliverable.
    completed_count: i32 = 0,

    /// The number of targets for which the status is Delivery Timed Out.
    delivery_timed_out_count: i32 = 0,

    /// The name of the document requested for execution.
    document_name: ?[]const u8,

    /// The Systems Manager document (SSM document) version.
    document_version: ?[]const u8,

    /// The number of targets for which the status is Failed or Execution Timed Out.
    error_count: i32 = 0,

    /// If a command expires, it changes status to `DeliveryTimedOut` for all
    /// invocations
    /// that have the status `InProgress`, `Pending`, or `Delayed`.
    /// `ExpiresAfter` is calculated based on the total timeout for the overall
    /// command. For
    /// more information, see [Understanding command timeout
    /// values](https://docs.aws.amazon.com/systems-manager/latest/userguide/monitor-commands.html?icmpid=docs_ec2_console#monitor-about-status-timeouts) in the
    /// *Amazon Web Services Systems Manager User Guide*.
    expires_after: ?i64,

    /// The managed node IDs against which this command was requested.
    instance_ids: ?[]const []const u8,

    /// The maximum number of managed nodes that are allowed to run the command at
    /// the same time.
    /// You can specify a number of managed nodes, such as 10, or a percentage of
    /// nodes, such as 10%. The
    /// default value is 50. For more information about how to use `MaxConcurrency`,
    /// see
    /// [Amazon Web Services Systems Manager
    /// Run
    /// Command](https://docs.aws.amazon.com/systems-manager/latest/userguide/run-command.html) in the *Amazon Web Services Systems Manager User Guide*.
    max_concurrency: ?[]const u8,

    /// The maximum number of errors allowed before the system stops sending the
    /// command to
    /// additional targets. You can specify a number of errors, such as 10, or a
    /// percentage or errors,
    /// such as 10%. The default value is `0`. For more information about how to use
    /// `MaxErrors`, see [Amazon Web Services Systems Manager Run
    /// Command](https://docs.aws.amazon.com/systems-manager/latest/userguide/run-command.html) in the
    /// *Amazon Web Services Systems Manager User Guide*.
    max_errors: ?[]const u8,

    /// Configurations for sending notifications about command status changes.
    notification_config: ?NotificationConfig,

    /// The S3 bucket where the responses to the command executions should be
    /// stored. This was
    /// requested when issuing the command.
    output_s3_bucket_name: ?[]const u8,

    /// The S3 directory path inside the bucket where the responses to the command
    /// executions should
    /// be stored. This was requested when issuing the command.
    output_s3_key_prefix: ?[]const u8,

    /// (Deprecated) You can no longer specify this parameter. The system ignores
    /// it. Instead, Systems Manager
    /// automatically determines the Amazon Web Services Region of the S3 bucket.
    output_s3_region: ?[]const u8,

    /// The parameter values to be inserted in the document when running the
    /// command.
    parameters: ?[]const aws.map.MapEntry([]const []const u8),

    /// The date and time the command was requested.
    requested_date_time: ?i64,

    /// The Identity and Access Management (IAM) service role that Run Command, a
    /// tool in
    /// Amazon Web Services Systems Manager, uses to act on your behalf when sending
    /// notifications about command status changes.
    service_role: ?[]const u8,

    /// The status of the command.
    status: ?CommandStatus,

    /// A detailed status of the command execution. `StatusDetails` includes more
    /// information than `Status` because it includes states resulting from error
    /// and
    /// concurrency control parameters. `StatusDetails` can show different results
    /// than
    /// Status. For more information about these statuses, see [Understanding
    /// command
    /// statuses](https://docs.aws.amazon.com/systems-manager/latest/userguide/monitor-commands.html) in the *Amazon Web Services Systems Manager User Guide*. StatusDetails can be one of the
    /// following values:
    ///
    /// * Pending: The command hasn't been sent to any managed nodes.
    ///
    /// * In Progress: The command has been sent to at least one managed node but
    ///   hasn't reached a
    /// final state on all managed nodes.
    ///
    /// * Success: The command successfully ran on all invocations. This is a
    ///   terminal state.
    ///
    /// * Delivery Timed Out: The value of MaxErrors or more command invocations
    ///   shows a status of
    /// Delivery Timed Out. This is a terminal state.
    ///
    /// * Execution Timed Out: The value of MaxErrors or more command invocations
    ///   shows a status of
    /// Execution Timed Out. This is a terminal state.
    ///
    /// * Failed: The value of MaxErrors or more command invocations shows a status
    ///   of Failed. This
    /// is a terminal state.
    ///
    /// * Incomplete: The command was attempted on all managed nodes and one or more
    ///   invocations
    /// doesn't have a value of Success but not enough invocations failed for the
    /// status to be Failed.
    /// This is a terminal state.
    ///
    /// * Cancelled: The command was terminated before it was completed. This is a
    ///   terminal
    /// state.
    ///
    /// * Rate Exceeded: The number of managed nodes targeted by the command
    ///   exceeded the account
    /// limit for pending invocations. The system has canceled the command before
    /// running it on any
    /// managed node. This is a terminal state.
    ///
    /// * Delayed: The system attempted to send the command to the managed node but
    ///   wasn't
    /// successful. The system retries again.
    status_details: ?[]const u8,

    /// The number of targets for the command.
    target_count: i32 = 0,

    /// An array of search criteria that targets managed nodes using a Key,Value
    /// combination that
    /// you specify. Targets is required if you don't provide one or more managed
    /// node IDs in the
    /// call.
    targets: ?[]const Target,

    /// The `TimeoutSeconds` value specified for a command.
    timeout_seconds: ?i32,

    /// The CloudWatch alarm that was invoked by the command.
    triggered_alarms: ?[]const AlarmStateInformation,

    pub const json_field_names = .{
        .alarm_configuration = "AlarmConfiguration",
        .cloud_watch_output_config = "CloudWatchOutputConfig",
        .command_id = "CommandId",
        .comment = "Comment",
        .completed_count = "CompletedCount",
        .delivery_timed_out_count = "DeliveryTimedOutCount",
        .document_name = "DocumentName",
        .document_version = "DocumentVersion",
        .error_count = "ErrorCount",
        .expires_after = "ExpiresAfter",
        .instance_ids = "InstanceIds",
        .max_concurrency = "MaxConcurrency",
        .max_errors = "MaxErrors",
        .notification_config = "NotificationConfig",
        .output_s3_bucket_name = "OutputS3BucketName",
        .output_s3_key_prefix = "OutputS3KeyPrefix",
        .output_s3_region = "OutputS3Region",
        .parameters = "Parameters",
        .requested_date_time = "RequestedDateTime",
        .service_role = "ServiceRole",
        .status = "Status",
        .status_details = "StatusDetails",
        .target_count = "TargetCount",
        .targets = "Targets",
        .timeout_seconds = "TimeoutSeconds",
        .triggered_alarms = "TriggeredAlarms",
    };
};
