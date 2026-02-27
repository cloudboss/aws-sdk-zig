const AgentHealth = @import("agent_health.zig").AgentHealth;

/// Used as a response element in the PreviewAgents action.
pub const AgentPreview = struct {
    /// The health status of the Amazon Inspector Agent.
    agent_health: ?AgentHealth,

    /// The ID of the EC2 instance where the agent is installed.
    agent_id: []const u8,

    /// The version of the Amazon Inspector Agent.
    agent_version: ?[]const u8,

    /// The Auto Scaling group for the EC2 instance where the agent is installed.
    auto_scaling_group: ?[]const u8,

    /// The hostname of the EC2 instance on which the Amazon Inspector Agent is
    /// installed.
    hostname: ?[]const u8,

    /// The IP address of the EC2 instance on which the Amazon Inspector Agent is
    /// installed.
    ipv_4_address: ?[]const u8,

    /// The kernel version of the operating system running on the EC2 instance on
    /// which the
    /// Amazon Inspector Agent is installed.
    kernel_version: ?[]const u8,

    /// The operating system running on the EC2 instance on which the Amazon
    /// Inspector Agent
    /// is installed.
    operating_system: ?[]const u8,

    pub const json_field_names = .{
        .agent_health = "agentHealth",
        .agent_id = "agentId",
        .agent_version = "agentVersion",
        .auto_scaling_group = "autoScalingGroup",
        .hostname = "hostname",
        .ipv_4_address = "ipv4Address",
        .kernel_version = "kernelVersion",
        .operating_system = "operatingSystem",
    };
};
