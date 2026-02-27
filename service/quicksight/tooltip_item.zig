const ColumnTooltipItem = @import("column_tooltip_item.zig").ColumnTooltipItem;
const FieldTooltipItem = @import("field_tooltip_item.zig").FieldTooltipItem;

/// The tooltip.
///
/// This is a union type structure. For this structure to be valid, only one of
/// the attributes can be defined.
pub const TooltipItem = struct {
    /// The tooltip item for the columns that are not part of a field well.
    column_tooltip_item: ?ColumnTooltipItem,

    /// The tooltip item for the fields.
    field_tooltip_item: ?FieldTooltipItem,

    pub const json_field_names = .{
        .column_tooltip_item = "ColumnTooltipItem",
        .field_tooltip_item = "FieldTooltipItem",
    };
};
