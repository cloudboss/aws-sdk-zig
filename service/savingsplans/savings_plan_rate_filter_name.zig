pub const SavingsPlanRateFilterName = enum {
    region,
    instance_type,
    product_description,
    tenancy,
    product_type,
    service_code,
    usage_type,
    operation,

    pub const json_field_names = .{
        .region = "REGION",
        .instance_type = "INSTANCE_TYPE",
        .product_description = "PRODUCT_DESCRIPTION",
        .tenancy = "TENANCY",
        .product_type = "PRODUCT_TYPE",
        .service_code = "SERVICE_CODE",
        .usage_type = "USAGE_TYPE",
        .operation = "OPERATION",
    };
};
