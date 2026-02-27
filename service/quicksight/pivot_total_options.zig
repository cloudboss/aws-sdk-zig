const TableCellStyle = @import("table_cell_style.zig").TableCellStyle;
const TableTotalsPlacement = @import("table_totals_placement.zig").TableTotalsPlacement;
const TableTotalsScrollStatus = @import("table_totals_scroll_status.zig").TableTotalsScrollStatus;
const TotalAggregationOption = @import("total_aggregation_option.zig").TotalAggregationOption;
const Visibility = @import("visibility.zig").Visibility;

/// The optional configuration of totals cells in a `PivotTableVisual`.
pub const PivotTotalOptions = struct {
    /// The custom label string for the total cells.
    custom_label: ?[]const u8,

    /// The cell styling options for the total of header cells.
    metric_header_cell_style: ?TableCellStyle,

    /// The placement (start, end) for the total cells.
    placement: ?TableTotalsPlacement,

    /// The scroll status (pinned, scrolled) for the total cells.
    scroll_status: ?TableTotalsScrollStatus,

    /// The total aggregation options for each value field.
    total_aggregation_options: ?[]const TotalAggregationOption,

    /// The cell styling options for the total cells.
    total_cell_style: ?TableCellStyle,

    /// The visibility configuration for the total cells.
    totals_visibility: ?Visibility,

    /// The cell styling options for the totals of value cells.
    value_cell_style: ?TableCellStyle,

    pub const json_field_names = .{
        .custom_label = "CustomLabel",
        .metric_header_cell_style = "MetricHeaderCellStyle",
        .placement = "Placement",
        .scroll_status = "ScrollStatus",
        .total_aggregation_options = "TotalAggregationOptions",
        .total_cell_style = "TotalCellStyle",
        .totals_visibility = "TotalsVisibility",
        .value_cell_style = "ValueCellStyle",
    };
};
