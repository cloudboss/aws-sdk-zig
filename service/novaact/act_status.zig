pub const ActStatus = enum {
    running,
    pending_client_action,
    pending_human_action,
    succeeded,
    failed,
    timed_out,

    pub const json_field_names = .{
        .running = "RUNNING",
        .pending_client_action = "PENDING_CLIENT_ACTION",
        .pending_human_action = "PENDING_HUMAN_ACTION",
        .succeeded = "SUCCEEDED",
        .failed = "FAILED",
        .timed_out = "TIMED_OUT",
    };
};
