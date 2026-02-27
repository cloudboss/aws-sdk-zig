pub const GeocodeFilterPlaceType = enum {
    locality,
    postal_code,
    intersection,
    street,
    point_address,
    interpolated_address,

    pub const json_field_names = .{
        .locality = "LOCALITY",
        .postal_code = "POSTAL_CODE",
        .intersection = "INTERSECTION",
        .street = "STREET",
        .point_address = "POINT_ADDRESS",
        .interpolated_address = "INTERPOLATED_ADDRESS",
    };
};
