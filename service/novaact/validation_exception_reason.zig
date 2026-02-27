pub const ValidationExceptionReason = enum {
    field_validation_failed,
    invalid_status,
    guardrail_intervened,

    pub const json_field_names = .{
        .field_validation_failed = "FIELD_VALIDATION_FAILED",
        .invalid_status = "INVALID_STATUS",
        .guardrail_intervened = "GUARDRAIL_INTERVENED",
    };
};
