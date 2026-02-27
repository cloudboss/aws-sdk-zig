const PivotTableDataPathType = @import("pivot_table_data_path_type.zig").PivotTableDataPathType;

/// The type of the data path value.
pub const DataPathType = struct {
    /// The type of data path value utilized in a pivot table. Choose one of the
    /// following options:
    ///
    /// * `HIERARCHY_ROWS_LAYOUT_COLUMN` - The type of data path for the rows layout
    ///   column, when `RowsLayout` is set to `HIERARCHY`.
    ///
    /// * `MULTIPLE_ROW_METRICS_COLUMN` - The type of data path for the metric
    ///   column when the row is set to Metric Placement.
    ///
    /// * `EMPTY_COLUMN_HEADER` - The type of data path for the column with empty
    ///   column header, when there is no field in `ColumnsFieldWell` and the row is
    ///   set to Metric Placement.
    ///
    /// * `COUNT_METRIC_COLUMN` - The type of data path for the column with `COUNT`
    ///   as the metric, when there is no field in the `ValuesFieldWell`.
    pivot_table_data_path_type: ?PivotTableDataPathType,

    pub const json_field_names = .{
        .pivot_table_data_path_type = "PivotTableDataPathType",
    };
};
