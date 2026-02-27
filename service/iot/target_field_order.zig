pub const TargetFieldOrder = enum {
    lat_lon,
    lon_lat,

    pub const json_field_names = .{
        .lat_lon = "LatLon",
        .lon_lat = "LonLat",
    };
};
