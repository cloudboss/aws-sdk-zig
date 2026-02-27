pub const GovernanceType = enum {
    aws_managed,
    user_managed,

    pub const json_field_names = .{
        .aws_managed = "AWS_MANAGED",
        .user_managed = "USER_MANAGED",
    };
};
