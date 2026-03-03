const FlowExecutionStatus = @import("flow_execution_status.zig").FlowExecutionStatus;

/// Contains summary information about a flow execution, including its status,
/// timestamps, and identifiers.
///
/// Flow executions is in preview release for Amazon Bedrock and is subject to
/// change.
pub const FlowExecutionSummary = struct {
    /// The timestamp when the flow execution was created.
    created_at: i64,

    /// The timestamp when the flow execution ended. This field is only populated
    /// when the execution has completed, failed, timed out, or been aborted.
    ended_at: ?i64 = null,

    /// The Amazon Resource Name (ARN) that uniquely identifies the flow execution.
    execution_arn: []const u8,

    /// The unique identifier of the flow alias used for the execution.
    flow_alias_identifier: []const u8,

    /// The unique identifier of the flow.
    flow_identifier: []const u8,

    /// The version of the flow used for the execution.
    flow_version: []const u8,

    /// The current status of the flow execution.
    ///
    /// Flow executions time out after 24 hours.
    status: FlowExecutionStatus,

    pub const json_field_names = .{
        .created_at = "createdAt",
        .ended_at = "endedAt",
        .execution_arn = "executionArn",
        .flow_alias_identifier = "flowAliasIdentifier",
        .flow_identifier = "flowIdentifier",
        .flow_version = "flowVersion",
        .status = "status",
    };
};
