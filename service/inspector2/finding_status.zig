pub const FindingStatus = enum {
    active,
    suppressed,
    closed,

    pub const json_field_names = .{
        .active = "ACTIVE",
        .suppressed = "SUPPRESSED",
        .closed = "CLOSED",
    };
};
