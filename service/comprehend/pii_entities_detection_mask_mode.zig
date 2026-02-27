pub const PiiEntitiesDetectionMaskMode = enum {
    mask,
    replace_with_pii_entity_type,

    pub const json_field_names = .{
        .mask = "MASK",
        .replace_with_pii_entity_type = "REPLACE_WITH_PII_ENTITY_TYPE",
    };
};
