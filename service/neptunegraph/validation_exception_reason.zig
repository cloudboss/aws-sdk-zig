pub const ValidationExceptionReason = enum {
    constraint_violation,
    illegal_argument,
    malformed_query,
    query_cancelled,
    query_too_large,
    unsupported_operation,
    bad_request,

    pub const json_field_names = .{
        .constraint_violation = "CONSTRAINT_VIOLATION",
        .illegal_argument = "ILLEGAL_ARGUMENT",
        .malformed_query = "MALFORMED_QUERY",
        .query_cancelled = "QUERY_CANCELLED",
        .query_too_large = "QUERY_TOO_LARGE",
        .unsupported_operation = "UNSUPPORTED_OPERATION",
        .bad_request = "BAD_REQUEST",
    };
};
