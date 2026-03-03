const ManagedStatus = @import("managed_status.zig").ManagedStatus;
const PlatformType = @import("platform_type.zig").PlatformType;
const ResourceType = @import("resource_type.zig").ResourceType;

/// Details about a specific managed node.
pub const InstanceInfo = struct {
    /// The type of agent installed on the node.
    agent_type: ?[]const u8 = null,

    /// The version number of the agent installed on the node.
    agent_version: ?[]const u8 = null,

    /// The fully qualified host name of the managed node.
    computer_name: ?[]const u8 = null,

    /// The current status of the managed node.
    instance_status: ?[]const u8 = null,

    /// The IP address of the managed node.
    ip_address: ?[]const u8 = null,

    /// Indicates whether the node is managed by Systems Manager.
    managed_status: ?ManagedStatus = null,

    /// The name of the operating system platform running on your managed node.
    platform_name: ?[]const u8 = null,

    /// The operating system platform type of the managed node.
    platform_type: ?PlatformType = null,

    /// The version of the OS platform running on your managed node.
    platform_version: ?[]const u8 = null,

    /// The type of instance, either an EC2 instance or another supported machine
    /// type in a hybrid
    /// fleet.
    resource_type: ?ResourceType = null,

    pub const json_field_names = .{
        .agent_type = "AgentType",
        .agent_version = "AgentVersion",
        .computer_name = "ComputerName",
        .instance_status = "InstanceStatus",
        .ip_address = "IpAddress",
        .managed_status = "ManagedStatus",
        .platform_name = "PlatformName",
        .platform_type = "PlatformType",
        .platform_version = "PlatformVersion",
        .resource_type = "ResourceType",
    };
};
