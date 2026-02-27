/// A filter name and value pair that is used to return a more specific list of
/// results from a describe operation. Filters can be used to match a set of
/// resources by specific criteria, such as IDs. The filters supported by a
/// describe operation are documented with the describe operation.
///
/// Currently, wildcards are not supported in filters.
///
/// The following actions can be filtered:
///
/// * `DescribeDBClusterBacktracks`
/// * `DescribeDBClusterEndpoints`
/// * `DescribeDBClusters`
/// * `DescribeDBInstances`
/// * `DescribeDBRecommendations`
/// * `DescribeDBShardGroups`
/// * `DescribePendingMaintenanceActions`
pub const Filter = struct {
    /// The name of the filter. Filter names are case-sensitive.
    name: []const u8,

    /// One or more filter values. Filter values are case-sensitive.
    values: []const []const u8,
};
