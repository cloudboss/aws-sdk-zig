const Category = @import("category.zig").Category;
const TaskExecutionStatus = @import("task_execution_status.zig").TaskExecutionStatus;
const LogLocation = @import("log_location.zig").LogLocation;
const RiskType = @import("risk_type.zig").RiskType;
const Endpoint = @import("endpoint.zig").Endpoint;

/// Represents an individual security test task within a pentest job. Each task
/// targets a specific risk type or endpoint and executes independently.
pub const Task = struct {
    /// The unique identifier of the agent space.
    agent_space_id: ?[]const u8 = null,

    /// The list of categories assigned to the task.
    categories: ?[]const Category = null,

    /// The date and time the task was created, in UTC format.
    created_at: ?i64 = null,

    /// A description of the task.
    description: ?[]const u8 = null,

    /// The current execution status of the task.
    execution_status: ?TaskExecutionStatus = null,

    /// The location of the task execution logs.
    logs_location: ?LogLocation = null,

    /// The unique identifier of the pentest associated with the task.
    pentest_id: ?[]const u8 = null,

    /// The unique identifier of the pentest job that contains the task.
    pentest_job_id: ?[]const u8 = null,

    /// The type of security risk the task is testing for.
    risk_type: ?RiskType = null,

    /// The target endpoint being tested by the task.
    target_endpoint: ?Endpoint = null,

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
        .categories = "categories",
        .created_at = "createdAt",
        .description = "description",
        .execution_status = "executionStatus",
        .logs_location = "logsLocation",
        .pentest_id = "pentestId",
        .pentest_job_id = "pentestJobId",
        .risk_type = "riskType",
        .target_endpoint = "targetEndpoint",
        .task_hours = "taskHours",
        .task_id = "taskId",
        .title = "title",
        .updated_at = "updatedAt",
    };
};
