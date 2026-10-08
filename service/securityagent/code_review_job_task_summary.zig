const TaskExecutionStatus = @import("task_execution_status.zig").TaskExecutionStatus;
const RiskType = @import("risk_type.zig").RiskType;

/// Contains summary information about a code review job task.
pub const CodeReviewJobTaskSummary = struct {
    /// The unique identifier of the agent space.
    agent_space_id: ?[]const u8 = null,

    /// The unique identifier of the code review associated with the task.
    code_review_id: ?[]const u8 = null,

    /// The unique identifier of the code review job that contains the task.
    code_review_job_id: ?[]const u8 = null,

    /// The date and time the task was created, in UTC format.
    created_at: ?i64 = null,

    /// The current execution status of the task.
    execution_status: ?TaskExecutionStatus = null,

    /// The type of security risk the task is testing for.
    risk_type: ?RiskType = null,

    /// The unique identifier of the task.
    task_id: []const u8,

    /// The title of the task.
    title: ?[]const u8 = null,

    /// The date and time the task was last updated, in UTC format.
    updated_at: ?i64 = null,

    pub const json_field_names = .{
        .agent_space_id = "agentSpaceId",
        .code_review_id = "codeReviewId",
        .code_review_job_id = "codeReviewJobId",
        .created_at = "createdAt",
        .execution_status = "executionStatus",
        .risk_type = "riskType",
        .task_id = "taskId",
        .title = "title",
        .updated_at = "updatedAt",
    };
};
