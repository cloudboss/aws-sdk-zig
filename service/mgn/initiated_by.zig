pub const InitiatedBy = enum {
    start_test,
    start_cutover,
    diagnostic,
    terminate,

    pub const json_field_names = .{
        .start_test = "START_TEST",
        .start_cutover = "START_CUTOVER",
        .diagnostic = "DIAGNOSTIC",
        .terminate = "TERMINATE",
    };
};
