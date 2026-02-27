const ConditionalFormattingIconSetType = @import("conditional_formatting_icon_set_type.zig").ConditionalFormattingIconSetType;

/// Formatting configuration for icon set.
pub const ConditionalFormattingIconSet = struct {
    /// The expression that determines the formatting configuration for the icon
    /// set.
    expression: []const u8,

    /// Determines the icon set type.
    icon_set_type: ?ConditionalFormattingIconSetType,

    pub const json_field_names = .{
        .expression = "Expression",
        .icon_set_type = "IconSetType",
    };
};
