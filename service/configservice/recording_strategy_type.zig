pub const RecordingStrategyType = enum {
    all_supported_resource_types,
    inclusion_by_resource_types,
    exclusion_by_resource_types,

    pub const json_field_names = .{
        .all_supported_resource_types = "ALL_SUPPORTED_RESOURCE_TYPES",
        .inclusion_by_resource_types = "INCLUSION_BY_RESOURCE_TYPES",
        .exclusion_by_resource_types = "EXCLUSION_BY_RESOURCE_TYPES",
    };
};
