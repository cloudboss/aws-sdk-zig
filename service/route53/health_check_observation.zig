const HealthCheckRegion = @import("health_check_region.zig").HealthCheckRegion;
const StatusReport = @import("status_report.zig").StatusReport;

/// A complex type that contains the last failure reason as reported by one
/// Amazon Route
/// 53 health checker.
pub const HealthCheckObservation = struct {
    /// The IP address of the Amazon Route 53 health checker that provided the
    /// failure reason
    /// in `StatusReport`.
    ip_address: ?[]const u8,

    /// The region of the Amazon Route 53 health checker that provided the status in
    /// `StatusReport`.
    region: ?HealthCheckRegion,

    /// A complex type that contains the last failure reason as reported by one
    /// Amazon Route
    /// 53 health checker and the time of the failed health check.
    status_report: ?StatusReport,
};
