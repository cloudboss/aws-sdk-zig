const ConfigurationType = @import("configuration_type.zig").ConfigurationType;

/// Describes checkpointing parameters for a Managed Service for Apache Flink
/// application.
pub const CheckpointConfigurationDescription = struct {
    /// Describes whether checkpointing is enabled for a Managed Service for Apache
    /// Flink application.
    ///
    /// If `CheckpointConfiguration.ConfigurationType` is `DEFAULT`,
    /// the application will use a `CheckpointingEnabled` value of `true`, even if
    /// this value is set to
    /// another value using this API or in application code.
    checkpointing_enabled: ?bool,

    /// Describes the interval in milliseconds between checkpoint operations.
    ///
    /// If `CheckpointConfiguration.ConfigurationType` is `DEFAULT`,
    /// the application will use a `CheckpointInterval` value of 60000, even if this
    /// value is set to another value
    /// using this API or in application code.
    checkpoint_interval: ?i64,

    /// Describes whether the application uses the default checkpointing behavior in
    /// Managed Service for Apache Flink.
    ///
    /// If this value is set to `DEFAULT`, the application will use the following
    /// values,
    /// even if they are set to other values using APIs or
    /// application code:
    ///
    /// * **CheckpointingEnabled:** true
    ///
    /// * **CheckpointInterval:** 60000
    ///
    /// * **MinPauseBetweenCheckpoints:** 5000
    configuration_type: ?ConfigurationType,

    /// Describes the minimum time in milliseconds after a checkpoint operation
    /// completes that a new checkpoint operation
    /// can start.
    ///
    /// If `CheckpointConfiguration.ConfigurationType` is `DEFAULT`,
    /// the application will use a `MinPauseBetweenCheckpoints` value of 5000, even
    /// if this value is set using this
    /// API or in application code.
    min_pause_between_checkpoints: ?i64,

    pub const json_field_names = .{
        .checkpointing_enabled = "CheckpointingEnabled",
        .checkpoint_interval = "CheckpointInterval",
        .configuration_type = "ConfigurationType",
        .min_pause_between_checkpoints = "MinPauseBetweenCheckpoints",
    };
};
