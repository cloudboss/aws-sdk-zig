const CloudWatchAlarmConfiguration = @import("cloud_watch_alarm_configuration.zig").CloudWatchAlarmConfiguration;
const HealthCheckConfig = @import("health_check_config.zig").HealthCheckConfig;
const LinkedService = @import("linked_service.zig").LinkedService;

/// A complex type that contains information about one health check that is
/// associated
/// with the current Amazon Web Services account.
pub const HealthCheck = struct {
    /// A unique string that you specified when you created the health check.
    caller_reference: []const u8,

    /// A complex type that contains information about the CloudWatch alarm that
    /// Amazon Route
    /// 53 is monitoring for this health check.
    cloud_watch_alarm_configuration: ?CloudWatchAlarmConfiguration = null,

    /// A complex type that contains detailed information about one health check.
    health_check_config: HealthCheckConfig,

    /// The version of the health check. You can optionally pass this value in a
    /// call to
    /// `UpdateHealthCheck` to prevent overwriting another change to the health
    /// check.
    health_check_version: i64,

    /// The identifier that Amazon Route 53 assigned to the health check when you
    /// created it.
    /// When you add or update a resource record set, you use this value to specify
    /// which health
    /// check to use. The value can be up to 64 characters long.
    id: []const u8,

    /// If the health check was created by another service, the service that created
    /// the
    /// health check. When a health check is created by another service, you can't
    /// edit or
    /// delete it using Amazon Route 53.
    linked_service: ?LinkedService = null,
};
