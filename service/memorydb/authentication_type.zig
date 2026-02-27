pub const AuthenticationType = enum {
    password,
    no_password,
    iam,

    pub const json_field_names = .{
        .password = "PASSWORD",
        .no_password = "NO_PASSWORD",
        .iam = "IAM",
    };
};
