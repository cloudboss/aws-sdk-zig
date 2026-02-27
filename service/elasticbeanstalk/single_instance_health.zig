const ApplicationMetrics = @import("application_metrics.zig").ApplicationMetrics;
const Deployment = @import("deployment.zig").Deployment;
const SystemStatus = @import("system_status.zig").SystemStatus;

/// Detailed health information about an Amazon EC2 instance in your Elastic
/// Beanstalk
/// environment.
pub const SingleInstanceHealth = struct {
    /// Request metrics from your application.
    application_metrics: ?ApplicationMetrics,

    /// The availability zone in which the instance runs.
    availability_zone: ?[]const u8,

    /// Represents the causes, which provide more information about the current
    /// health
    /// status.
    causes: ?[]const []const u8,

    /// Represents the color indicator that gives you information about the health
    /// of the EC2
    /// instance. For more information, see [Health Colors and
    /// Statuses](https://docs.aws.amazon.com/elasticbeanstalk/latest/dg/health-enhanced-status.html).
    color: ?[]const u8,

    /// Information about the most recent deployment to an instance.
    deployment: ?Deployment,

    /// Returns the health status of the specified instance. For more information,
    /// see [Health
    /// Colors and
    /// Statuses](https://docs.aws.amazon.com/elasticbeanstalk/latest/dg/health-enhanced-status.html).
    health_status: ?[]const u8,

    /// The ID of the Amazon EC2 instance.
    instance_id: ?[]const u8,

    /// The instance's type.
    instance_type: ?[]const u8,

    /// The time at which the EC2 instance was launched.
    launched_at: ?i64,

    /// Operating system metrics from the instance.
    system: ?SystemStatus,
};
