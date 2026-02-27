pub const OverrideType = enum {
    standard,
    open,
    closed,

    pub const json_field_names = .{
        .standard = "STANDARD",
        .open = "OPEN",
        .closed = "CLOSED",
    };
};
