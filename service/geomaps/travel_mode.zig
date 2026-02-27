pub const TravelMode = enum {
    transit,
    truck,

    pub const json_field_names = .{
        .transit = "TRANSIT",
        .truck = "TRUCK",
    };
};
