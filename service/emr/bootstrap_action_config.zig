const ScriptBootstrapActionConfig = @import("script_bootstrap_action_config.zig").ScriptBootstrapActionConfig;

/// Configuration of a bootstrap action.
pub const BootstrapActionConfig = struct {
    /// The name of the bootstrap action.
    name: []const u8,

    /// The script run by the bootstrap action.
    script_bootstrap_action: ScriptBootstrapActionConfig,

    pub const json_field_names = .{
        .name = "Name",
        .script_bootstrap_action = "ScriptBootstrapAction",
    };
};
