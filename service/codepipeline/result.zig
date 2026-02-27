pub const Result = enum {
    rollback,
    fail,
    retry,
    skip,

    pub const json_field_names = .{
        .rollback = "ROLLBACK",
        .fail = "FAIL",
        .retry = "RETRY",
        .skip = "SKIP",
    };
};
