const ResultRowValue = @import("result_row_value.zig").ResultRowValue;

/// Provides the results of a query that retrieved the data for a standard
/// metric that applies to an application, campaign, or journey.
pub const ResultRow = struct {
    /// An array of objects that defines the field and field values that were used
    /// to group data in a result set that contains multiple results. This value is
    /// null if the data in a result set isn’t grouped.
    grouped_bys: []const ResultRowValue,

    /// An array of objects that provides pre-aggregated values for a standard
    /// metric that applies to an application, campaign, or journey.
    values: []const ResultRowValue,

    pub const json_field_names = .{
        .grouped_bys = "GroupedBys",
        .values = "Values",
    };
};
