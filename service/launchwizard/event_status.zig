pub const EventStatus = enum {
    canceled,
    canceling,
    completed,
    created,
    failed,
    in_progress,
    pending,
    timed_out,

    pub const json_field_names = .{
        .canceled = "CANCELED",
        .canceling = "CANCELING",
        .completed = "COMPLETED",
        .created = "CREATED",
        .failed = "FAILED",
        .in_progress = "IN_PROGRESS",
        .pending = "PENDING",
        .timed_out = "TIMED_OUT",
    };
};
