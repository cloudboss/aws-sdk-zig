const QuerySpatialCoverageMax = @import("query_spatial_coverage_max.zig").QuerySpatialCoverageMax;

/// Provides insights into the spatial coverage of the query, including the
/// table with sub-optimal (max) spatial pruning. This information can help you
/// identify areas for improvement in your partitioning strategy to enhance
/// spatial pruning
///
/// For example, you can do the following with the `QuerySpatialCoverage`
/// information:
///
/// * Add measure_name or use [customer-defined partition
///   key](https://docs.aws.amazon.com/timestream/latest/developerguide/customer-defined-partition-keys.html) (CDPK) predicates.
///
/// * If you've already done the preceding action, remove functions around them
///   or clauses, such as `LIKE`.
pub const QuerySpatialCoverage = struct {
    /// Provides insights into the spatial coverage of the executed query and the
    /// table with the most inefficient spatial pruning.
    ///
    /// * `Value` – The maximum ratio of spatial coverage.
    ///
    /// * `TableArn` – The Amazon Resource Name (ARN) of the table with sub-optimal
    ///   spatial pruning.
    ///
    /// * `PartitionKey` – The partition key used for partitioning, which can be a
    ///   default `measure_name` or a CDPK.
    max: ?QuerySpatialCoverageMax,

    pub const json_field_names = .{
        .max = "Max",
    };
};
