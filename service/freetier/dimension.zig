pub const Dimension = enum {
    service,
    operation,
    usage_type,
    region,
    free_tier_type,
    description,
    usage_percentage,

    pub const json_field_names = .{
        .service = "SERVICE",
        .operation = "OPERATION",
        .usage_type = "USAGE_TYPE",
        .region = "REGION",
        .free_tier_type = "FREE_TIER_TYPE",
        .description = "DESCRIPTION",
        .usage_percentage = "USAGE_PERCENTAGE",
    };
};
