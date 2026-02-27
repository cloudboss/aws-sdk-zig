pub const UserType = enum {
    iam_user,
    iam_role,
    sso_user,

    pub const json_field_names = .{
        .iam_user = "IAM_USER",
        .iam_role = "IAM_ROLE",
        .sso_user = "SSO_USER",
    };
};
