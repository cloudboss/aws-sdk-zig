pub const FlowExecutionErrorType = enum {
    timed_out,

    pub const json_field_names = .{
        .timed_out = "TIMED_OUT",
    };
};
