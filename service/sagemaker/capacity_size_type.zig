pub const CapacitySizeType = enum {
    instance_count,
    capacity_percent,

    pub const json_field_names = .{
        .instance_count = "INSTANCE_COUNT",
        .capacity_percent = "CAPACITY_PERCENT",
    };
};
