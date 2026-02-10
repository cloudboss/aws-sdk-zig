const Comparison = @import("comparison.zig").Comparison;
const FilterByDimension = @import("filter_by_dimension.zig").FilterByDimension;

/// Specifies a condition for filtering capacity data based on dimension values.
/// Used to create precise filters for metric queries and dimension lookups.
pub const DimensionCondition = struct {
    /// The comparison operator to use for the filter.
    comparison: ?Comparison,

    /// The name of the dimension to filter by.
    dimension: ?FilterByDimension,

    /// The list of values to match against the specified dimension. For 'equals'
    /// comparison, only the first value is used. For 'in' comparison, any matching
    /// value will satisfy the condition.
    values: ?[]const []const u8,
};
