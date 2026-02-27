pub const NotifyWorkersFailureCode = enum {
    soft_failure,
    hard_failure,

    pub const json_field_names = .{
        .soft_failure = "SoftFailure",
        .hard_failure = "HardFailure",
    };
};
