pub const DatabaseManagementPreference = enum {
    aws_managed,
    self_manage,
    no_preference,

    pub const json_field_names = .{
        .aws_managed = "AWS_MANAGED",
        .self_manage = "SELF_MANAGE",
        .no_preference = "NO_PREFERENCE",
    };
};
