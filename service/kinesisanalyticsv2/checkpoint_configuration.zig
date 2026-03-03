const ConfigurationType = @import("configuration_type.zig").ConfigurationType;

/// Describes an application's checkpointing configuration. Checkpointing is the
/// process of persisting application state for fault
/// tolerance.
/// For more information, see
/// [
/// Checkpoints for Fault
/// Tolerance](https://nightlies.apache.org/flink/flink-docs-release-1.20/docs/dev/datastream/fault-tolerance/checkpointing/#enabling-and-configuring-checkpointing) in the
/// [Apache Flink
/// Documentation](https://nightlies.apache.org/flink/flink-docs-release-1.20/).
pub const CheckpointConfiguration = struct {
    /// Describes whether checkpointing is enabled for a Managed Service for Apache
    /// Flink application.
    ///
    /// If `CheckpointConfiguration.ConfigurationType` is `DEFAULT`,
    /// the application will use a `CheckpointingEnabled` value of `true`, even if
    /// this value
    /// is set to another value using this API or in application code.
    checkpointing_enabled: ?bool = null,

    /// Describes the interval in milliseconds between checkpoint operations.
    ///
    /// If `CheckpointConfiguration.ConfigurationType` is `DEFAULT`,
    /// the application will use a `CheckpointInterval` value of 60000, even if this
    /// value is set
    /// to another value using this API or in application code.
    checkpoint_interval: ?i64 = null,

    /// Describes whether the application uses Managed Service for Apache Flink'
    /// default checkpointing behavior.
    /// You must set this property to `CUSTOM` in order to set the
    /// `CheckpointingEnabled`, `CheckpointInterval`, or
    /// `MinPauseBetweenCheckpoints` parameters.
    ///
    /// If this value is set to `DEFAULT`, the application will use the following
    /// values, even if they are set to other values using APIs or
    /// application code:
    ///
    /// * **CheckpointingEnabled:** true
    ///
    /// * **CheckpointInterval:** 60000
    ///
    /// * **MinPauseBetweenCheckpoints:** 5000
    configuration_type: ConfigurationType,

    /// Describes the minimum time in milliseconds after a checkpoint operation
    /// completes that a
    /// new checkpoint operation can start. If a checkpoint operation takes longer
    /// than the
    /// `CheckpointInterval`, the application otherwise performs continual
    /// checkpoint
    /// operations. For more information, see [ Tuning
    /// Checkpointing](https://nightlies.apache.org/flink/flink-docs-release-1.20/docs/ops/state/large_state_tuning/#tuning-checkpointing) in the [Apache Flink
    /// Documentation](https://nightlies.apache.org/flink/flink-docs-release-1.20/).
    ///
    /// If `CheckpointConfiguration.ConfigurationType` is `DEFAULT`,
    /// the application will use a `MinPauseBetweenCheckpoints` value of 5000, even
    /// if this value is set using this
    /// API or in application code.
    min_pause_between_checkpoints: ?i64 = null,

    pub const json_field_names = .{
        .checkpointing_enabled = "CheckpointingEnabled",
        .checkpoint_interval = "CheckpointInterval",
        .configuration_type = "ConfigurationType",
        .min_pause_between_checkpoints = "MinPauseBetweenCheckpoints",
    };
};
