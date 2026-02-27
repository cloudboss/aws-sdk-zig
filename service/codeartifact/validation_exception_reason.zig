pub const ValidationExceptionReason = enum {
    cannot_parse,
    encryption_key_error,
    field_validation_failed,
    unknown_operation,
    other,

    pub const json_field_names = .{
        .cannot_parse = "CANNOT_PARSE",
        .encryption_key_error = "ENCRYPTION_KEY_ERROR",
        .field_validation_failed = "FIELD_VALIDATION_FAILED",
        .unknown_operation = "UNKNOWN_OPERATION",
        .other = "OTHER",
    };
};
