pub const SettingType = enum {
    user,
    aws_managed,

    pub const json_field_names = .{
        .user = "USER",
        .aws_managed = "AWS_MANAGED",
    };
};
