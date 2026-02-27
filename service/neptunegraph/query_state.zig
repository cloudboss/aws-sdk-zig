pub const QueryState = enum {
    running,
    waiting,
    cancelling,

    pub const json_field_names = .{
        .running = "RUNNING",
        .waiting = "WAITING",
        .cancelling = "CANCELLING",
    };
};
