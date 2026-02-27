pub const GeoSpatialDataRole = enum {
    country,
    state,
    county,
    city,
    postcode,
    longitude,
    latitude,

    pub const json_field_names = .{
        .country = "COUNTRY",
        .state = "STATE",
        .county = "COUNTY",
        .city = "CITY",
        .postcode = "POSTCODE",
        .longitude = "LONGITUDE",
        .latitude = "LATITUDE",
    };
};
