pub const TestGridSessionStatus = enum {
    active,
    closed,
    errored,

    pub const json_field_names = .{
        .active = "ACTIVE",
        .closed = "CLOSED",
        .errored = "ERRORED",
    };
};
