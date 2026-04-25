const HarnessAgentCoreRuntimeEnvironment = @import("harness_agent_core_runtime_environment.zig").HarnessAgentCoreRuntimeEnvironment;

/// The environment provider for a harness.
pub const HarnessEnvironmentProvider = union(enum) {
    /// The AgentCore Runtime environment configuration.
    agent_core_runtime_environment: ?HarnessAgentCoreRuntimeEnvironment,

    pub const json_field_names = .{
        .agent_core_runtime_environment = "agentCoreRuntimeEnvironment",
    };
};
