const FilledMapShapeConditionalFormatting = @import("filled_map_shape_conditional_formatting.zig").FilledMapShapeConditionalFormatting;

/// Conditional formatting options of a `FilledMapVisual`.
pub const FilledMapConditionalFormattingOption = struct {
    /// The conditional formatting that determines the shape of the filled map.
    shape: FilledMapShapeConditionalFormatting,

    pub const json_field_names = .{
        .shape = "Shape",
    };
};
