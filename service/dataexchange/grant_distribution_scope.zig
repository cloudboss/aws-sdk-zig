pub const GrantDistributionScope = enum {
    aws_organization,
    none,

    pub const json_field_names = .{
        .aws_organization = "AWS_ORGANIZATION",
        .none = "NONE",
    };
};
