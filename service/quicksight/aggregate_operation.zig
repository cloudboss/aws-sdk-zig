const Aggregation = @import("aggregation.zig").Aggregation;
const TransformOperationSource = @import("transform_operation_source.zig").TransformOperationSource;

/// A transform operation that groups rows by specified columns and applies
/// aggregation functions
/// to calculate summary values.
pub const AggregateOperation = struct {
    /// The list of aggregation functions to apply to the grouped data, such as
    /// `SUM`,
    /// `COUNT`, or `AVERAGE`.
    aggregations: []const Aggregation,

    /// Alias for this operation.
    alias: []const u8,

    /// The list of column names to group by when performing the aggregation. Rows
    /// with the same values in
    /// these columns will be grouped together.
    group_by_column_names: ?[]const []const u8 = null,

    /// The source transform operation that provides input data for the aggregation.
    source: TransformOperationSource,

    pub const json_field_names = .{
        .aggregations = "Aggregations",
        .alias = "Alias",
        .group_by_column_names = "GroupByColumnNames",
        .source = "Source",
    };
};
