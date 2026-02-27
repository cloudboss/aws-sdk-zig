const ManagedAutoScaling = @import("managed_auto_scaling.zig").ManagedAutoScaling;
const ManagedIngressPath = @import("managed_ingress_path.zig").ManagedIngressPath;
const ManagedLogGroup = @import("managed_log_group.zig").ManagedLogGroup;
const ManagedMetricAlarm = @import("managed_metric_alarm.zig").ManagedMetricAlarm;
const ManagedSecurityGroup = @import("managed_security_group.zig").ManagedSecurityGroup;

/// Represents the Amazon Web Services resources managed by Amazon ECS for an
/// Express service, including ingress
/// paths, auto-scaling policies, metric alarms, and security groups.
pub const ECSManagedResources = struct {
    /// The auto-scaling configuration and policies for the Express service.
    auto_scaling: ?ManagedAutoScaling,

    /// The ingress paths and endpoints for the Express service.
    ingress_paths: ?[]const ManagedIngressPath,

    /// The log groups managed by the Express service.
    log_groups: ?[]const ManagedLogGroup,

    /// The CloudWatch metric alarms associated with the Express service.
    metric_alarms: ?[]const ManagedMetricAlarm,

    /// The security groups managed by the Express service.
    service_security_groups: ?[]const ManagedSecurityGroup,

    pub const json_field_names = .{
        .auto_scaling = "autoScaling",
        .ingress_paths = "ingressPaths",
        .log_groups = "logGroups",
        .metric_alarms = "metricAlarms",
        .service_security_groups = "serviceSecurityGroups",
    };
};
