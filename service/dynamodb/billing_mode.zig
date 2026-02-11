pub const BillingMode = enum {
    provisioned,
    pay_per_request,

    pub const json_field_names = .{
        .provisioned = "PROVISIONED",
        .pay_per_request = "PAY_PER_REQUEST",
    };
};
