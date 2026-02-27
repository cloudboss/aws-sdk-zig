pub const PortState = enum {
    open,
    closed,

    pub const json_field_names = .{
        .open = "Open",
        .closed = "Closed",
    };
};
