const ColumnSort = @import("column_sort.zig").ColumnSort;
const FieldSort = @import("field_sort.zig").FieldSort;

/// The field sort options in a chart configuration.
pub const FieldSortOptions = struct {
    /// The sort configuration for a column that is not used in a field well.
    column_sort: ?ColumnSort,

    /// The sort configuration for a field in a field well.
    field_sort: ?FieldSort,

    pub const json_field_names = .{
        .column_sort = "ColumnSort",
        .field_sort = "FieldSort",
    };
};
