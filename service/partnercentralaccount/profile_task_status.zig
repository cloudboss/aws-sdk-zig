pub const ProfileTaskStatus = enum {
    in_progress,
    canceled,
    succeeded,
    failed,

    pub const json_field_names = .{
        .in_progress = "IN_PROGRESS",
        .canceled = "CANCELED",
        .succeeded = "SUCCEEDED",
        .failed = "FAILED",
    };
};
