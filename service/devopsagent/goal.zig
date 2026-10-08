const GoalContent = @import("goal_content.zig").GoalContent;
const GoalSchedule = @import("goal_schedule.zig").GoalSchedule;
const GoalType = @import("goal_type.zig").GoalType;
const GoalStatus = @import("goal_status.zig").GoalStatus;

/// Represents a goal with all its properties and metadata
pub const Goal = struct {
    /// The unique identifier for the agent space containing this goal
    agent_space_arn: []const u8,

    /// Content of the goal
    content: GoalContent,

    /// Timestamp when this goal was created
    created_at: i64,

    /// Goal Schedule. Allows to schedule the goal to run periodically, as well as
    /// disable a goal temporarily
    evaluation_schedule: ?GoalSchedule = null,

    /// The unique identifier for this goal
    goal_id: []const u8,

    /// Type of goal based on its origin
    goal_type: GoalType = .oncall_report,

    /// Timestamp when the goal was last evaluated
    last_evaluated_at: ?i64 = null,

    /// ID of the most recent successful task associated with this goal
    last_successful_task_id: ?[]const u8 = null,

    /// ID of the most recent task associated with this goal
    last_task_id: ?[]const u8 = null,

    /// Current status of the goal itself
    status: GoalStatus,

    /// The title of the goal
    title: []const u8,

    /// Timestamp when this goal was last updated
    updated_at: i64,

    /// Version number for optimistic locking
    version: i32,

    pub const json_field_names = .{
        .agent_space_arn = "agentSpaceArn",
        .content = "content",
        .created_at = "createdAt",
        .evaluation_schedule = "evaluationSchedule",
        .goal_id = "goalId",
        .goal_type = "goalType",
        .last_evaluated_at = "lastEvaluatedAt",
        .last_successful_task_id = "lastSuccessfulTaskId",
        .last_task_id = "lastTaskId",
        .status = "status",
        .title = "title",
        .updated_at = "updatedAt",
        .version = "version",
    };
};
