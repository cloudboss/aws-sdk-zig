const SubtotalOptions = @import("subtotal_options.zig").SubtotalOptions;
const PivotTotalOptions = @import("pivot_total_options.zig").PivotTotalOptions;

/// The total options for a pivot table visual.
pub const PivotTableTotalOptions = struct {
    /// The column subtotal options.
    column_subtotal_options: ?SubtotalOptions,

    /// The column total options.
    column_total_options: ?PivotTotalOptions,

    /// The row subtotal options.
    row_subtotal_options: ?SubtotalOptions,

    /// The row total options.
    row_total_options: ?PivotTotalOptions,

    pub const json_field_names = .{
        .column_subtotal_options = "ColumnSubtotalOptions",
        .column_total_options = "ColumnTotalOptions",
        .row_subtotal_options = "RowSubtotalOptions",
        .row_total_options = "RowTotalOptions",
    };
};
