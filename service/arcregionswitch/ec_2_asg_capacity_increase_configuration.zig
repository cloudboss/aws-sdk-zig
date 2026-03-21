const Asg = @import("asg.zig").Asg;
const Ec2AsgCapacityMonitoringApproach = @import("ec_2_asg_capacity_monitoring_approach.zig").Ec2AsgCapacityMonitoringApproach;
const Ec2Ungraceful = @import("ec_2_ungraceful.zig").Ec2Ungraceful;

/// Configuration for increasing the capacity of Amazon EC2 Auto Scaling groups
/// during a Region switch.
pub const Ec2AsgCapacityIncreaseConfiguration = struct {
    /// The EC2 Auto Scaling groups for the configuration.
    asgs: []const Asg,

    /// The monitoring approach that you specify EC2 Auto Scaling groups for the
    /// configuration.
    capacity_monitoring_approach: Ec2AsgCapacityMonitoringApproach = .sampled_max_in_last_24_hours,

    /// The target percentage that you specify for EC2 Auto Scaling groups.
    target_percent: i32 = 100,

    /// The timeout value specified for the configuration.
    timeout_minutes: i32 = 60,

    /// The settings for ungraceful execution.
    ungraceful: ?Ec2Ungraceful = null,

    pub const json_field_names = .{
        .asgs = "asgs",
        .capacity_monitoring_approach = "capacityMonitoringApproach",
        .target_percent = "targetPercent",
        .timeout_minutes = "timeoutMinutes",
        .ungraceful = "ungraceful",
    };
};
