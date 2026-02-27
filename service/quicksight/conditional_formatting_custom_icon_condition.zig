const ConditionalFormattingIconDisplayConfiguration = @import("conditional_formatting_icon_display_configuration.zig").ConditionalFormattingIconDisplayConfiguration;
const ConditionalFormattingCustomIconOptions = @import("conditional_formatting_custom_icon_options.zig").ConditionalFormattingCustomIconOptions;

/// Determines the custom condition for an icon set.
pub const ConditionalFormattingCustomIconCondition = struct {
    /// Determines the color of the icon.
    color: ?[]const u8,

    /// Determines the icon display configuration.
    display_configuration: ?ConditionalFormattingIconDisplayConfiguration,

    /// The expression that determines the condition of the icon set.
    expression: []const u8,

    /// Custom icon options for an icon set.
    icon_options: ConditionalFormattingCustomIconOptions,

    pub const json_field_names = .{
        .color = "Color",
        .display_configuration = "DisplayConfiguration",
        .expression = "Expression",
        .icon_options = "IconOptions",
    };
};
