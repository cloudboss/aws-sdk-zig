pub const PostgreSQLAuthenticationMethod = enum {
    password,
    iam,

    pub const json_field_names = .{
        .password = "Password",
        .iam = "IAM",
    };
};
