pub const ValidationExceptionReason = enum {
    cannot_parse,
    field_validation_failed,
    idempotent_parameter_mismatch_exception,
    root_event_in_other_session,
    resource_conflict,

    pub const json_field_names = .{
        .cannot_parse = "CANNOT_PARSE",
        .field_validation_failed = "FIELD_VALIDATION_FAILED",
        .idempotent_parameter_mismatch_exception = "IDEMPOTENT_PARAMETER_MISMATCH_EXCEPTION",
        .root_event_in_other_session = "ROOT_EVENT_IN_OTHER_SESSION",
        .resource_conflict = "RESOURCE_CONFLICT",
    };
};
