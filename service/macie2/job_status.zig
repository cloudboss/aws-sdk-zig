/// The status of a classification job. Possible values are:
pub const JobStatus = enum {
    running,
    paused,
    cancelled,
    complete,
    idle,
    user_paused,

    pub const json_field_names = .{
        .running = "RUNNING",
        .paused = "PAUSED",
        .cancelled = "CANCELLED",
        .complete = "COMPLETE",
        .idle = "IDLE",
        .user_paused = "USER_PAUSED",
    };
};
