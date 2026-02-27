/// Formatting configuration for solid color.
pub const ConditionalFormattingSolidColor = struct {
    /// Determines the color.
    color: ?[]const u8,

    /// The expression that determines the formatting configuration for solid color.
    expression: []const u8,

    pub const json_field_names = .{
        .color = "Color",
        .expression = "Expression",
    };
};
