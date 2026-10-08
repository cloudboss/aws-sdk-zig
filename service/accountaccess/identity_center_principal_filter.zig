/// Specifies filter criteria for an IAM Identity Center principal.
pub const IdentityCenterPrincipalFilter = union(enum) {
    /// The unique identifier of a group in IAM Identity Center to filter by.
    group_id: ?[]const u8,
    /// The unique identifier of a user in IAM Identity Center to filter by.
    user_id: ?[]const u8,

    pub const json_field_names = .{
        .group_id = "groupId",
        .user_id = "userId",
    };
};
