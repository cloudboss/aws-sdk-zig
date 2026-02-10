/// Describes a security group.
pub const SecurityGroupIdentifier = struct {
    /// The ID of the security group.
    group_id: ?[]const u8,

    /// The name of the security group.
    group_name: ?[]const u8,
};
