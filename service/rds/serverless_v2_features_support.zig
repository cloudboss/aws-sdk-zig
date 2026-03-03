/// Specifies any Aurora Serverless v2 properties or limits that differ between
/// Aurora engine versions and platform versions. You can test the values of
/// this attribute when deciding which Aurora version to use in a new or
/// upgraded DB cluster. You can also retrieve the version of an existing DB
/// cluster and check whether that version supports certain Aurora Serverless v2
/// features before you attempt to use those features.
pub const ServerlessV2FeaturesSupport = struct {
    /// Specifies the upper Aurora Serverless v2 capacity limit for a particular
    /// engine version or platform version. Depending on the engine version, the
    /// maximum capacity for an Aurora Serverless v2 cluster might be `256` or
    /// `128`.
    max_capacity: ?f64 = null,

    /// If the minimum capacity is 0 ACUs, the engine version or platform version
    /// supports the automatic pause/resume feature of Aurora Serverless v2.
    min_capacity: ?f64 = null,
};
