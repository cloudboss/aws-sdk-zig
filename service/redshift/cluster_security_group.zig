const EC2SecurityGroup = @import("ec2_security_group.zig").EC2SecurityGroup;
const IPRange = @import("ip_range.zig").IPRange;
const Tag = @import("tag.zig").Tag;

/// Describes a security group.
pub const ClusterSecurityGroup = struct {
    /// The name of the cluster security group to which the operation was
    /// applied.
    cluster_security_group_name: ?[]const u8,

    /// A description of the security group.
    description: ?[]const u8,

    /// A list of EC2 security groups that are permitted to access clusters
    /// associated with
    /// this cluster security group.
    ec2_security_groups: ?[]const EC2SecurityGroup,

    /// A list of IP ranges (CIDR blocks) that are permitted to access clusters
    /// associated
    /// with this cluster security group.
    ip_ranges: ?[]const IPRange,

    /// The list of tags for the cluster security group.
    tags: ?[]const Tag,
};
