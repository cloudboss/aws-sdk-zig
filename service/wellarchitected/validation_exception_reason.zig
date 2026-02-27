/// The reason why the request failed validation.
pub const ValidationExceptionReason = enum {
    unknown_operation,
    cannot_parse,
    field_validation_failed,
    other,

    pub const json_field_names = .{
        .unknown_operation = "UNKNOWN_OPERATION",
        .cannot_parse = "CANNOT_PARSE",
        .field_validation_failed = "FIELD_VALIDATION_FAILED",
        .other = "OTHER",
    };
};
