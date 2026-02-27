pub const DashboardErrorType = enum {
    access_denied,
    source_not_found,
    data_set_not_found,
    internal_failure,
    parameter_value_incompatible,
    parameter_type_invalid,
    parameter_not_found,
    column_type_mismatch,
    column_geographic_role_mismatch,
    column_replacement_missing,

    pub const json_field_names = .{
        .access_denied = "ACCESS_DENIED",
        .source_not_found = "SOURCE_NOT_FOUND",
        .data_set_not_found = "DATA_SET_NOT_FOUND",
        .internal_failure = "INTERNAL_FAILURE",
        .parameter_value_incompatible = "PARAMETER_VALUE_INCOMPATIBLE",
        .parameter_type_invalid = "PARAMETER_TYPE_INVALID",
        .parameter_not_found = "PARAMETER_NOT_FOUND",
        .column_type_mismatch = "COLUMN_TYPE_MISMATCH",
        .column_geographic_role_mismatch = "COLUMN_GEOGRAPHIC_ROLE_MISMATCH",
        .column_replacement_missing = "COLUMN_REPLACEMENT_MISSING",
    };
};
