pub const eventStatusCode = enum {
    open,
    closed,
    upcoming,

    pub const json_field_names = .{
        .open = "OPEN",
        .closed = "CLOSED",
        .upcoming = "UPCOMING",
    };
};
