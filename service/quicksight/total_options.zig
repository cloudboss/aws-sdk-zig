const TableTotalsPlacement = @import("table_totals_placement.zig").TableTotalsPlacement;
const TableTotalsScrollStatus = @import("table_totals_scroll_status.zig").TableTotalsScrollStatus;
const TotalAggregationOption = @import("total_aggregation_option.zig").TotalAggregationOption;
const TableCellStyle = @import("table_cell_style.zig").TableCellStyle;
const Visibility = @import("visibility.zig").Visibility;

/// The total options for a table visual.
pub const TotalOptions = struct {
    /// The custom label string for the total cells.
    custom_label: ?[]const u8 = null,

    /// The placement (start, end) for the total cells.
    placement: ?TableTotalsPlacement = null,

    /// The scroll status (pinned, scrolled) for the total cells.
    scroll_status: ?TableTotalsScrollStatus = null,

    /// The total aggregation settings for each value field.
    total_aggregation_options: ?[]const TotalAggregationOption = null,

    /// Cell styling options for the total cells.
    total_cell_style: ?TableCellStyle = null,

    /// The visibility configuration for the total cells.
    totals_visibility: ?Visibility = null,

    pub const json_field_names = .{
        .custom_label = "CustomLabel",
        .placement = "Placement",
        .scroll_status = "ScrollStatus",
        .total_aggregation_options = "TotalAggregationOptions",
        .total_cell_style = "TotalCellStyle",
        .totals_visibility = "TotalsVisibility",
    };
};
