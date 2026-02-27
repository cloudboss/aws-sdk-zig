const ShapeConditionalFormat = @import("shape_conditional_format.zig").ShapeConditionalFormat;

/// The conditional formatting that determines the shape of the filled map.
pub const FilledMapShapeConditionalFormatting = struct {
    /// The field ID of the filled map shape.
    field_id: []const u8,

    /// The conditional formatting that determines the background color of a filled
    /// map's shape.
    format: ?ShapeConditionalFormat,

    pub const json_field_names = .{
        .field_id = "FieldId",
        .format = "Format",
    };
};
