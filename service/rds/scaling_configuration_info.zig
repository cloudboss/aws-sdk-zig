/// The scaling configuration for an Aurora DB cluster in `serverless` DB engine
/// mode.
///
/// For more information, see [Using Amazon Aurora Serverless
/// v1](https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/aurora-serverless.html) in the *Amazon Aurora User Guide*.
pub const ScalingConfigurationInfo = struct {
    /// Indicates whether automatic pause is allowed for the Aurora DB cluster in
    /// `serverless` DB engine mode.
    ///
    /// When the value is set to false for an Aurora Serverless v1 DB cluster, the
    /// DB cluster automatically resumes.
    auto_pause: ?bool = null,

    /// The maximum capacity for an Aurora DB cluster in `serverless` DB engine
    /// mode.
    max_capacity: ?i32 = null,

    /// The minimum capacity for an Aurora DB cluster in `serverless` DB engine
    /// mode.
    min_capacity: ?i32 = null,

    /// The number of seconds before scaling times out. What happens when an
    /// attempted scaling action times out is determined by the `TimeoutAction`
    /// setting.
    seconds_before_timeout: ?i32 = null,

    /// The remaining amount of time, in seconds, before the Aurora DB cluster in
    /// `serverless` mode is paused. A DB cluster can be paused only when it's idle
    /// (it has no connections).
    seconds_until_auto_pause: ?i32 = null,

    /// The action that occurs when Aurora times out while attempting to change the
    /// capacity of an Aurora Serverless v1 cluster. The value is either
    /// `ForceApplyCapacityChange` or `RollbackCapacityChange`.
    ///
    /// `ForceApplyCapacityChange`, the default, sets the capacity to the specified
    /// value as soon as possible.
    ///
    /// `RollbackCapacityChange` ignores the capacity change if a scaling point
    /// isn't found in the timeout period.
    timeout_action: ?[]const u8 = null,
};
