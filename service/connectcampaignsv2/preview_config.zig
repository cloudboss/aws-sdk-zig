const AgentAction = @import("agent_action.zig").AgentAction;
const TimeoutConfig = @import("timeout_config.zig").TimeoutConfig;

/// Preview config
pub const PreviewConfig = struct {
    agent_actions: ?[]const AgentAction = null,

    bandwidth_allocation: f64,

    timeout_config: TimeoutConfig,

    pub const json_field_names = .{
        .agent_actions = "agentActions",
        .bandwidth_allocation = "bandwidthAllocation",
        .timeout_config = "timeoutConfig",
    };
};
