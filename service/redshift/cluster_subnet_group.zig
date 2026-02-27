const Subnet = @import("subnet.zig").Subnet;
const Tag = @import("tag.zig").Tag;

/// Describes a subnet group.
pub const ClusterSubnetGroup = struct {
    /// The name of the cluster subnet group.
    cluster_subnet_group_name: ?[]const u8,

    /// The description of the cluster subnet group.
    description: ?[]const u8,

    /// The status of the cluster subnet group. Possible values are `Complete`,
    /// `Incomplete` and `Invalid`.
    subnet_group_status: ?[]const u8,

    /// A list of the VPC Subnet elements.
    subnets: ?[]const Subnet,

    /// The IP address types supported by this cluster subnet group. Possible values
    /// are `ipv4` and `dualstack`.
    supported_cluster_ip_address_types: ?[]const []const u8,

    /// The list of tags for the cluster subnet group.
    tags: ?[]const Tag,

    /// The VPC ID of the cluster subnet group.
    vpc_id: ?[]const u8,
};
