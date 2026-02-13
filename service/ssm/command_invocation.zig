const CloudWatchOutputConfig = @import("cloud_watch_output_config.zig").CloudWatchOutputConfig;
const CommandPlugin = @import("command_plugin.zig").CommandPlugin;
const NotificationConfig = @import("notification_config.zig").NotificationConfig;
const CommandInvocationStatus = @import("command_invocation_status.zig").CommandInvocationStatus;

/// An invocation is a copy of a command sent to a specific managed node. A
/// command can apply to
/// one or more managed nodes. A command invocation applies to one managed node.
/// For example, if a
/// user runs `SendCommand` against three managed nodes, then a command
/// invocation is
/// created for each requested managed node ID. A command invocation returns
/// status and detail
/// information about a command you ran.
pub const CommandInvocation = struct {
    /// Amazon CloudWatch Logs information where you want Amazon Web Services
    /// Systems Manager to send the command
    /// output.
    cloud_watch_output_config: ?CloudWatchOutputConfig,

    /// The command against which this invocation was requested.
    command_id: ?[]const u8,

    /// Plugins processed by the command.
    command_plugins: ?[]const CommandPlugin,

    /// User-specified information about the command, such as a brief description of
    /// what the
    /// command should do.
    comment: ?[]const u8,

    /// The document name that was requested for execution.
    document_name: ?[]const u8,

    /// The Systems Manager document (SSM document) version.
    document_version: ?[]const u8,

    /// The managed node ID in which this invocation was requested.
    instance_id: ?[]const u8,

    /// The fully qualified host name of the managed node.
    instance_name: ?[]const u8,

    /// Configurations for sending notifications about command status changes on a
    /// per managed node
    /// basis.
    notification_config: ?NotificationConfig,

    /// The time and date the request was sent to this managed node.
    requested_date_time: ?i64,

    /// The Identity and Access Management (IAM) service role that Run Command, a
    /// tool in
    /// Amazon Web Services Systems Manager, uses to act on your behalf when sending
    /// notifications about command status changes on
    /// a per managed node basis.
    service_role: ?[]const u8,

    /// The URL to the plugin's StdErr file in Amazon Simple Storage Service (Amazon
    /// S3), if the S3
    /// bucket was defined for the parent command. For an invocation,
    /// `StandardErrorUrl` is
    /// populated if there is just one plugin defined for the command, and the S3
    /// bucket was defined for
    /// the command.
    standard_error_url: ?[]const u8,

    /// The URL to the plugin's StdOut file in Amazon Simple Storage Service (Amazon
    /// S3), if the S3
    /// bucket was defined for the parent command. For an invocation,
    /// `StandardOutputUrl` is
    /// populated if there is just one plugin defined for the command, and the S3
    /// bucket was defined for
    /// the command.
    standard_output_url: ?[]const u8,

    /// Whether or not the invocation succeeded, failed, or is pending.
    status: ?CommandInvocationStatus,

    /// A detailed status of the command execution for each invocation (each managed
    /// node targeted
    /// by the command). StatusDetails includes more information than Status because
    /// it includes states
    /// resulting from error and concurrency control parameters. StatusDetails can
    /// show different results
    /// than Status. For more information about these statuses, see [Understanding
    /// command
    /// statuses](https://docs.aws.amazon.com/systems-manager/latest/userguide/monitor-commands.html) in the *Amazon Web Services Systems Manager User Guide*. StatusDetails can be one of the
    /// following values:
    ///
    /// * Pending: The command hasn't been sent to the managed node.
    ///
    /// * In Progress: The command has been sent to the managed node but hasn't
    ///   reached a terminal
    /// state.
    ///
    /// * Success: The execution of the command or plugin was successfully
    ///   completed. This is a
    /// terminal state.
    ///
    /// * Delivery Timed Out: The command wasn't delivered to the managed node
    ///   before the delivery
    /// timeout expired. Delivery timeouts don't count against the parent command's
    /// `MaxErrors` limit, but they do contribute to whether the parent command
    /// status is
    /// Success or Incomplete. This is a terminal state.
    ///
    /// * Execution Timed Out: Command execution started on the managed node, but
    ///   the execution
    /// wasn't complete before the execution timeout expired. Execution timeouts
    /// count against the
    /// `MaxErrors` limit of the parent command. This is a terminal state.
    ///
    /// * Failed: The command wasn't successful on the managed node. For a plugin,
    ///   this indicates
    /// that the result code wasn't zero. For a command invocation, this indicates
    /// that the result code
    /// for one or more plugins wasn't zero. Invocation failures count against the
    /// `MaxErrors` limit of the parent command. This is a terminal state.
    ///
    /// * Cancelled: The command was terminated before it was completed. This is a
    ///   terminal
    /// state.
    ///
    /// * Undeliverable: The command can't be delivered to the managed node. The
    ///   managed node might
    /// not exist or might not be responding. Undeliverable invocations don't count
    /// against the parent
    /// command's MaxErrors limit and don't contribute to whether the parent command
    /// status is Success
    /// or Incomplete. This is a terminal state.
    ///
    /// * Terminated: The parent command exceeded its MaxErrors limit and subsequent
    ///   command
    /// invocations were canceled by the system. This is a terminal state.
    ///
    /// * Delayed: The system attempted to send the command to the managed node but
    ///   wasn't
    /// successful. The system retries again.
    status_details: ?[]const u8,

    /// Gets the trace output sent by the agent.
    trace_output: ?[]const u8,

    pub const json_field_names = .{
        .cloud_watch_output_config = "CloudWatchOutputConfig",
        .command_id = "CommandId",
        .command_plugins = "CommandPlugins",
        .comment = "Comment",
        .document_name = "DocumentName",
        .document_version = "DocumentVersion",
        .instance_id = "InstanceId",
        .instance_name = "InstanceName",
        .notification_config = "NotificationConfig",
        .requested_date_time = "RequestedDateTime",
        .service_role = "ServiceRole",
        .standard_error_url = "StandardErrorUrl",
        .standard_output_url = "StandardOutputUrl",
        .status = "Status",
        .status_details = "StatusDetails",
        .trace_output = "TraceOutput",
    };
};
