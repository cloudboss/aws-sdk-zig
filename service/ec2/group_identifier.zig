/// Describes a security group.
pub const GroupIdentifier = struct {
    /// The ID of the security group.
    group_id: ?[]const u8 = null,

    /// The name of the security group.
    group_name: ?[]const u8 = null,
};
