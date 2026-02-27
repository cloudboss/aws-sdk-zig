pub const SsoIdentityType = enum {
    sso_user,
    sso_group,

    pub const json_field_names = .{
        .sso_user = "SSO_USER",
        .sso_group = "SSO_GROUP",
    };
};
