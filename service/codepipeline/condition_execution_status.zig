pub const ConditionExecutionStatus = enum {
    in_progress,
    failed,
    errored,
    succeeded,
    cancelled,
    abandoned,
    overridden,

    pub const json_field_names = .{
        .in_progress = "InProgress",
        .failed = "Failed",
        .errored = "Errored",
        .succeeded = "Succeeded",
        .cancelled = "Cancelled",
        .abandoned = "Abandoned",
        .overridden = "Overridden",
    };
};
