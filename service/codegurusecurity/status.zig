pub const Status = enum {
    closed,
    open,
    all,

    pub const json_field_names = .{
        .closed = "CLOSED",
        .open = "OPEN",
        .all = "ALL",
    };
};
