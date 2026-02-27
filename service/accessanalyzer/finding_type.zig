pub const FindingType = enum {
    external_access,
    unused_iam_role,
    unused_iam_user_access_key,
    unused_iam_user_password,
    unused_permission,
    internal_access,

    pub const json_field_names = .{
        .external_access = "EXTERNAL_ACCESS",
        .unused_iam_role = "UNUSED_IAM_ROLE",
        .unused_iam_user_access_key = "UNUSED_IAM_USER_ACCESS_KEY",
        .unused_iam_user_password = "UNUSED_IAM_USER_PASSWORD",
        .unused_permission = "UNUSED_PERMISSION",
        .internal_access = "INTERNAL_ACCESS",
    };
};
