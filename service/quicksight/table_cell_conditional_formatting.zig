const TextConditionalFormat = @import("text_conditional_format.zig").TextConditionalFormat;

/// The cell conditional formatting option for a table.
pub const TableCellConditionalFormatting = struct {
    /// The field ID of the cell for conditional formatting.
    field_id: []const u8,

    /// The text format of the cell for conditional formatting.
    text_format: ?TextConditionalFormat = null,

    pub const json_field_names = .{
        .field_id = "FieldId",
        .text_format = "TextFormat",
    };
};
