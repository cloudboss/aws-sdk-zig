pub const OpenZFSDeploymentType = enum {
    single_az_1,
    single_az_2,
    single_az_ha_1,
    single_az_ha_2,
    multi_az_1,

    pub const json_field_names = .{
        .single_az_1 = "SINGLE_AZ_1",
        .single_az_2 = "SINGLE_AZ_2",
        .single_az_ha_1 = "SINGLE_AZ_HA_1",
        .single_az_ha_2 = "SINGLE_AZ_HA_2",
        .multi_az_1 = "MULTI_AZ_1",
    };
};
