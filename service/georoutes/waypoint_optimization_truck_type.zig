pub const WaypointOptimizationTruckType = enum {
    straight_truck,
    tractor,

    pub const json_field_names = .{
        .straight_truck = "STRAIGHT_TRUCK",
        .tractor = "TRACTOR",
    };
};
