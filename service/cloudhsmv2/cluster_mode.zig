pub const ClusterMode = enum {
    fips,
    non_fips,

    pub const json_field_names = .{
        .fips = "FIPS",
        .non_fips = "NON_FIPS",
    };
};
