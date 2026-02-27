/// Retrieves the scaling configuration for an Amazon DocumentDB Serverless
/// cluster.
pub const ServerlessV2ScalingConfigurationInfo = struct {
    /// The maximum number of Amazon DocumentDB capacity units (DCUs) for an
    /// instance in an Amazon DocumentDB Serverless cluster.
    /// You can specify DCU values in half-step increments, such as 32, 32.5, 33,
    /// and so on.
    max_capacity: ?f64,

    /// The minimum number of Amazon DocumentDB capacity units (DCUs) for an
    /// instance in an Amazon DocumentDB Serverless cluster.
    /// You can specify DCU values in half-step increments, such as 8, 8.5, 9, and
    /// so on.
    min_capacity: ?f64,
};
