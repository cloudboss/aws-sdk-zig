pub const PermissionTypeFilter = enum {
    all,
    aws_managed,
    customer_managed,

    pub const json_field_names = .{
        .all = "ALL",
        .aws_managed = "AWS_MANAGED",
        .customer_managed = "CUSTOMER_MANAGED",
    };
};
