const ErrorDetails = @import("error_details.zig").ErrorDetails;

/// Execution result information, such as the external execution ID.
pub const RuleExecutionResult = struct {
    error_details: ?ErrorDetails = null,

    /// The external ID for the rule execution.
    external_execution_id: ?[]const u8 = null,

    /// The external provider summary for the rule execution.
    external_execution_summary: ?[]const u8 = null,

    /// The deepest external link to the external resource (for example, a
    /// repository URL or
    /// deployment endpoint) that is used when running the rule.
    external_execution_url: ?[]const u8 = null,

    pub const json_field_names = .{
        .error_details = "errorDetails",
        .external_execution_id = "externalExecutionId",
        .external_execution_summary = "externalExecutionSummary",
        .external_execution_url = "externalExecutionUrl",
    };
};
