pub const IdentityType = enum {
    user,
    group,
    iam,

    pub const json_field_names = .{
        .user = "USER",
        .group = "GROUP",
        .iam = "IAM",
    };
};
