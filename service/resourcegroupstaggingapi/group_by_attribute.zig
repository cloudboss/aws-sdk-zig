pub const GroupByAttribute = enum {
    target_id,
    region,
    resource_type,

    pub const json_field_names = .{
        .target_id = "TARGET_ID",
        .region = "REGION",
        .resource_type = "RESOURCE_TYPE",
    };
};
