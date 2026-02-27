pub const ColumnName = enum {
    alias,
    asset_id,
    property_id,
    data_type,
    timestamp_seconds,
    timestamp_nano_offset,
    quality,
    value,

    pub const json_field_names = .{
        .alias = "ALIAS",
        .asset_id = "ASSET_ID",
        .property_id = "PROPERTY_ID",
        .data_type = "DATA_TYPE",
        .timestamp_seconds = "TIMESTAMP_SECONDS",
        .timestamp_nano_offset = "TIMESTAMP_NANO_OFFSET",
        .quality = "QUALITY",
        .value = "VALUE",
    };
};
