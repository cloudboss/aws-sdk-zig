const TargetSamplingRate = @import("target_sampling_rate.zig").TargetSamplingRate;

/// The configuration is the `TargetSamplingRate`, which is the sampling rate of
/// the data after post processing by Amazon Lookout for Equipment. For example,
/// if you provide data that has been
/// collected at a 1 second level and you want the system to resample the data
/// at a 1 minute
/// rate before training, the `TargetSamplingRate` is 1 minute.
///
/// When providing a value for the `TargetSamplingRate`, you must attach the
/// prefix "PT" to the rate you want. The value for a 1 second rate is therefore
/// *PT1S*, the value for a 15 minute rate is *PT15M*,
/// and the value for a 1 hour rate is *PT1H*
pub const DataPreProcessingConfiguration = struct {
    /// The sampling rate of the data after post processing by Amazon Lookout for
    /// Equipment. For example, if you
    /// provide data that has been collected at a 1 second level and you want the
    /// system to
    /// resample the data at a 1 minute rate before training, the
    /// `TargetSamplingRate`
    /// is 1 minute.
    ///
    /// When providing a value for the `TargetSamplingRate`, you must attach the
    /// prefix "PT" to the rate you want. The value for a 1 second rate is therefore
    /// *PT1S*, the value for a 15 minute rate is *PT15M*,
    /// and the value for a 1 hour rate is *PT1H*
    target_sampling_rate: ?TargetSamplingRate,

    pub const json_field_names = .{
        .target_sampling_rate = "TargetSamplingRate",
    };
};
