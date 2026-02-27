pub const SlotSortAttribute = enum {
    slot_name,
    last_updated_date_time,

    pub const json_field_names = .{
        .slot_name = "SlotName",
        .last_updated_date_time = "LastUpdatedDateTime",
    };
};
