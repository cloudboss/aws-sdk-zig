pub const LoadMetricType = enum {
    asg_total_cpu_utilization,
    asg_total_network_in,
    asg_total_network_out,
    alb_target_group_request_count,

    pub const json_field_names = .{
        .asg_total_cpu_utilization = "ASGTotalCPUUtilization",
        .asg_total_network_in = "ASGTotalNetworkIn",
        .asg_total_network_out = "ASGTotalNetworkOut",
        .alb_target_group_request_count = "ALBTargetGroupRequestCount",
    };
};
