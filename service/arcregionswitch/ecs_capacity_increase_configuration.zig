const EcsCapacityMonitoringApproach = @import("ecs_capacity_monitoring_approach.zig").EcsCapacityMonitoringApproach;
const Service = @import("service.zig").Service;
const EcsUngraceful = @import("ecs_ungraceful.zig").EcsUngraceful;

/// The configuration for an Amazon Web Services ECS capacity increase.
pub const EcsCapacityIncreaseConfiguration = struct {
    /// The monitoring approach specified for the configuration, for example,
    /// `Most_Recent`.
    capacity_monitoring_approach: EcsCapacityMonitoringApproach = "sampledMaxInLast24Hours",

    /// The services specified for the configuration.
    services: []const Service,

    /// The target percentage specified for the configuration.
    target_percent: i32 = 100,

    /// The timeout value specified for the configuration.
    timeout_minutes: i32 = 60,

    /// The settings for ungraceful execution.
    ungraceful: ?EcsUngraceful,

    pub const json_field_names = .{
        .capacity_monitoring_approach = "capacityMonitoringApproach",
        .services = "services",
        .target_percent = "targetPercent",
        .timeout_minutes = "timeoutMinutes",
        .ungraceful = "ungraceful",
    };
};
