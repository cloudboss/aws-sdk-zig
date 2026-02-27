const CheckpointConfigurationUpdate = @import("checkpoint_configuration_update.zig").CheckpointConfigurationUpdate;
const MonitoringConfigurationUpdate = @import("monitoring_configuration_update.zig").MonitoringConfigurationUpdate;
const ParallelismConfigurationUpdate = @import("parallelism_configuration_update.zig").ParallelismConfigurationUpdate;

/// Describes updates to the configuration parameters for a Managed Service for
/// Apache Flink application.
pub const FlinkApplicationConfigurationUpdate = struct {
    /// Describes updates to an application's checkpointing configuration.
    /// Checkpointing is the process of persisting
    /// application state for fault tolerance.
    checkpoint_configuration_update: ?CheckpointConfigurationUpdate,

    /// Describes updates to the configuration parameters for Amazon CloudWatch
    /// logging for an
    /// application.
    monitoring_configuration_update: ?MonitoringConfigurationUpdate,

    /// Describes updates to the parameters for how an application executes multiple
    /// tasks simultaneously.
    parallelism_configuration_update: ?ParallelismConfigurationUpdate,

    pub const json_field_names = .{
        .checkpoint_configuration_update = "CheckpointConfigurationUpdate",
        .monitoring_configuration_update = "MonitoringConfigurationUpdate",
        .parallelism_configuration_update = "ParallelismConfigurationUpdate",
    };
};
