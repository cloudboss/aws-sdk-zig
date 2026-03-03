const ActionGroupState = @import("action_group_state.zig").ActionGroupState;

/// Contains details about an action group.
pub const ActionGroupSummary = struct {
    /// The unique identifier of the action group.
    action_group_id: []const u8,

    /// The name of the action group.
    action_group_name: []const u8,

    /// Specifies whether the action group is available for the agent to invoke or
    /// not when sending an
    /// [InvokeAgent](https://docs.aws.amazon.com/bedrock/latest/APIReference/API_agent-runtime_InvokeAgent.html) request.
    action_group_state: ActionGroupState,

    /// The description of the action group.
    description: ?[]const u8 = null,

    /// The time at which the action group was last updated.
    updated_at: i64,

    pub const json_field_names = .{
        .action_group_id = "actionGroupId",
        .action_group_name = "actionGroupName",
        .action_group_state = "actionGroupState",
        .description = "description",
        .updated_at = "updatedAt",
    };
};
