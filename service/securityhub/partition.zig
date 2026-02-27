pub const Partition = enum {
    aws,
    aws_cn,
    aws_us_gov,

    pub const json_field_names = .{
        .aws = "AWS",
        .aws_cn = "AWS_CN",
        .aws_us_gov = "AWS_US_GOV",
    };
};
