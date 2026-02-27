pub const CustomerAgreementState = enum {
    active,
    customer_terminated,
    aws_terminated,

    pub const json_field_names = .{
        .active = "ACTIVE",
        .customer_terminated = "CUSTOMER_TERMINATED",
        .aws_terminated = "AWS_TERMINATED",
    };
};
