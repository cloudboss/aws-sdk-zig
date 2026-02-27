pub const UserProfileType = enum {
    iam,
    sso,

    pub const json_field_names = .{
        .iam = "IAM",
        .sso = "SSO",
    };
};
