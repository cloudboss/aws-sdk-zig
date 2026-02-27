pub const SavingsPlanRateFilterAttribute = enum {
    region,
    instance_family,
    instance_type,
    product_description,
    tenancy,
    product_id,

    pub const json_field_names = .{
        .region = "REGION",
        .instance_family = "INSTANCE_FAMILY",
        .instance_type = "INSTANCE_TYPE",
        .product_description = "PRODUCT_DESCRIPTION",
        .tenancy = "TENANCY",
        .product_id = "PRODUCT_ID",
    };
};
