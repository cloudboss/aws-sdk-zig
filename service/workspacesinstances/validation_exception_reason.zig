pub const ValidationExceptionReason = enum {
    unknown_operation,
    unsupported_operation,
    cannot_parse,
    field_validation_failed,
    dependency_failure,
    other,

    pub const json_field_names = .{
        .unknown_operation = "UNKNOWN_OPERATION",
        .unsupported_operation = "UNSUPPORTED_OPERATION",
        .cannot_parse = "CANNOT_PARSE",
        .field_validation_failed = "FIELD_VALIDATION_FAILED",
        .dependency_failure = "DEPENDENCY_FAILURE",
        .other = "OTHER",
    };
};
