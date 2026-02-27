pub const TransactionStatusFilter = enum {
    all,
    completed,
    active,
    committed,
    aborted,

    pub const json_field_names = .{
        .all = "ALL",
        .completed = "COMPLETED",
        .active = "ACTIVE",
        .committed = "COMMITTED",
        .aborted = "ABORTED",
    };
};
