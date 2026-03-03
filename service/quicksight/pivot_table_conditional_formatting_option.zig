const PivotTableCellConditionalFormatting = @import("pivot_table_cell_conditional_formatting.zig").PivotTableCellConditionalFormatting;

/// Conditional formatting options for a `PivotTableVisual`.
pub const PivotTableConditionalFormattingOption = struct {
    /// The cell conditional formatting option for a pivot table.
    cell: ?PivotTableCellConditionalFormatting = null,

    pub const json_field_names = .{
        .cell = "Cell",
    };
};
