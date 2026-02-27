pub const SlotTypeSortAttribute = enum {
    slot_type_name,
    last_updated_date_time,

    pub const json_field_names = .{
        .slot_type_name = "SlotTypeName",
        .last_updated_date_time = "LastUpdatedDateTime",
    };
};
