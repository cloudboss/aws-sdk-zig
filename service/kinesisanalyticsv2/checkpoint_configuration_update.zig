const ConfigurationType = @import("configuration_type.zig").ConfigurationType;

/// Describes updates to the checkpointing parameters for a Managed Service for
/// Apache Flink application.
pub const CheckpointConfigurationUpdate = struct {
    /// Describes updates to whether checkpointing is enabled for an application.
    ///
    /// If `CheckpointConfiguration.ConfigurationType` is `DEFAULT`,
    /// the application will use a `CheckpointingEnabled` value of `true`, even if
    /// this value is set to
    /// another value using this API or in application code.
    checkpointing_enabled_update: ?bool,

    /// Describes updates to the interval in milliseconds between checkpoint
    /// operations.
    ///
    /// If `CheckpointConfiguration.ConfigurationType` is `DEFAULT`,
    /// the application will use a `CheckpointInterval` value of 60000, even if this
    /// value is set to another value
    /// using this API or in application code.
    checkpoint_interval_update: ?i64,

    /// Describes updates to whether the application uses the default checkpointing
    /// behavior of
    /// Managed Service for Apache Flink. You must set this property to `CUSTOM` in
    /// order to set the
    /// `CheckpointingEnabled`, `CheckpointInterval`, or
    /// `MinPauseBetweenCheckpoints` parameters.
    ///
    /// If this value is set to `DEFAULT`, the application will use the following
    /// values, even if they are
    /// set to other values using APIs or
    /// application code:
    ///
    /// * **CheckpointingEnabled:** true
    ///
    /// * **CheckpointInterval:** 60000
    ///
    /// * **MinPauseBetweenCheckpoints:** 5000
    configuration_type_update: ?ConfigurationType,

    /// Describes updates to the minimum time in milliseconds after a checkpoint
    /// operation completes that a new checkpoint operation
    /// can start.
    ///
    /// If `CheckpointConfiguration.ConfigurationType` is `DEFAULT`,
    /// the application will use a `MinPauseBetweenCheckpoints` value of 5000, even
    /// if this value is set using this API or
    /// in application code.
    min_pause_between_checkpoints_update: ?i64,

    pub const json_field_names = .{
        .checkpointing_enabled_update = "CheckpointingEnabledUpdate",
        .checkpoint_interval_update = "CheckpointIntervalUpdate",
        .configuration_type_update = "ConfigurationTypeUpdate",
        .min_pause_between_checkpoints_update = "MinPauseBetweenCheckpointsUpdate",
    };
};
