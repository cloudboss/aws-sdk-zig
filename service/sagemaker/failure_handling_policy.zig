pub const FailureHandlingPolicy = enum {
    rollback_on_failure,
    do_nothing,

    pub const json_field_names = .{
        .rollback_on_failure = "RollbackOnFailure",
        .do_nothing = "DoNothing",
    };
};
