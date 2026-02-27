const ErrorDetails = @import("error_details.zig").ErrorDetails;

/// Execution result information, such as the external execution ID.
pub const ActionExecutionResult = struct {
    error_details: ?ErrorDetails,

    /// The action provider's external ID for the action execution.
    external_execution_id: ?[]const u8,

    /// The action provider's summary for the action execution.
    external_execution_summary: ?[]const u8,

    /// The deepest external link to the external resource (for example, a
    /// repository URL or
    /// deployment endpoint) that is used when running the action.
    external_execution_url: ?[]const u8,

    /// The Amazon Resource Name (ARN) of the log stream for the action compute.
    log_stream_arn: ?[]const u8,

    pub const json_field_names = .{
        .error_details = "errorDetails",
        .external_execution_id = "externalExecutionId",
        .external_execution_summary = "externalExecutionSummary",
        .external_execution_url = "externalExecutionUrl",
        .log_stream_arn = "logStreamARN",
    };
};
