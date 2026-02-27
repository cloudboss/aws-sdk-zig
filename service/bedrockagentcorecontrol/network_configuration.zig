const NetworkMode = @import("network_mode.zig").NetworkMode;
const VpcConfig = @import("vpc_config.zig").VpcConfig;

/// SecurityConfig for the Agent.
pub const NetworkConfiguration = struct {
    /// The network mode for the AgentCore Runtime.
    network_mode: NetworkMode,

    /// The network mode configuration for the AgentCore Runtime.
    network_mode_config: ?VpcConfig,

    pub const json_field_names = .{
        .network_mode = "networkMode",
        .network_mode_config = "networkModeConfig",
    };
};
