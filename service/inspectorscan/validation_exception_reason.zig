pub const ValidationExceptionReason = enum {
    unknown_operation,
    cannot_parse,
    field_validation_failed,
    unsupported_sbom_type,
    other,

    pub const json_field_names = .{
        .unknown_operation = "UNKNOWN_OPERATION",
        .cannot_parse = "CANNOT_PARSE",
        .field_validation_failed = "FIELD_VALIDATION_FAILED",
        .unsupported_sbom_type = "UNSUPPORTED_SBOM_TYPE",
        .other = "OTHER",
    };
};
