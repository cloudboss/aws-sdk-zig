pub const GameSessionPlacementState = enum {
    pending,
    fulfilled,
    cancelled,
    timed_out,
    failed,

    pub const json_field_names = .{
        .pending = "PENDING",
        .fulfilled = "FULFILLED",
        .cancelled = "CANCELLED",
        .timed_out = "TIMED_OUT",
        .failed = "FAILED",
    };
};
