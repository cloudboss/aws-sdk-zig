const NetworkInterface = @import("network_interface.zig").NetworkInterface;
const Tag = @import("tag.zig").Tag;

/// A collection of attributes of the host from which the finding is generated.
pub const AssetAttributes = struct {
    /// The ID of the agent that is installed on the EC2 instance where the finding
    /// is
    /// generated.
    agent_id: ?[]const u8,

    /// The ID of the Amazon Machine Image (AMI) that is installed on the EC2
    /// instance where
    /// the finding is generated.
    ami_id: ?[]const u8,

    /// The Auto Scaling group of the EC2 instance where the finding is generated.
    auto_scaling_group: ?[]const u8,

    /// The hostname of the EC2 instance where the finding is generated.
    hostname: ?[]const u8,

    /// The list of IP v4 addresses of the EC2 instance where the finding is
    /// generated.
    ipv_4_addresses: ?[]const []const u8,

    /// An array of the network interfaces interacting with the EC2 instance where
    /// the
    /// finding is generated.
    network_interfaces: ?[]const NetworkInterface,

    /// The schema version of this data type.
    schema_version: i32 = 0,

    /// The tags related to the EC2 instance where the finding is generated.
    tags: ?[]const Tag,

    pub const json_field_names = .{
        .agent_id = "agentId",
        .ami_id = "amiId",
        .auto_scaling_group = "autoScalingGroup",
        .hostname = "hostname",
        .ipv_4_addresses = "ipv4Addresses",
        .network_interfaces = "networkInterfaces",
        .schema_version = "schemaVersion",
        .tags = "tags",
    };
};
