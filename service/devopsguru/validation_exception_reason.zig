pub const ValidationExceptionReason = enum {
    unknown_operation,
    cannot_parse,
    field_validation_failed,
    other,
    invalid_parameter_combination,
    parameter_inconsistent_with_service_state,

    pub const json_field_names = .{
        .unknown_operation = "UNKNOWN_OPERATION",
        .cannot_parse = "CANNOT_PARSE",
        .field_validation_failed = "FIELD_VALIDATION_FAILED",
        .other = "OTHER",
        .invalid_parameter_combination = "INVALID_PARAMETER_COMBINATION",
        .parameter_inconsistent_with_service_state = "PARAMETER_INCONSISTENT_WITH_SERVICE_STATE",
    };
};
