const RecommendationContent = @import("recommendation_content.zig").RecommendationContent;
const RecommendationPriority = @import("recommendation_priority.zig").RecommendationPriority;
const RecommendationStatus = @import("recommendation_status.zig").RecommendationStatus;

/// Represents a recommendation with all its properties and metadata
pub const Recommendation = struct {
    /// Additional context for recommendation
    additional_context: ?[]const u8 = null,

    /// ARN of the agent space this recommendation belongs to
    agent_space_arn: []const u8,

    /// Content of the recommendation
    content: RecommendationContent,

    /// Timestamp when this recommendation was created
    created_at: i64,

    /// ID of the goal this recommendation is associated with
    goal_id: ?[]const u8 = null,

    /// Version of the goal at the time this recommendation was generated
    goal_version: ?i64 = null,

    /// Priority level of the recommendation
    priority: RecommendationPriority,

    /// Timestamp when the recommendation was last ranked
    ranked_at: ?i64 = null,

    /// Position in ranked list (1 = highest priority)
    rank_position: ?i32 = null,

    /// The unique identifier for this recommendation
    recommendation_id: []const u8,

    /// Current status of the recommendation
    status: RecommendationStatus,

    /// ID of the task that generated the recommendation
    task_id: []const u8,

    /// The title of the recommendation
    title: []const u8,

    /// Timestamp when this recommendation was last updated
    updated_at: i64,

    /// Version number for optimistic locking
    version: i64,

    pub const json_field_names = .{
        .additional_context = "additionalContext",
        .agent_space_arn = "agentSpaceArn",
        .content = "content",
        .created_at = "createdAt",
        .goal_id = "goalId",
        .goal_version = "goalVersion",
        .priority = "priority",
        .ranked_at = "rankedAt",
        .rank_position = "rankPosition",
        .recommendation_id = "recommendationId",
        .status = "status",
        .task_id = "taskId",
        .title = "title",
        .updated_at = "updatedAt",
        .version = "version",
    };
};
