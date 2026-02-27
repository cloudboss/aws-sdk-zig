pub const OpenLineageRunState = enum {
    start,
    running,
    complete,
    abort,
    fail,
    other,

    pub const json_field_names = .{
        .start = "START",
        .running = "RUNNING",
        .complete = "COMPLETE",
        .abort = "ABORT",
        .fail = "FAIL",
        .other = "OTHER",
    };
};
