pub const ValidationExceptionReason = enum {
    invalid_page_token,
    invalid_parameter_value,

    pub const json_field_names = .{
        .invalid_page_token = "INVALID_PAGE_TOKEN",
        .invalid_parameter_value = "INVALID_PARAMETER_VALUE",
    };
};
