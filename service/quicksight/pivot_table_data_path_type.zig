pub const PivotTableDataPathType = enum {
    hierarchy_rows_layout_column,
    multiple_row_metrics_column,
    empty_column_header,
    count_metric_column,

    pub const json_field_names = .{
        .hierarchy_rows_layout_column = "HIERARCHY_ROWS_LAYOUT_COLUMN",
        .multiple_row_metrics_column = "MULTIPLE_ROW_METRICS_COLUMN",
        .empty_column_header = "EMPTY_COLUMN_HEADER",
        .count_metric_column = "COUNT_METRIC_COLUMN",
    };
};
