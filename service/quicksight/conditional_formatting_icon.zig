const ConditionalFormattingCustomIconCondition = @import("conditional_formatting_custom_icon_condition.zig").ConditionalFormattingCustomIconCondition;
const ConditionalFormattingIconSet = @import("conditional_formatting_icon_set.zig").ConditionalFormattingIconSet;

/// The formatting configuration for the icon.
pub const ConditionalFormattingIcon = struct {
    /// Determines the custom condition for an icon set.
    custom_condition: ?ConditionalFormattingCustomIconCondition,

    /// Formatting configuration for icon set.
    icon_set: ?ConditionalFormattingIconSet,

    pub const json_field_names = .{
        .custom_condition = "CustomCondition",
        .icon_set = "IconSet",
    };
};
