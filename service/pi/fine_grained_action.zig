pub const FineGrainedAction = enum {
    describe_dimension_keys,
    get_dimension_key_details,
    get_resource_metrics,

    pub const json_field_names = .{
        .describe_dimension_keys = "DESCRIBE_DIMENSION_KEYS",
        .get_dimension_key_details = "GET_DIMENSION_KEY_DETAILS",
        .get_resource_metrics = "GET_RESOURCE_METRICS",
    };
};
