pub const SlotTypeFilterName = enum {
    slot_type_name,
    external_source_type,

    pub const json_field_names = .{
        .slot_type_name = "SlotTypeName",
        .external_source_type = "ExternalSourceType",
    };
};
