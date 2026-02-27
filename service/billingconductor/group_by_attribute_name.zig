pub const GroupByAttributeName = enum {
    product_name,
    billing_period,

    pub const json_field_names = .{
        .product_name = "PRODUCT_NAME",
        .billing_period = "BILLING_PERIOD",
    };
};
