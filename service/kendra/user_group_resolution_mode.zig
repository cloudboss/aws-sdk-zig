pub const UserGroupResolutionMode = enum {
    aws_sso,
    none,

    pub const json_field_names = .{
        .aws_sso = "AWS_SSO",
        .none = "NONE",
    };
};
