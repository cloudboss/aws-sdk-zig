pub const ValidationExceptionReason = enum {
    unknown_operation,
    field_validation_failed,
    other,

    pub const json_field_names = .{
        .unknown_operation = "UNKNOWN_OPERATION",
        .field_validation_failed = "FIELD_VALIDATION_FAILED",
        .other = "OTHER",
    };
};
