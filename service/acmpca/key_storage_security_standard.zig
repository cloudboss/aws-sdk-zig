pub const KeyStorageSecurityStandard = enum {
    fips_140_2_level_2_or_higher,
    fips_140_2_level_3_or_higher,
    ccpc_level_1_or_higher,

    pub const json_field_names = .{
        .fips_140_2_level_2_or_higher = "FIPS_140_2_LEVEL_2_OR_HIGHER",
        .fips_140_2_level_3_or_higher = "FIPS_140_2_LEVEL_3_OR_HIGHER",
        .ccpc_level_1_or_higher = "CCPC_LEVEL_1_OR_HIGHER",
    };
};
