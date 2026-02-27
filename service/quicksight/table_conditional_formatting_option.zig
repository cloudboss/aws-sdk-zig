const TableCellConditionalFormatting = @import("table_cell_conditional_formatting.zig").TableCellConditionalFormatting;
const TableRowConditionalFormatting = @import("table_row_conditional_formatting.zig").TableRowConditionalFormatting;

/// Conditional formatting options for a `PivotTableVisual`.
pub const TableConditionalFormattingOption = struct {
    /// The cell conditional formatting option for a table.
    cell: ?TableCellConditionalFormatting,

    /// The row conditional formatting option for a table.
    row: ?TableRowConditionalFormatting,

    pub const json_field_names = .{
        .cell = "Cell",
        .row = "Row",
    };
};
