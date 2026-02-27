pub const DomainType = enum {
    endpoint,
    aws_managed,
    customer_managed,

    pub const json_field_names = .{
        .endpoint = "ENDPOINT",
        .aws_managed = "AWS_MANAGED",
        .customer_managed = "CUSTOMER_MANAGED",
    };
};
