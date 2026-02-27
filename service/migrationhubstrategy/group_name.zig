pub const GroupName = enum {
    external_id,
    external_source_type,

    pub const json_field_names = .{
        .external_id = "EXTERNAL_ID",
        .external_source_type = "EXTERNAL_SOURCE_TYPE",
    };
};
