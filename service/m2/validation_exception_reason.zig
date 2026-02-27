pub const ValidationExceptionReason = enum {
    unknown_operation,
    cannot_parse,
    feature_not_available,
    unsupported_engine_version,
    field_validation_failed,
    other,

    pub const json_field_names = .{
        .unknown_operation = "UNKNOWN_OPERATION",
        .cannot_parse = "CANNOT_PARSE",
        .feature_not_available = "FEATURE_NOT_AVAILABLE",
        .unsupported_engine_version = "UNSUPPORTED_ENGINE_VERSION",
        .field_validation_failed = "FIELD_VALIDATION_FAILED",
        .other = "OTHER",
    };
};
