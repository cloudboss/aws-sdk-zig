pub const ValidationExceptionReason = enum {
    request_validation_failed,
    business_validation_failed,

    pub const json_field_names = .{
        .request_validation_failed = "REQUEST_VALIDATION_FAILED",
        .business_validation_failed = "BUSINESS_VALIDATION_FAILED",
    };
};
