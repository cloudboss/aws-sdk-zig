pub const DeploymentType = enum {
    single_az,
    with_multiaz_standby,

    pub const json_field_names = .{
        .single_az = "SINGLE_AZ",
        .with_multiaz_standby = "WITH_MULTIAZ_STANDBY",
    };
};
