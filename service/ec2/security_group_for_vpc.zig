const Tag = @import("tag.zig").Tag;

/// A security group that can be used by interfaces in the VPC.
pub const SecurityGroupForVpc = struct {
    /// The security group's description.
    description: ?[]const u8,

    /// The security group ID.
    group_id: ?[]const u8,

    /// The security group name.
    group_name: ?[]const u8,

    /// The security group owner ID.
    owner_id: ?[]const u8,

    /// The VPC ID in which the security group was created.
    primary_vpc_id: ?[]const u8,

    /// The security group tags.
    tags: ?[]const Tag,
};
