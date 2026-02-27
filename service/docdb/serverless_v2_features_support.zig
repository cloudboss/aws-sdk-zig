/// Specifies any Amazon DocumentDB Serverless properties or limits that differ
/// between Amazon DocumentDB engine versions.
/// You can test the values of this attribute when deciding which Amazon
/// DocumentDB version to use in a new or upgraded cluster.
/// You can also retrieve the version of an existing cluster and check whether
/// that version supports certain Amazon DocumentDB Serverless features before
/// you attempt to use those features.
pub const ServerlessV2FeaturesSupport = struct {
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
