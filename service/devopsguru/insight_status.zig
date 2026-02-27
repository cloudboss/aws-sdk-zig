pub const InsightStatus = enum {
    ongoing,
    closed,

    pub const json_field_names = .{
        .ongoing = "ONGOING",
        .closed = "CLOSED",
    };
};
