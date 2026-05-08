const RuntimeTargetConfiguration = @import("runtime_target_configuration.zig").RuntimeTargetConfiguration;

/// The HTTP target configuration for a gateway target. Contains the
/// configuration for HTTP-based target endpoints.
pub const HttpTargetConfiguration = union(enum) {
    /// The AgentCore Runtime target configuration for HTTP-based communication with
    /// an agent runtime.
    agentcore_runtime: ?RuntimeTargetConfiguration,

    pub const json_field_names = .{
        .agentcore_runtime = "agentcoreRuntime",
    };
};
