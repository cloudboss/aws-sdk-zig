pub const MapStyle = enum {
    standard,
    monochrome,
    hybrid,
    satellite,

    pub const json_field_names = .{
        .standard = "STANDARD",
        .monochrome = "MONOCHROME",
        .hybrid = "HYBRID",
        .satellite = "SATELLITE",
    };
};
