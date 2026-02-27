pub const ProxySessionStatus = enum {
    open,
    in_progress,
    closed,

    pub const json_field_names = .{
        .open = "Open",
        .in_progress = "InProgress",
        .closed = "Closed",
    };
};
