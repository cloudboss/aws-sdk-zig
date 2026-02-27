pub const RedshiftProvisionedAuthType = enum {
    iam,
    username_password,
    username,

    pub const json_field_names = .{
        .iam = "IAM",
        .username_password = "USERNAME_PASSWORD",
        .username = "USERNAME",
    };
};
