pub const ValidationExceptionReason = enum {
    cannot_parse,
    field_validation_failed,
    other,

    pub const json_field_names = .{
        .cannot_parse = "CANNOT_PARSE",
        .field_validation_failed = "FIELD_VALIDATION_FAILED",
        .other = "OTHER",
    };
};
