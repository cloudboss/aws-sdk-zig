pub const TransactionStatus = enum {
    active,
    committed,
    aborted,
    commit_in_progress,

    pub const json_field_names = .{
        .active = "ACTIVE",
        .committed = "COMMITTED",
        .aborted = "ABORTED",
        .commit_in_progress = "COMMIT_IN_PROGRESS",
    };
};
