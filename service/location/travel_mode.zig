pub const TravelMode = enum {
    car,
    truck,
    walking,
    bicycle,
    motorcycle,

    pub const json_field_names = .{
        .car = "Car",
        .truck = "Truck",
        .walking = "Walking",
        .bicycle = "Bicycle",
        .motorcycle = "Motorcycle",
    };
};
