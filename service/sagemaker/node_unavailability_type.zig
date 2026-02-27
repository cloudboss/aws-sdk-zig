pub const NodeUnavailabilityType = enum {
    instance_count,
    capacity_percentage,

    pub const json_field_names = .{
        .instance_count = "INSTANCE_COUNT",
        .capacity_percentage = "CAPACITY_PERCENTAGE",
    };
};
