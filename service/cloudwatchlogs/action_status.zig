pub const ActionStatus = enum {
    in_progress,
    client_error,
    failed,
    complete,

    pub const json_field_names = .{
        .in_progress = "IN_PROGRESS",
        .client_error = "CLIENT_ERROR",
        .failed = "FAILED",
        .complete = "COMPLETE",
    };
};
