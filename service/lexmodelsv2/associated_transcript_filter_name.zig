pub const AssociatedTranscriptFilterName = enum {
    intent_id,
    slot_type_id,

    pub const json_field_names = .{
        .intent_id = "IntentId",
        .slot_type_id = "SlotTypeId",
    };
};
