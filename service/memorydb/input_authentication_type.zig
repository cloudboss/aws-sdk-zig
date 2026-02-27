pub const InputAuthenticationType = enum {
    password,
    iam,

    pub const json_field_names = .{
        .password = "PASSWORD",
        .iam = "IAM",
    };
};
