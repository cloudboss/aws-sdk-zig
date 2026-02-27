pub const InsightState = enum {
    active,
    closed,

    pub const json_field_names = .{
        .active = "ACTIVE",
        .closed = "CLOSED",
    };
};
