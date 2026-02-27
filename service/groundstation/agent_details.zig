const ComponentVersion = @import("component_version.zig").ComponentVersion;

/// Detailed information about the agent.
pub const AgentDetails = struct {
    /// List of CPU cores reserved for the agent.
    agent_cpu_cores: ?[]const i32,

    /// Current agent version.
    agent_version: []const u8,

    /// List of versions being used by agent components.
    component_versions: []const ComponentVersion,

    /// ID of EC2 instance agent is running on.
    instance_id: []const u8,

    /// Type of EC2 instance agent is running on.
    instance_type: []const u8,

    /// This field should not be used. Use agentCpuCores instead.
    ///
    /// List of CPU cores reserved for processes other than the agent running on the
    /// EC2 instance.
    reserved_cpu_cores: ?[]const i32,

    pub const json_field_names = .{
        .agent_cpu_cores = "agentCpuCores",
        .agent_version = "agentVersion",
        .component_versions = "componentVersions",
        .instance_id = "instanceId",
        .instance_type = "instanceType",
        .reserved_cpu_cores = "reservedCpuCores",
    };
};
