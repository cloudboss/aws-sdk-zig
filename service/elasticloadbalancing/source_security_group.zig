/// Information about a source security group.
pub const SourceSecurityGroup = struct {
    /// The name of the security group.
    group_name: ?[]const u8 = null,

    /// The owner of the security group.
    owner_alias: ?[]const u8 = null,
};
