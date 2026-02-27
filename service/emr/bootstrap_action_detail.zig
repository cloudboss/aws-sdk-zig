const BootstrapActionConfig = @import("bootstrap_action_config.zig").BootstrapActionConfig;

/// Reports the configuration of a bootstrap action in a cluster (job flow).
pub const BootstrapActionDetail = struct {
    /// A description of the bootstrap action.
    bootstrap_action_config: ?BootstrapActionConfig,

    pub const json_field_names = .{
        .bootstrap_action_config = "BootstrapActionConfig",
    };
};
