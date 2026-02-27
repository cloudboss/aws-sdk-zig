pub const ValidationExceptionReason = enum {
    field_validation_failed,
    invalid_configuration,
    invalid_query,
    iam_synchronization_delay,

    pub const json_field_names = .{
        .field_validation_failed = "FIELD_VALIDATION_FAILED",
        .invalid_configuration = "INVALID_CONFIGURATION",
        .invalid_query = "INVALID_QUERY",
        .iam_synchronization_delay = "IAM_SYNCHRONIZATION_DELAY",
    };
};
