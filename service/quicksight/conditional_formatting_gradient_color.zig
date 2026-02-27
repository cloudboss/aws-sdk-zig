const GradientColor = @import("gradient_color.zig").GradientColor;

/// Formatting configuration for gradient color.
pub const ConditionalFormattingGradientColor = struct {
    /// Determines the color.
    color: GradientColor,

    /// The expression that determines the formatting configuration for gradient
    /// color.
    expression: []const u8,

    pub const json_field_names = .{
        .color = "Color",
        .expression = "Expression",
    };
};
