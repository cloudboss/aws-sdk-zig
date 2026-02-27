/// The reason for which the configuration elements or attributes were
/// sanitized.
pub const SanitizationWarningReason = enum {
    disallowed_element_removed,
    disallowed_attribute_removed,
    invalid_attribute_value_removed,

    pub const json_field_names = .{
        .disallowed_element_removed = "DISALLOWED_ELEMENT_REMOVED",
        .disallowed_attribute_removed = "DISALLOWED_ATTRIBUTE_REMOVED",
        .invalid_attribute_value_removed = "INVALID_ATTRIBUTE_VALUE_REMOVED",
    };
};
