pub const DeploymentOption = enum {
    with_traffic_control,
    without_traffic_control,

    pub const json_field_names = .{
        .with_traffic_control = "WITH_TRAFFIC_CONTROL",
        .without_traffic_control = "WITHOUT_TRAFFIC_CONTROL",
    };
};
