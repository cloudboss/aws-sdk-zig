pub const ValidationExceptionReason = enum {
    /// No such operation is supported.
    unknown_operation,
    /// The required input is missing.
    missing,
    /// The input cannot be parsed. For example a required JSON document, ARN
    /// identifier,
    /// date value, or numeric field cannot be parsed.
    cannot_parse,
    /// The input is present and parsable, but it is otherwise invalid. For example,
    /// a
    /// required numeric argument is outside the allowed range.
    field_validation_failed,
    /// The input is invalid but no more specific reason is applicable.
    other,
    /// No such field is supported.
    unknown_field,

    pub const json_field_names = .{
        .unknown_operation = "UNKNOWN_OPERATION",
        .missing = "MISSING",
        .cannot_parse = "CANNOT_PARSE",
        .field_validation_failed = "FIELD_VALIDATION_FAILED",
        .other = "OTHER",
        .unknown_field = "UNKNOWN_FIELD",
    };
};
