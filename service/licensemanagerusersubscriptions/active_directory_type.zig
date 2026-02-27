pub const ActiveDirectoryType = enum {
    /// SELF_MANAGED type of Active Directory
    self_managed,
    /// AWS_MANAGED type of Active Directory
    aws_managed,

    pub const json_field_names = .{
        .self_managed = "SELF_MANAGED",
        .aws_managed = "AWS_MANAGED",
    };
};
