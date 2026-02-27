pub const FieldValidationCode = enum {
    required_field_missing,
    duplicate_value,
    invalid_value,
    invalid_string_format,
    too_many_values,
    action_not_permitted,
    invalid_enum_value,

    pub const json_field_names = .{
        .required_field_missing = "REQUIRED_FIELD_MISSING",
        .duplicate_value = "DUPLICATE_VALUE",
        .invalid_value = "INVALID_VALUE",
        .invalid_string_format = "INVALID_STRING_FORMAT",
        .too_many_values = "TOO_MANY_VALUES",
        .action_not_permitted = "ACTION_NOT_PERMITTED",
        .invalid_enum_value = "INVALID_ENUM_VALUE",
    };
};
