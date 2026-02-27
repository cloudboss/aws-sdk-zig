const CPUUtilization = @import("cpu_utilization.zig").CPUUtilization;

/// CPU utilization and load average metrics for an Amazon EC2 instance.
pub const SystemStatus = struct {
    /// CPU utilization metrics for the instance.
    cpu_utilization: ?CPUUtilization,

    /// Load average in the last 1-minute, 5-minute, and 15-minute periods.
    /// For more information, see
    /// [Operating System
    /// Metrics](https://docs.aws.amazon.com/elasticbeanstalk/latest/dg/health-enhanced-metrics.html#health-enhanced-metrics-os).
    load_average: ?[]const f64,
};
