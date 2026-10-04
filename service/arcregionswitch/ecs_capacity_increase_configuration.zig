const EcsCapacityMonitoringApproach = @import("ecs_capacity_monitoring_approach.zig").EcsCapacityMonitoringApproach;
const Service = @import("service.zig").Service;
const EcsUngraceful = @import("ecs_ungraceful.zig").EcsUngraceful;
const WaitELBTargetGroupHealthy = @import("wait_elb_target_group_healthy.zig").WaitELBTargetGroupHealthy;

/// The configuration for an Amazon Web Services ECS capacity increase.
pub const EcsCapacityIncreaseConfiguration = struct {
    /// The monitoring approach specified for the configuration, for example,
    /// `Most_Recent`.
    capacity_monitoring_approach: EcsCapacityMonitoringApproach = .sampled_max_in_last_24_hours,

    /// The services specified for the configuration.
    services: []const Service,

    /// The target percentage specified for the configuration. The default is 100.
    target_percent: i32 = 100,

    /// The timeout value specified for the configuration.
    timeout_minutes: i32 = 60,

    /// The settings for ungraceful execution.
    ungraceful: ?EcsUngraceful = null,

    /// If enabled, the step completes only after each attached ELB target group
    /// reports a healthy target count that matches the service's new desired task
    /// count calculated in the step.
    wait_elb_target_group_healthy: ?WaitELBTargetGroupHealthy = null,

    pub const json_field_names = .{
        .capacity_monitoring_approach = "capacityMonitoringApproach",
        .services = "services",
        .target_percent = "targetPercent",
        .timeout_minutes = "timeoutMinutes",
        .ungraceful = "ungraceful",
        .wait_elb_target_group_healthy = "waitELBTargetGroupHealthy",
    };
};
