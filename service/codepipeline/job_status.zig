pub const JobStatus = enum {
    created,
    queued,
    dispatched,
    in_progress,
    timed_out,
    succeeded,
    failed,

    pub const json_field_names = .{
        .created = "Created",
        .queued = "Queued",
        .dispatched = "Dispatched",
        .in_progress = "InProgress",
        .timed_out = "TimedOut",
        .succeeded = "Succeeded",
        .failed = "Failed",
    };
};
