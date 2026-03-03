const TableCellStyle = @import("table_cell_style.zig").TableCellStyle;
const Visibility = @import("visibility.zig").Visibility;
const PivotTableMetricPlacement = @import("pivot_table_metric_placement.zig").PivotTableMetricPlacement;
const RowAlternateColorOptions = @import("row_alternate_color_options.zig").RowAlternateColorOptions;
const PivotTableRowsLabelOptions = @import("pivot_table_rows_label_options.zig").PivotTableRowsLabelOptions;
const PivotTableRowsLayout = @import("pivot_table_rows_layout.zig").PivotTableRowsLayout;

/// The table options for a pivot table visual.
pub const PivotTableOptions = struct {
    /// The table cell style of cells.
    cell_style: ?TableCellStyle = null,

    /// The visibility setting of a pivot table's collapsed row dimension fields. If
    /// the value of this structure is `HIDDEN`, all collapsed columns in a pivot
    /// table are automatically hidden. The default value is `VISIBLE`.
    collapsed_row_dimensions_visibility: ?Visibility = null,

    /// The table cell style of the column header.
    column_header_style: ?TableCellStyle = null,

    /// The visibility of the column names.
    column_names_visibility: ?Visibility = null,

    /// The default cell width of the pivot table.
    default_cell_width: ?[]const u8 = null,

    /// The metric placement (row, column) options.
    metric_placement: ?PivotTableMetricPlacement = null,

    /// The row alternate color options (widget status, row alternate colors).
    row_alternate_color_options: ?RowAlternateColorOptions = null,

    /// The table cell style of row field names.
    row_field_names_style: ?TableCellStyle = null,

    /// The table cell style of the row headers.
    row_header_style: ?TableCellStyle = null,

    /// The options for the label that is located above the row headers. This option
    /// is only applicable when `RowsLayout` is set to `HIERARCHY`.
    rows_label_options: ?PivotTableRowsLabelOptions = null,

    /// The layout for the row dimension headers of a pivot table. Choose one of the
    /// following options.
    ///
    /// * `TABULAR`: (Default) Each row field is displayed in a separate column.
    ///
    /// * `HIERARCHY`: All row fields are displayed in a single column. Indentation
    ///   is used to differentiate row headers of different fields.
    rows_layout: ?PivotTableRowsLayout = null,

    /// The visibility of the single metric options.
    single_metric_visibility: ?Visibility = null,

    /// Determines the visibility of the pivot table.
    toggle_buttons_visibility: ?Visibility = null,

    pub const json_field_names = .{
        .cell_style = "CellStyle",
        .collapsed_row_dimensions_visibility = "CollapsedRowDimensionsVisibility",
        .column_header_style = "ColumnHeaderStyle",
        .column_names_visibility = "ColumnNamesVisibility",
        .default_cell_width = "DefaultCellWidth",
        .metric_placement = "MetricPlacement",
        .row_alternate_color_options = "RowAlternateColorOptions",
        .row_field_names_style = "RowFieldNamesStyle",
        .row_header_style = "RowHeaderStyle",
        .rows_label_options = "RowsLabelOptions",
        .rows_layout = "RowsLayout",
        .single_metric_visibility = "SingleMetricVisibility",
        .toggle_buttons_visibility = "ToggleButtonsVisibility",
    };
};
