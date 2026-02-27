pub const IntentSortAttribute = enum {
    intent_name,
    last_updated_date_time,

    pub const json_field_names = .{
        .intent_name = "IntentName",
        .last_updated_date_time = "LastUpdatedDateTime",
    };
};
