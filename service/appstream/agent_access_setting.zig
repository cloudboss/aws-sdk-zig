const AgentAction = @import("agent_action.zig").AgentAction;
const Permission = @import("permission.zig").Permission;

/// A permission setting for an agent action. Each setting specifies an agent
/// action and whether it is enabled or disabled.
pub const AgentAccessSetting = struct {
    /// The agent action to configure. Valid values are COMPUTER_VISION and
    /// COMPUTER_INPUT. If you enable COMPUTER_INPUT, you must also enable
    /// COMPUTER_VISION.
    agent_action: AgentAction,

    /// Whether the agent action is enabled or disabled.
    permission: Permission,

    pub const json_field_names = .{
        .agent_action = "AgentAction",
        .permission = "Permission",
    };
};
