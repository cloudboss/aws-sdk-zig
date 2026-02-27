pub const SnowflakeDataLoadingOption = enum {
    json_mapping,
    variant_content_mapping,
    variant_content_and_metadata_mapping,

    pub const json_field_names = .{
        .json_mapping = "JSON_MAPPING",
        .variant_content_mapping = "VARIANT_CONTENT_MAPPING",
        .variant_content_and_metadata_mapping = "VARIANT_CONTENT_AND_METADATA_MAPPING",
    };
};
