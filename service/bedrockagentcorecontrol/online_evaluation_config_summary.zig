const OnlineEvaluationExecutionStatus = @import("online_evaluation_execution_status.zig").OnlineEvaluationExecutionStatus;
const OnlineEvaluationConfigStatus = @import("online_evaluation_config_status.zig").OnlineEvaluationConfigStatus;

/// The summary information about an online evaluation configuration, including
/// basic metadata and execution status.
pub const OnlineEvaluationConfigSummary = struct {
    /// The timestamp when the online evaluation configuration was created.
    created_at: i64,

    /// The description of the online evaluation configuration.
    description: ?[]const u8 = null,

    /// The execution status indicating whether the online evaluation is currently
    /// running.
    execution_status: OnlineEvaluationExecutionStatus,

    /// The reason for failure if the online evaluation configuration execution
    /// failed.
    failure_reason: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the online evaluation configuration.
    online_evaluation_config_arn: []const u8,

    /// The unique identifier of the online evaluation configuration.
    online_evaluation_config_id: []const u8,

    /// The name of the online evaluation configuration.
    online_evaluation_config_name: []const u8,

    /// The status of the online evaluation configuration.
    status: OnlineEvaluationConfigStatus,

    /// The timestamp when the online evaluation configuration was last updated.
    updated_at: i64,

    pub const json_field_names = .{
        .created_at = "createdAt",
        .description = "description",
        .execution_status = "executionStatus",
        .failure_reason = "failureReason",
        .online_evaluation_config_arn = "onlineEvaluationConfigArn",
        .online_evaluation_config_id = "onlineEvaluationConfigId",
        .online_evaluation_config_name = "onlineEvaluationConfigName",
        .status = "status",
        .updated_at = "updatedAt",
    };
};
