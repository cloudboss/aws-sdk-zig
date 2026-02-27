const AggregationFunction = @import("aggregation_function.zig").AggregationFunction;
const ColumnIdentifier = @import("column_identifier.zig").ColumnIdentifier;
const SortDirection = @import("sort_direction.zig").SortDirection;

/// The configuration options to sort aggregated values.
pub const AggregationSortConfiguration = struct {
    /// The function that aggregates the values in `Column`.
    aggregation_function: ?AggregationFunction,

    /// The column that determines the sort order of aggregated values.
    column: ColumnIdentifier,

    /// The sort direction of values.
    ///
    /// * `ASC`: Sort in ascending order.
    ///
    /// * `DESC`: Sort in descending order.
    sort_direction: SortDirection,

    pub const json_field_names = .{
        .aggregation_function = "AggregationFunction",
        .column = "Column",
        .sort_direction = "SortDirection",
    };
};
