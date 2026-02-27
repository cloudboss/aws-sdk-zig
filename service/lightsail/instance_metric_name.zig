pub const InstanceMetricName = enum {
    cpu_utilization,
    network_in,
    network_out,
    status_check_failed,
    status_check_failed_instance,
    status_check_failed_system,
    burst_capacity_time,
    burst_capacity_percentage,
    metadata_no_token,

    pub const json_field_names = .{
        .cpu_utilization = "CPUUtilization",
        .network_in = "NetworkIn",
        .network_out = "NetworkOut",
        .status_check_failed = "StatusCheckFailed",
        .status_check_failed_instance = "StatusCheckFailed_Instance",
        .status_check_failed_system = "StatusCheckFailed_System",
        .burst_capacity_time = "BurstCapacityTime",
        .burst_capacity_percentage = "BurstCapacityPercentage",
        .metadata_no_token = "MetadataNoToken",
    };
};
