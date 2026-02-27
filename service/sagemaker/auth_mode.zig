pub const AuthMode = enum {
    sso,
    iam,

    pub const json_field_names = .{
        .sso = "SSO",
        .iam = "IAM",
    };
};
