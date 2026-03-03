/// Shows the scaling configuration for a Neptune Serverless DB cluster.
///
/// For more information, see [Using Amazon Neptune
/// Serverless](https://docs.aws.amazon.com/neptune/latest/userguide/neptune-serverless-using.html) in the
/// *Amazon Neptune User Guide*.
pub const ServerlessV2ScalingConfigurationInfo = struct {
    /// The maximum number of Neptune capacity units (NCUs) for a DB instance in a
    /// Neptune Serverless cluster.
    /// You can specify NCU values in half-step increments, such as 40, 40.5, 41,
    /// and so on.
    max_capacity: ?f64 = null,

    /// The minimum number of Neptune capacity units (NCUs) for a DB instance in a
    /// Neptune Serverless cluster.
    /// You can specify NCU values in half-step increments, such as 8, 8.5, 9, and
    /// so on.
    min_capacity: ?f64 = null,
};
