const Route53HealthCheckStatus = @import("route_53_health_check_status.zig").Route53HealthCheckStatus;

/// The Amazon Route 53 health check.
pub const Route53HealthCheck = struct {
    /// The Amazon Route 53 health check ID.
    health_check_id: ?[]const u8 = null,

    /// The Amazon Route 53 health check hosted zone ID.
    hosted_zone_id: []const u8,

    /// The Amazon Route 53 record name.
    record_name: []const u8,

    /// The Amazon Route 53 Region.
    region: []const u8,

    /// The Amazon Route 53 health check status.
    status: ?Route53HealthCheckStatus = null,

    pub const json_field_names = .{
        .health_check_id = "healthCheckId",
        .hosted_zone_id = "hostedZoneId",
        .record_name = "recordName",
        .region = "region",
        .status = "status",
    };
};
