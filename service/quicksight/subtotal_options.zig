const PivotTableSubtotalLevel = @import("pivot_table_subtotal_level.zig").PivotTableSubtotalLevel;
const PivotTableFieldSubtotalOptions = @import("pivot_table_field_subtotal_options.zig").PivotTableFieldSubtotalOptions;
const TableCellStyle = @import("table_cell_style.zig").TableCellStyle;
const TableStyleTarget = @import("table_style_target.zig").TableStyleTarget;
const Visibility = @import("visibility.zig").Visibility;

/// The subtotal options.
pub const SubtotalOptions = struct {
    /// The custom label string for the subtotal cells.
    custom_label: ?[]const u8,

    /// The field level (all, custom, last) for the subtotal cells.
    field_level: ?PivotTableSubtotalLevel,

    /// The optional configuration of subtotal cells.
    field_level_options: ?[]const PivotTableFieldSubtotalOptions,

    /// The cell styling options for the subtotals of header cells.
    metric_header_cell_style: ?TableCellStyle,

    /// The style targets options for subtotals.
    style_targets: ?[]const TableStyleTarget,

    /// The cell styling options for the subtotal cells.
    total_cell_style: ?TableCellStyle,

    /// The visibility configuration for the subtotal cells.
    totals_visibility: ?Visibility,

    /// The cell styling options for the subtotals of value cells.
    value_cell_style: ?TableCellStyle,

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
