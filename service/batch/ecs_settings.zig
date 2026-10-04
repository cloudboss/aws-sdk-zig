const ContainerInsights = @import("container_insights.zig").ContainerInsights;

/// The Amazon ECS settings for a compute environment, including the CloudWatch
/// Container Insights
/// mode. Use this structure with `CreateComputeEnvironment` and
/// `UpdateComputeEnvironment`.
pub const EcsSettings = struct {
    /// Specifies the CloudWatch Container Insights mode for the compute
    /// environment. Valid values
    /// are:
    ///
    /// **ENABLED**
    ///
    /// Turns on standard Container Insights, which collects CPU, memory, disk, and
    /// network
    /// utilization metrics for the compute environment.
    ///
    /// **ENHANCED**
    ///
    /// Turns on enhanced Container Insights, which collects the standard metrics
    /// along with
    /// additional per-task observability metrics.
    ///
    /// **DISABLED**
    ///
    /// Turns off Container Insights for the compute environment.
    ///
    /// If you don't specify a value, the default is `DISABLED`. For more
    /// information,
    /// see [Container
    /// Insights](https://docs.aws.amazon.com/batch/latest/userguide/cloudwatch-container-insights.html) in the
    /// *Batch User Guide*.
    container_insights: ?ContainerInsights = null,

    pub const json_field_names = .{
        .container_insights = "containerInsights",
    };
};
