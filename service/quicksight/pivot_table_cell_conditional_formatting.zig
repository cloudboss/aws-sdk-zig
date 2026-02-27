const PivotTableConditionalFormattingScope = @import("pivot_table_conditional_formatting_scope.zig").PivotTableConditionalFormattingScope;
const TextConditionalFormat = @import("text_conditional_format.zig").TextConditionalFormat;

/// The cell conditional formatting option for a pivot table.
pub const PivotTableCellConditionalFormatting = struct {
    /// The field ID of the cell for conditional formatting.
    field_id: []const u8,

    /// The scope of the cell for conditional formatting.
    scope: ?PivotTableConditionalFormattingScope,

    /// A list of cell scopes for conditional formatting.
    scopes: ?[]const PivotTableConditionalFormattingScope,

    /// The text format of the cell for conditional formatting.
    text_format: ?TextConditionalFormat,

    pub const json_field_names = .{
        .field_id = "FieldId",
        .scope = "Scope",
        .scopes = "Scopes",
        .text_format = "TextFormat",
    };
};
