pub const ValidationExceptionReason = enum {
    field_validation_failed,
    other,

    pub const json_field_names = .{
        .field_validation_failed = "FIELD_VALIDATION_FAILED",
        .other = "OTHER",
    };
};
