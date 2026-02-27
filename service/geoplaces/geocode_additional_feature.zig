pub const GeocodeAdditionalFeature = enum {
    time_zone,
    access,
    secondary_addresses,
    intersections,

    pub const json_field_names = .{
        .time_zone = "TIME_ZONE",
        .access = "ACCESS",
        .secondary_addresses = "SECONDARY_ADDRESSES",
        .intersections = "INTERSECTIONS",
    };
};
