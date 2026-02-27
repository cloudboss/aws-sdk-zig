pub const ValidationExceptionErrorCode = enum {
    malformed_token,
    expired_token,
    invalid_token,
    field_validation_failed,
    missing_input,

    pub const json_field_names = .{
        .malformed_token = "MALFORMED_TOKEN",
        .expired_token = "EXPIRED_TOKEN",
        .invalid_token = "INVALID_TOKEN",
        .field_validation_failed = "FIELD_VALIDATION_FAILED",
        .missing_input = "MISSING_INPUT",
    };
};
