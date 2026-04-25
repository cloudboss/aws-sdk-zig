const HarnessAgentCoreRuntimeEnvironmentRequest = @import("harness_agent_core_runtime_environment_request.zig").HarnessAgentCoreRuntimeEnvironmentRequest;

/// The environment provider request configuration.
pub const HarnessEnvironmentProviderRequest = union(enum) {
    /// The AgentCore Runtime environment configuration.
    agent_core_runtime_environment: ?HarnessAgentCoreRuntimeEnvironmentRequest,

    pub const json_field_names = .{
        .agent_core_runtime_environment = "agentCoreRuntimeEnvironment",
    };
};
