pub const IotEndpointType = enum {
    fips,
    standard,

    pub const json_field_names = .{
        .fips = "fips",
        .standard = "standard",
    };
};
