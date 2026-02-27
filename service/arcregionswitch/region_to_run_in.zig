pub const RegionToRunIn = enum {
    activating_region,
    deactivating_region,

    pub const json_field_names = .{
        .activating_region = "ACTIVATING_REGION",
        .deactivating_region = "DEACTIVATING_REGION",
    };
};
