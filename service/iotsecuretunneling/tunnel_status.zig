pub const TunnelStatus = enum {
    open,
    closed,

    pub const json_field_names = .{
        .open = "OPEN",
        .closed = "CLOSED",
    };
};
