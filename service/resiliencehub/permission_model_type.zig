pub const PermissionModelType = enum {
    legacy_iam_user,
    role_based,

    pub const json_field_names = .{
        .legacy_iam_user = "LEGACY_IAM_USER",
        .role_based = "ROLE_BASED",
    };
};
