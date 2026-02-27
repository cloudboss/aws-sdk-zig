pub const ValidationExceptionReason = enum {
    cannot_parse,
    field_validation_failed,
    unknown_operation,

    pub const json_field_names = .{
        .cannot_parse = "CANNOT_PARSE",
        .field_validation_failed = "FIELD_VALIDATION_FAILED",
        .unknown_operation = "UNKNOWN_OPERATION",
    };
};
