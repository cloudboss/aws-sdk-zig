pub const DatasetType = enum {
    target_time_series,
    related_time_series,
    item_metadata,

    pub const json_field_names = .{
        .target_time_series = "TARGET_TIME_SERIES",
        .related_time_series = "RELATED_TIME_SERIES",
        .item_metadata = "ITEM_METADATA",
    };
};
