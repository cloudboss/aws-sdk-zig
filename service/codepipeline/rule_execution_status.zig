pub const RuleExecutionStatus = enum {
    in_progress,
    abandoned,
    succeeded,
    failed,

    pub const json_field_names = .{
        .in_progress = "InProgress",
        .abandoned = "Abandoned",
        .succeeded = "Succeeded",
        .failed = "Failed",
    };
};
