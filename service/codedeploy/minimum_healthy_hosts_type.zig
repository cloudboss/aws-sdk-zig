pub const MinimumHealthyHostsType = enum {
    host_count,
    fleet_percent,

    pub const json_field_names = .{
        .host_count = "HOST_COUNT",
        .fleet_percent = "FLEET_PERCENT",
    };
};
