pub const QueryStateInput = enum {
    all,
    running,
    waiting,
    cancelling,

    pub const json_field_names = .{
        .all = "ALL",
        .running = "RUNNING",
        .waiting = "WAITING",
        .cancelling = "CANCELLING",
    };
};
