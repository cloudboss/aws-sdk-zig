const ColumnIdentifier = @import("column_identifier.zig").ColumnIdentifier;
const ColumnSort = @import("column_sort.zig").ColumnSort;

/// Describes the **Category** dataset column and constraints for the dynamic
/// values used to repeat the contents of a section.
pub const BodySectionDynamicCategoryDimensionConfiguration = struct {
    column: ColumnIdentifier,

    /// Number of values to use from the column for repetition.
    limit: ?i32 = null,

    /// Sort criteria on the column values that you use for repetition.
    sort_by_metrics: ?[]const ColumnSort = null,

    pub const json_field_names = .{
        .column = "Column",
        .limit = "Limit",
        .sort_by_metrics = "SortByMetrics",
    };
};
