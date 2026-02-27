pub const StaticMapStyle = enum {
    satellite,
    standard,

    pub const json_field_names = .{
        .satellite = "SATELLITE",
        .standard = "STANDARD",
    };
};
