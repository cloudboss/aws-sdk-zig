pub const ValidationExceptionReason = enum {
    unknown_operation,
    cannot_parse,
    field_validation_failed,
    invalid_request_from_member,
    disallowed_rate,
    other,

    pub const json_field_names = .{
        .unknown_operation = "UNKNOWN_OPERATION",
        .cannot_parse = "CANNOT_PARSE",
        .field_validation_failed = "FIELD_VALIDATION_FAILED",
        .invalid_request_from_member = "INVALID_REQUEST_FROM_MEMBER",
        .disallowed_rate = "DISALLOWED_RATE",
        .other = "OTHER",
    };
};
