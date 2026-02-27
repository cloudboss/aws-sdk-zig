pub const JobStatus = enum {
    in_progress,
    canceled,
    completed,
    deletion_in_progress,
    scheduled,

    pub const json_field_names = .{
        .in_progress = "IN_PROGRESS",
        .canceled = "CANCELED",
        .completed = "COMPLETED",
        .deletion_in_progress = "DELETION_IN_PROGRESS",
        .scheduled = "SCHEDULED",
    };
};
