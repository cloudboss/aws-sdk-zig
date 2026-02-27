pub const RouteLegTravelMode = enum {
    car,
    ferry,
    pedestrian,
    scooter,
    truck,
    car_shuttle_train,

    pub const json_field_names = .{
        .car = "CAR",
        .ferry = "FERRY",
        .pedestrian = "PEDESTRIAN",
        .scooter = "SCOOTER",
        .truck = "TRUCK",
        .car_shuttle_train = "CAR_SHUTTLE_TRAIN",
    };
};
