pub const TemplateErrorType = enum {
    source_not_found,
    data_set_not_found,
    internal_failure,
    access_denied,

    pub const json_field_names = .{
        .source_not_found = "SOURCE_NOT_FOUND",
        .data_set_not_found = "DATA_SET_NOT_FOUND",
        .internal_failure = "INTERNAL_FAILURE",
        .access_denied = "ACCESS_DENIED",
    };
};
