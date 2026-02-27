const ErrorDetails = @import("error_details.zig").ErrorDetails;
const ActionExecutionStatus = @import("action_execution_status.zig").ActionExecutionStatus;

/// Represents information about the run of an action.
pub const ActionExecution = struct {
    /// ID of the workflow action execution in the current stage. Use the
    /// GetPipelineState action to retrieve the current action execution details
    /// of the current stage.
    ///
    /// For older executions, this field might be empty. The action execution ID is
    /// available for executions run on or after March 2020.
    action_execution_id: ?[]const u8,

    /// The details of an error returned by a URL external to Amazon Web Services.
    error_details: ?ErrorDetails,

    /// The external ID of the run of the action.
    external_execution_id: ?[]const u8,

    /// The URL of a resource external to Amazon Web Services that is used when
    /// running the
    /// action (for example, an external repository URL).
    external_execution_url: ?[]const u8,

    /// The last status change of the action.
    last_status_change: ?i64,

    /// The ARN of the user who last changed the pipeline.
    last_updated_by: ?[]const u8,

    /// The Amazon Resource Name (ARN) of the log stream for the action compute.
    log_stream_arn: ?[]const u8,

    /// A percentage of completeness of the action as it runs.
    percent_complete: ?i32,

    /// The status of the action, or for a completed action, the last status of the
    /// action.
    status: ?ActionExecutionStatus,

    /// A summary of the run of the action.
    summary: ?[]const u8,

    /// The system-generated token used to identify a unique approval request. The
    /// token
    /// for each open approval request can be obtained using the `GetPipelineState`
    /// command. It is used to validate that the approval request corresponding to
    /// this token is
    /// still valid.
    token: ?[]const u8,

    pub const json_field_names = .{
        .action_execution_id = "actionExecutionId",
        .error_details = "errorDetails",
        .external_execution_id = "externalExecutionId",
        .external_execution_url = "externalExecutionUrl",
        .last_status_change = "lastStatusChange",
        .last_updated_by = "lastUpdatedBy",
        .log_stream_arn = "logStreamARN",
        .percent_complete = "percentComplete",
        .status = "status",
        .summary = "summary",
        .token = "token",
    };
};
