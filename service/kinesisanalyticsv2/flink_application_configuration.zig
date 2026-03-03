const CheckpointConfiguration = @import("checkpoint_configuration.zig").CheckpointConfiguration;
const MonitoringConfiguration = @import("monitoring_configuration.zig").MonitoringConfiguration;
const ParallelismConfiguration = @import("parallelism_configuration.zig").ParallelismConfiguration;

/// Describes configuration parameters for a Managed Service for Apache Flink
/// application or a Studio notebook.
pub const FlinkApplicationConfiguration = struct {
    /// Describes an application's checkpointing configuration. Checkpointing is the
    /// process of persisting application state for fault tolerance.
    /// For more information, see
    /// [
    /// Checkpoints for Fault
    /// Tolerance](https://nightlies.apache.org/flink/flink-docs-release-1.20/docs/dev/datastream/fault-tolerance/checkpointing/#enabling-and-configuring-checkpointing) in the
    /// [Apache Flink
    /// Documentation](https://nightlies.apache.org/flink/flink-docs-release-1.20/).
    checkpoint_configuration: ?CheckpointConfiguration = null,

    /// Describes configuration parameters for Amazon CloudWatch logging for an
    /// application.
    monitoring_configuration: ?MonitoringConfiguration = null,

    /// Describes parameters for how an application executes multiple tasks
    /// simultaneously.
    parallelism_configuration: ?ParallelismConfiguration = null,

    pub const json_field_names = .{
        .checkpoint_configuration = "CheckpointConfiguration",
        .monitoring_configuration = "MonitoringConfiguration",
        .parallelism_configuration = "ParallelismConfiguration",
    };
};
