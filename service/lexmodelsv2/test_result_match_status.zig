pub const TestResultMatchStatus = enum {
    matched,
    mismatched,
    execution_error,

    pub const json_field_names = .{
        .matched = "Matched",
        .mismatched = "Mismatched",
        .execution_error = "ExecutionError",
    };
};
