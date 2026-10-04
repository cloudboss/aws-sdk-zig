const HarnessAgentCoreMemoryConfiguration = @import("harness_agent_core_memory_configuration.zig").HarnessAgentCoreMemoryConfiguration;
const HarnessDisabledMemoryConfiguration = @import("harness_disabled_memory_configuration.zig").HarnessDisabledMemoryConfiguration;
const HarnessManagedMemoryConfiguration = @import("harness_managed_memory_configuration.zig").HarnessManagedMemoryConfiguration;

/// The memory configuration for a harness.
pub const HarnessMemoryConfiguration = union(enum) {
    /// The AgentCore Memory configuration.
    agent_core_memory_configuration: ?HarnessAgentCoreMemoryConfiguration,
    /// Explicitly opt out of memory.
    disabled: ?HarnessDisabledMemoryConfiguration,
    /// Harness creates and manages a memory resource in the customer's account.
    managed_memory_configuration: ?HarnessManagedMemoryConfiguration,

    pub const json_field_names = .{
        .agent_core_memory_configuration = "agentCoreMemoryConfiguration",
        .disabled = "disabled",
        .managed_memory_configuration = "managedMemoryConfiguration",
    };
};
