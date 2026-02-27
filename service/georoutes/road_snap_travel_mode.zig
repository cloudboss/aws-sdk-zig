pub const RoadSnapTravelMode = enum {
    car,
    pedestrian,
    scooter,
    truck,

    pub const json_field_names = .{
        .car = "CAR",
        .pedestrian = "PEDESTRIAN",
        .scooter = "SCOOTER",
        .truck = "TRUCK",
    };
};
