/// Identifies a user or group from IAM Identity Center.
pub const IdentityCenterPrincipal = union(enum) {
    /// The unique identifier of a group in IAM Identity Center.
    group_id: ?[]const u8,
    /// The unique identifier of a user in IAM Identity Center.
    user_id: ?[]const u8,

    pub const json_field_names = .{
        .group_id = "groupId",
        .user_id = "userId",
    };
};
