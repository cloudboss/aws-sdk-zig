pub const UserSearchType = enum {
    sso_user,
    datazone_user,
    datazone_sso_user,
    datazone_iam_user,

    pub const json_field_names = .{
        .sso_user = "SSO_USER",
        .datazone_user = "DATAZONE_USER",
        .datazone_sso_user = "DATAZONE_SSO_USER",
        .datazone_iam_user = "DATAZONE_IAM_USER",
    };
};
