/// Specifies membership in a designated DB security group.
pub const DBSecurityGroupMembership = struct {
    /// The name of the DB security group.
    db_security_group_name: ?[]const u8,

    /// The status of the DB security group.
    status: ?[]const u8,
};
