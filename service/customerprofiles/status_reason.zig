pub const StatusReason = enum {
    validation_failure,
    internal_failure,

    pub const json_field_names = .{
        .validation_failure = "VALIDATION_FAILURE",
        .internal_failure = "INTERNAL_FAILURE",
    };
};
