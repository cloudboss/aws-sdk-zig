const AgentlessDialerConfig = @import("agentless_dialer_config.zig").AgentlessDialerConfig;
const PredictiveDialerConfig = @import("predictive_dialer_config.zig").PredictiveDialerConfig;
const ProgressiveDialerConfig = @import("progressive_dialer_config.zig").ProgressiveDialerConfig;

/// The possible types of dialer config parameters
pub const DialerConfig = union(enum) {
    agentless_dialer_config: ?AgentlessDialerConfig,
    predictive_dialer_config: ?PredictiveDialerConfig,
    progressive_dialer_config: ?ProgressiveDialerConfig,

    pub const json_field_names = .{
        .agentless_dialer_config = "agentlessDialerConfig",
        .predictive_dialer_config = "predictiveDialerConfig",
        .progressive_dialer_config = "progressiveDialerConfig",
    };
};
