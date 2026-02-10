const IpPermission = @import("ip_permission.zig").IpPermission;
const Tag = @import("tag.zig").Tag;

/// Describes a security group.
pub const SecurityGroup = struct {
    /// A description of the security group.
    description: ?[]const u8,

    /// The ID of the security group.
    group_id: ?[]const u8,

    /// The name of the security group.
    group_name: ?[]const u8,

    /// The inbound rules associated with the security group.
    ip_permissions: ?[]const IpPermission,

    /// The outbound rules associated with the security group.
    ip_permissions_egress: ?[]const IpPermission,

    /// The Amazon Web Services account ID of the owner of the security group.
    owner_id: ?[]const u8,

    /// The ARN of the security group.
    security_group_arn: ?[]const u8,

    /// Any tags assigned to the security group.
    tags: ?[]const Tag,

    /// The ID of the VPC for the security group.
    vpc_id: ?[]const u8,
};
