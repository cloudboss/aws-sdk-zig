const ErrorDetails = @import("error_details.zig").ErrorDetails;
const RuleExecutionStatus = @import("rule_execution_status.zig").RuleExecutionStatus;

/// Represents information about each time a rule is run as part of the pipeline
/// execution
/// for a pipeline configured with conditions.
pub const RuleExecution = struct {
    error_details: ?ErrorDetails = null,

    /// The external ID of the run of the rule.
    external_execution_id: ?[]const u8 = null,

    /// The URL of a resource external to Amazon Web Services that is used when
    /// running the
    /// rule (for example, an external repository URL).
    external_execution_url: ?[]const u8 = null,

    /// The last status change of the rule.
    last_status_change: ?i64 = null,

    /// The ARN of the user who last changed the rule.
    last_updated_by: ?[]const u8 = null,

    /// The execution ID for the run of the rule.
    rule_execution_id: ?[]const u8 = null,

    /// The status of the run of the rule, such as FAILED.
    status: ?RuleExecutionStatus = null,

    /// A summary of the run of the rule.
    summary: ?[]const u8 = null,

    /// The system-generated token used to identify a unique request.
    token: ?[]const u8 = null,

    pub const json_field_names = .{
        .error_details = "errorDetails",
        .external_execution_id = "externalExecutionId",
        .external_execution_url = "externalExecutionUrl",
        .last_status_change = "lastStatusChange",
        .last_updated_by = "lastUpdatedBy",
        .rule_execution_id = "ruleExecutionId",
        .status = "status",
        .summary = "summary",
        .token = "token",
    };
};
