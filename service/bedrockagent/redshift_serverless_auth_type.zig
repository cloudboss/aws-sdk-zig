pub const RedshiftServerlessAuthType = enum {
    iam,
    username_password,

    pub const json_field_names = .{
        .iam = "IAM",
        .username_password = "USERNAME_PASSWORD",
    };
};
