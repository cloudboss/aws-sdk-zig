pub const PrincipalType = enum {
    iam_role,
    iam_user,

    pub const json_field_names = .{
        .iam_role = "IAM_ROLE",
        .iam_user = "IAM_USER",
    };
};
