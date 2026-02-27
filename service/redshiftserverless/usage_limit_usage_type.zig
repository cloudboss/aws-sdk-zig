pub const UsageLimitUsageType = enum {
    serverless_compute,
    cross_region_datasharing,

    pub const json_field_names = .{
        .serverless_compute = "SERVERLESS_COMPUTE",
        .cross_region_datasharing = "CROSS_REGION_DATASHARING",
    };
};
