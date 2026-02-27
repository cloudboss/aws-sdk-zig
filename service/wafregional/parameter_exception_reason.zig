pub const ParameterExceptionReason = enum {
    invalid_option,
    illegal_combination,
    illegal_argument,
    invalid_tag_key,

    pub const json_field_names = .{
        .invalid_option = "INVALID_OPTION",
        .illegal_combination = "ILLEGAL_COMBINATION",
        .illegal_argument = "ILLEGAL_ARGUMENT",
        .invalid_tag_key = "INVALID_TAG_KEY",
    };
};
