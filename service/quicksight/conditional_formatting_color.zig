const ConditionalFormattingGradientColor = @import("conditional_formatting_gradient_color.zig").ConditionalFormattingGradientColor;
const ConditionalFormattingSolidColor = @import("conditional_formatting_solid_color.zig").ConditionalFormattingSolidColor;

/// The formatting configuration for the color.
pub const ConditionalFormattingColor = struct {
    /// Formatting configuration for gradient color.
    gradient: ?ConditionalFormattingGradientColor = null,

    /// Formatting configuration for solid color.
    solid: ?ConditionalFormattingSolidColor = null,

    pub const json_field_names = .{
        .gradient = "Gradient",
        .solid = "Solid",
    };
};
