const ImpairedZoneHealthCheckBehavior = @import("impaired_zone_health_check_behavior.zig").ImpairedZoneHealthCheckBehavior;

/// Describes an Availability Zone impairment policy.
pub const AvailabilityZoneImpairmentPolicy = struct {
    /// Specifies the health check behavior for the impaired Availability Zone in an
    /// active zonal shift. If you select `Replace unhealthy`, instances that appear
    /// unhealthy will be replaced in all Availability Zones.
    /// If you select `Ignore unhealthy`, instances will not be replaced in the
    /// Availability Zone with the active zonal shift. For more information, see
    /// [Auto Scaling group zonal
    /// shift](https://docs.aws.amazon.com/autoscaling/ec2/userguide/ec2-auto-scaling-zonal-shift.html)
    /// in the *Amazon EC2 Auto Scaling User Guide*.
    impaired_zone_health_check_behavior: ?ImpairedZoneHealthCheckBehavior,

    /// If `true`, enable zonal shift for your Auto Scaling group.
    zonal_shift_enabled: ?bool,
};
