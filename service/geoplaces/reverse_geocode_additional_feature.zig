pub const ReverseGeocodeAdditionalFeature = enum {
    time_zone,
    access,
    intersections,

    pub const json_field_names = .{
        .time_zone = "TIME_ZONE",
        .access = "ACCESS",
        .intersections = "INTERSECTIONS",
    };
};
