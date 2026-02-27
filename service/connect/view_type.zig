pub const ViewType = enum {
    customer_managed,
    aws_managed,

    pub const json_field_names = .{
        .customer_managed = "CUSTOMER_MANAGED",
        .aws_managed = "AWS_MANAGED",
    };
};
