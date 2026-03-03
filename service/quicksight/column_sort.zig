const AggregationFunction = @import("aggregation_function.zig").AggregationFunction;
const SortDirection = @import("sort_direction.zig").SortDirection;
const ColumnIdentifier = @import("column_identifier.zig").ColumnIdentifier;

/// The sort configuration for a column that is not used in a field well.
pub const ColumnSort = struct {
    /// The aggregation function that is defined in the column sort.
    aggregation_function: ?AggregationFunction = null,

    /// The sort direction.
    direction: SortDirection,

    sort_by: ColumnIdentifier,

    pub const json_field_names = .{
        .aggregation_function = "AggregationFunction",
        .direction = "Direction",
        .sort_by = "SortBy",
    };
};
