const Tag = @import("tag.zig").Tag;

/// Describes an Amazon EC2 security group.
pub const EC2SecurityGroup = struct {
    /// The name of the EC2 Security Group.
    ec2_security_group_name: ?[]const u8 = null,

    /// The Amazon Web Services account ID of the owner of the EC2 security group
    /// specified in the
    /// `EC2SecurityGroupName` field.
    ec2_security_group_owner_id: ?[]const u8 = null,

    /// The status of the EC2 security group.
    status: ?[]const u8 = null,

    /// The list of tags for the EC2 security group.
    tags: ?[]const Tag = null,
};
