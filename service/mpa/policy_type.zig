pub const PolicyType = enum {
    aws_managed,
    aws_ram,

    pub const json_field_names = .{
        .aws_managed = "AWS_MANAGED",
        .aws_ram = "AWS_RAM",
    };
};
