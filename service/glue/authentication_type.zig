pub const AuthenticationType = enum {
    basic,
    oauth2,
    custom,
    iam,

    pub const json_field_names = .{
        .basic = "BASIC",
        .oauth2 = "OAUTH2",
        .custom = "CUSTOM",
        .iam = "IAM",
    };
};
