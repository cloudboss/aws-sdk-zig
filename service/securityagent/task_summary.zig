const TaskExecutionStatus = @import("task_execution_status.zig").TaskExecutionStatus;
const RiskType = @import("risk_type.zig").RiskType;

/// Contains summary information about a task.
pub const TaskSummary = struct {
    /// The unique identifier of the agent space.
    agent_space_id: ?[]const u8 = null,

    /// The date and time the task was created, in UTC format.
    created_at: ?i64 = null,

    /// The current execution status of the task.
    execution_status: ?TaskExecutionStatus = null,

    /// The unique identifier of the pentest associated with the task.
    pentest_id: ?[]const u8 = null,

    /// The unique identifier of the pentest job that contains the task.
    pentest_job_id: ?[]const u8 = null,

    /// The type of security risk the task is testing for.
    risk_type: ?RiskType = null,

    /// The number of active work hours consumed by the task during execution.
    task_hours: ?f64 = null,

    /// The unique identifier of the task.
    task_id: []const u8,

    /// The title of the task.
    title: ?[]const u8 = null,

    /// The date and time the task was last updated, in UTC format.
    updated_at: ?i64 = null,

    pub const json_field_names = .{
        .agent_space_id = "agentSpaceId",
        .created_at = "createdAt",
        .execution_status = "executionStatus",
        .pentest_id = "pentestId",
        .pentest_job_id = "pentestJobId",
        .risk_type = "riskType",
        .task_hours = "taskHours",
        .task_id = "taskId",
        .title = "title",
        .updated_at = "updatedAt",
    };
};
