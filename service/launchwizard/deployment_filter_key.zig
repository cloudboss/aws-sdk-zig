pub const DeploymentFilterKey = enum {
    workload_name,
    deployment_status,

    pub const json_field_names = .{
        .workload_name = "WORKLOAD_NAME",
        .deployment_status = "DEPLOYMENT_STATUS",
    };
};
