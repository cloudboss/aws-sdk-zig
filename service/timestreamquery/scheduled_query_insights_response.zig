const QuerySpatialCoverage = @import("query_spatial_coverage.zig").QuerySpatialCoverage;
const QueryTemporalRange = @import("query_temporal_range.zig").QueryTemporalRange;

/// Provides various insights and metrics related to the
/// `ExecuteScheduledQueryRequest` that was executed.
pub const ScheduledQueryInsightsResponse = struct {
    /// Indicates the size of query result set in bytes. You can use this data to
    /// validate if the result set has changed as part of the query tuning exercise.
    output_bytes: ?i64,

    /// Indicates the total number of rows returned as part of the query result set.
    /// You can use this data to validate if the number of rows in the result set
    /// have changed as part of the query tuning exercise.
    output_rows: ?i64,

    /// Provides insights into the spatial coverage of the query, including the
    /// table with sub-optimal (max) spatial pruning. This information can help you
    /// identify areas for improvement in your partitioning strategy to enhance
    /// spatial pruning.
    query_spatial_coverage: ?QuerySpatialCoverage,

    /// Indicates the number of tables in the query.
    query_table_count: ?i64,

    /// Provides insights into the temporal range of the query, including the table
    /// with the largest (max) time range. Following are some of the potential
    /// options for optimizing time-based pruning:
    ///
    /// * Add missing time-predicates.
    ///
    /// * Remove functions around the time predicates.
    ///
    /// * Add time predicates to all the sub-queries.
    query_temporal_range: ?QueryTemporalRange,

    pub const json_field_names = .{
        .output_bytes = "OutputBytes",
        .output_rows = "OutputRows",
        .query_spatial_coverage = "QuerySpatialCoverage",
        .query_table_count = "QueryTableCount",
        .query_temporal_range = "QueryTemporalRange",
    };
};
