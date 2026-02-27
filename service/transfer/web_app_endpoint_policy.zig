pub const WebAppEndpointPolicy = enum {
    fips,
    standard,

    pub const json_field_names = .{
        .fips = "FIPS",
        .standard = "STANDARD",
    };
};
