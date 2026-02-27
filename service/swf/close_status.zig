pub const CloseStatus = enum {
    completed,
    failed,
    canceled,
    terminated,
    continued_as_new,
    timed_out,

    pub const json_field_names = .{
        .completed = "COMPLETED",
        .failed = "FAILED",
        .canceled = "CANCELED",
        .terminated = "TERMINATED",
        .continued_as_new = "CONTINUED_AS_NEW",
        .timed_out = "TIMED_OUT",
    };
};
