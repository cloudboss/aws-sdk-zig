pub const RouteMatrixTruckType = enum {
    light_truck,
    straight_truck,
    tractor,

    pub const json_field_names = .{
        .light_truck = "LIGHT_TRUCK",
        .straight_truck = "STRAIGHT_TRUCK",
        .tractor = "TRACTOR",
    };
};
