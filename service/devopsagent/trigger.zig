const TriggerCondition = @import("trigger_condition.zig").TriggerCondition;

/// A Trigger fires on a schedule and invokes an agent
pub const Trigger = struct {
    /// The action this Trigger performs when it fires
    action: []const u8,

    /// The agent space this Trigger belongs to
    agent_space_id: []const u8,

    /// The condition that fires this Trigger
    condition: TriggerCondition,

    /// Timestamp when this Trigger was created
    created_at: i64,

    /// The status of this Trigger
    status: []const u8,

    /// The unique identifier for this Trigger
    trigger_id: []const u8,

    /// How this Trigger fires
    type: []const u8,

    /// Timestamp when this Trigger was last updated
    updated_at: i64,

    pub const json_field_names = .{
        .action = "action",
        .agent_space_id = "agentSpaceId",
        .condition = "condition",
        .created_at = "createdAt",
        .status = "status",
        .trigger_id = "triggerId",
        .type = "type",
        .updated_at = "updatedAt",
    };
};
