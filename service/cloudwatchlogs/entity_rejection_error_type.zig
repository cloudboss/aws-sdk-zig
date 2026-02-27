pub const EntityRejectionErrorType = enum {
    invalid_entity,
    invalid_type_value,
    invalid_key_attribute,
    invalid_attributes,
    entity_size_too_large,
    unsupported_log_group_type,
    missing_required_fields,

    pub const json_field_names = .{
        .invalid_entity = "INVALID_ENTITY",
        .invalid_type_value = "INVALID_TYPE_VALUE",
        .invalid_key_attribute = "INVALID_KEY_ATTRIBUTE",
        .invalid_attributes = "INVALID_ATTRIBUTES",
        .entity_size_too_large = "ENTITY_SIZE_TOO_LARGE",
        .unsupported_log_group_type = "UNSUPPORTED_LOG_GROUP_TYPE",
        .missing_required_fields = "MISSING_REQUIRED_FIELDS",
    };
};
