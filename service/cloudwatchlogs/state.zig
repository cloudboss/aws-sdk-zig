pub const State = enum {
    active,
    suppressed,
    baseline,

    pub const json_field_names = .{
        .active = "Active",
        .suppressed = "Suppressed",
        .baseline = "Baseline",
    };
};
