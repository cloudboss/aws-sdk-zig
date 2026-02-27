pub const ValidationExceptionReason = enum {
    program_set_validation_failed,

    pub const json_field_names = .{
        .program_set_validation_failed = "PROGRAM_SET_VALIDATION_FAILED",
    };
};
