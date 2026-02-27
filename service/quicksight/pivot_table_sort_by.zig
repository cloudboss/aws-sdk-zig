const ColumnSort = @import("column_sort.zig").ColumnSort;
const DataPathSort = @import("data_path_sort.zig").DataPathSort;
const FieldSort = @import("field_sort.zig").FieldSort;

/// The sort by field for the field sort options.
pub const PivotTableSortBy = struct {
    /// The column sort (field id, direction) for the pivot table sort by options.
    column: ?ColumnSort,

    /// The data path sort (data path value, direction) for the pivot table sort by
    /// options.
    data_path: ?DataPathSort,

    /// The field sort (field id, direction) for the pivot table sort by options.
    field: ?FieldSort,

    pub const json_field_names = .{
        .column = "Column",
        .data_path = "DataPath",
        .field = "Field",
    };
};
