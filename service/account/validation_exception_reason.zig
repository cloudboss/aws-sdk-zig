pub const ValidationExceptionReason = enum {
    invalid_region_opt_target,
    field_validation_failed,

    pub const json_field_names = .{
        .invalid_region_opt_target = "INVALID_REGION_OPT_TARGET",
        .field_validation_failed = "FIELD_VALIDATION_FAILED",
    };
};
