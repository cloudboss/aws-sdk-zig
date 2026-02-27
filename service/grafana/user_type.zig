pub const UserType = enum {
    /// SSO user.
    sso_user,
    /// SSO group.
    sso_group,

    pub const json_field_names = .{
        .sso_user = "SSO_USER",
        .sso_group = "SSO_GROUP",
    };
};
