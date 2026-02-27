pub const SpotProvisioningTimeoutAction = enum {
    switch_to_on_demand,
    terminate_cluster,

    pub const json_field_names = .{
        .switch_to_on_demand = "SWITCH_TO_ON_DEMAND",
        .terminate_cluster = "TERMINATE_CLUSTER",
    };
};
