pub const LastLaunchResult = enum {
    not_started,
    pending,
    succeeded,
    failed,

    pub const json_field_names = .{
        .not_started = "NOT_STARTED",
        .pending = "PENDING",
        .succeeded = "SUCCEEDED",
        .failed = "FAILED",
    };
};
