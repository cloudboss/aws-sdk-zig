pub const SavingsPlanRatePropertyKey = enum {
    region,
    instance_type,
    instance_family,
    product_description,
    tenancy,

    pub const json_field_names = .{
        .region = "REGION",
        .instance_type = "INSTANCE_TYPE",
        .instance_family = "INSTANCE_FAMILY",
        .product_description = "PRODUCT_DESCRIPTION",
        .tenancy = "TENANCY",
    };
};
