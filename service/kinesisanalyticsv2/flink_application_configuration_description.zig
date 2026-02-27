const CheckpointConfigurationDescription = @import("checkpoint_configuration_description.zig").CheckpointConfigurationDescription;
const MonitoringConfigurationDescription = @import("monitoring_configuration_description.zig").MonitoringConfigurationDescription;
const ParallelismConfigurationDescription = @import("parallelism_configuration_description.zig").ParallelismConfigurationDescription;

/// Describes configuration parameters for a Managed Service for Apache Flink
/// application.
pub const FlinkApplicationConfigurationDescription = struct {
    /// Describes an application's checkpointing configuration. Checkpointing is the
    /// process of persisting application state
    /// for fault tolerance.
    checkpoint_configuration_description: ?CheckpointConfigurationDescription,

    /// The job plan for an application. For more information about the job plan,
    /// see [Jobs and
    /// Scheduling](https://nightlies.apache.org/flink/flink-docs-release-1.20/internals/job_scheduling.html) in the [Apache Flink
    /// Documentation](https://nightlies.apache.org/flink/flink-docs-release-1.20/).
    /// To retrieve the job plan for the application, use the
    /// DescribeApplicationRequest$IncludeAdditionalDetails parameter of the
    /// DescribeApplication operation.
    job_plan_description: ?[]const u8,

    /// Describes configuration parameters for Amazon CloudWatch logging for an
    /// application.
    monitoring_configuration_description: ?MonitoringConfigurationDescription,

    /// Describes parameters for how an application executes multiple tasks
    /// simultaneously.
    parallelism_configuration_description: ?ParallelismConfigurationDescription,

    pub const json_field_names = .{
        .checkpoint_configuration_description = "CheckpointConfigurationDescription",
        .job_plan_description = "JobPlanDescription",
        .monitoring_configuration_description = "MonitoringConfigurationDescription",
        .parallelism_configuration_description = "ParallelismConfigurationDescription",
    };
};
