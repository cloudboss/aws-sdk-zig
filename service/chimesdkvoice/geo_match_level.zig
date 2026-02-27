pub const GeoMatchLevel = enum {
    country,
    area_code,

    pub const json_field_names = .{
        .country = "Country",
        .area_code = "AreaCode",
    };
};
