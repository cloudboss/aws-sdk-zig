pub const FilterInstanceStatus = enum {
    active,
    draining,

    pub const json_field_names = .{
        .active = "ACTIVE",
        .draining = "DRAINING",
    };
};
