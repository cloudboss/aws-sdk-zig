pub const ValidationExceptionReason = enum {
    unknown_operation,
    cannot_parse,
    field_validation_failed,
    other,
    not_supported,

    pub const json_field_names = .{
        .unknown_operation = "UNKNOWN_OPERATION",
        .cannot_parse = "CANNOT_PARSE",
        .field_validation_failed = "FIELD_VALIDATION_FAILED",
        .other = "OTHER",
        .not_supported = "NOT_SUPPORTED",
    };
};
