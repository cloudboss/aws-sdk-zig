const ConditionalFormattingIconDisplayOption = @import("conditional_formatting_icon_display_option.zig").ConditionalFormattingIconDisplayOption;

/// Determines the icon display configuration.
pub const ConditionalFormattingIconDisplayConfiguration = struct {
    /// Determines the icon display configuration.
    icon_display_option: ?ConditionalFormattingIconDisplayOption = null,

    pub const json_field_names = .{
        .icon_display_option = "IconDisplayOption",
    };
};
