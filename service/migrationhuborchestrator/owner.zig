pub const Owner = enum {
    aws_managed,
    custom,

    pub const json_field_names = .{
        .aws_managed = "AWSManaged",
        .custom = "CUSTOM",
    };
};
