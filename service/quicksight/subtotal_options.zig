const PivotTableSubtotalLevel = @import("pivot_table_subtotal_level.zig").PivotTableSubtotalLevel;
const PivotTableFieldSubtotalOptions = @import("pivot_table_field_subtotal_options.zig").PivotTableFieldSubtotalOptions;
const TableCellStyle = @import("table_cell_style.zig").TableCellStyle;
const TableStyleTarget = @import("table_style_target.zig").TableStyleTarget;
const Visibility = @import("visibility.zig").Visibility;

/// The subtotal options.
pub const SubtotalOptions = struct {
    /// The custom label string for the subtotal cells.
    custom_label: ?[]const u8 = null,

    /// The field level (all, custom, last) for the subtotal cells.
    field_level: ?PivotTableSubtotalLevel = null,

    /// The optional configuration of subtotal cells.
    field_level_options: ?[]const PivotTableFieldSubtotalOptions = null,

    /// The cell styling options for the subtotals of header cells.
    metric_header_cell_style: ?TableCellStyle = null,

    /// The style targets options for subtotals.
    style_targets: ?[]const TableStyleTarget = null,

    /// The cell styling options for the subtotal cells.
    total_cell_style: ?TableCellStyle = null,

    /// The visibility configuration for the subtotal cells.
    totals_visibility: ?Visibility = null,

    /// The cell styling options for the subtotals of value cells.
    value_cell_style: ?TableCellStyle = null,

    pub const json_field_names = .{
        .custom_label = "CustomLabel",
        .field_level = "FieldLevel",
        .field_level_options = "FieldLevelOptions",
        .metric_header_cell_style = "MetricHeaderCellStyle",
        .style_targets = "StyleTargets",
        .total_cell_style = "TotalCellStyle",
        .totals_visibility = "TotalsVisibility",
        .value_cell_style = "ValueCellStyle",
    };
};
