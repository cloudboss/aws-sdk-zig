const HarnessAgentCoreMemoryConfiguration = @import("harness_agent_core_memory_configuration.zig").HarnessAgentCoreMemoryConfiguration;

/// The memory configuration for a harness.
pub const HarnessMemoryConfiguration = union(enum) {
    /// The AgentCore Memory configuration.
    agent_core_memory_configuration: ?HarnessAgentCoreMemoryConfiguration,

    pub const json_field_names = .{
        .agent_core_memory_configuration = "agentCoreMemoryConfiguration",
    };
};
