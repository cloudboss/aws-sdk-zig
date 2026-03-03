const ColorFillType = @import("color_fill_type.zig").ColorFillType;
const DataColor = @import("data_color.zig").DataColor;

/// Determines the color scale that is applied to the visual.
pub const ColorScale = struct {
    /// Determines the color fill type.
    color_fill_type: ColorFillType,

    /// Determines the list of colors that are applied to the visual.
    colors: []const DataColor,

    /// Determines the color that is applied to null values.
    null_value_color: ?DataColor = null,

    pub const json_field_names = .{
        .color_fill_type = "ColorFillType",
        .colors = "Colors",
        .null_value_color = "NullValueColor",
    };
};
