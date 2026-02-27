pub const SessionActionStatus = enum {
    assigned,
    running,
    canceling,
    succeeded,
    failed,
    interrupted,
    canceled,
    never_attempted,
    scheduled,
    reclaiming,
    reclaimed,

    pub const json_field_names = .{
        .assigned = "ASSIGNED",
        .running = "RUNNING",
        .canceling = "CANCELING",
        .succeeded = "SUCCEEDED",
        .failed = "FAILED",
        .interrupted = "INTERRUPTED",
        .canceled = "CANCELED",
        .never_attempted = "NEVER_ATTEMPTED",
        .scheduled = "SCHEDULED",
        .reclaiming = "RECLAIMING",
        .reclaimed = "RECLAIMED",
    };
};
