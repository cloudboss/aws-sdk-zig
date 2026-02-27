/// The broker's deployment mode.
pub const DeploymentMode = enum {
    single_instance,
    active_standby_multi_az,
    cluster_multi_az,

    pub const json_field_names = .{
        .single_instance = "SINGLE_INSTANCE",
        .active_standby_multi_az = "ACTIVE_STANDBY_MULTI_AZ",
        .cluster_multi_az = "CLUSTER_MULTI_AZ",
    };
};
