pub const IncludedData = enum {
    all_data,
    metadata_only,

    pub const json_field_names = .{
        .all_data = "ALL_DATA",
        .metadata_only = "METADATA_ONLY",
    };
};
