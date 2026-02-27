pub const OriginManifestType = enum {
    single_period,
    multi_period,

    pub const json_field_names = .{
        .single_period = "SINGLE_PERIOD",
        .multi_period = "MULTI_PERIOD",
    };
};
