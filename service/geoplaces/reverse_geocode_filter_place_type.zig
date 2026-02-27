pub const ReverseGeocodeFilterPlaceType = enum {
    locality,
    intersection,
    street,
    point_address,
    interpolated_address,

    pub const json_field_names = .{
        .locality = "LOCALITY",
        .intersection = "INTERSECTION",
        .street = "STREET",
        .point_address = "POINT_ADDRESS",
        .interpolated_address = "INTERPOLATED_ADDRESS",
    };
};
