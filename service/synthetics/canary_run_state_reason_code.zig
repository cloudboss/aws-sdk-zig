pub const CanaryRunStateReasonCode = enum {
    canary_failure,
    execution_failure,

    pub const json_field_names = .{
        .canary_failure = "CANARY_FAILURE",
        .execution_failure = "EXECUTION_FAILURE",
    };
};
