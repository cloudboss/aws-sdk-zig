/// Contains the scaling configuration of an Aurora Serverless v2 DB cluster.
///
/// For more information, see [Using Amazon Aurora Serverless
/// v2](https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/aurora-serverless-v2.html) in the *Amazon Aurora User Guide*.
pub const ServerlessV2ScalingConfiguration = struct {
    /// The maximum number of Aurora capacity units (ACUs) for a DB instance in an
    /// Aurora Serverless v2 cluster. You can specify ACU values in half-step
    /// increments, such as 32, 32.5, 33, and so on. The largest value that you can
    /// use is 256 for recent Aurora versions, or 128 for older versions. You can
    /// check the attributes of your engine version or platform version to determine
    /// the specific maximum capacity supported.
    max_capacity: ?f64 = null,

    /// The minimum number of Aurora capacity units (ACUs) for a DB instance in an
    /// Aurora Serverless v2 cluster. You can specify ACU values in half-step
    /// increments, such as 8, 8.5, 9, and so on. For Aurora versions that support
    /// the Aurora Serverless v2 auto-pause feature, the smallest value that you can
    /// use is 0. For versions that don't support Aurora Serverless v2 auto-pause,
    /// the smallest value that you can use is 0.5.
    min_capacity: ?f64 = null,

    /// Specifies the number of seconds an Aurora Serverless v2 DB instance must be
    /// idle before Aurora attempts to automatically pause it.
    ///
    /// Specify a value between 300 seconds (five minutes) and 86,400 seconds (one
    /// day). The default is 300 seconds.
    seconds_until_auto_pause: ?i32 = null,
};
