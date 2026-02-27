const FilledMapConditionalFormattingOption = @import("filled_map_conditional_formatting_option.zig").FilledMapConditionalFormattingOption;

/// The conditional formatting of a `FilledMapVisual`.
pub const FilledMapConditionalFormatting = struct {
    /// Conditional formatting options of a `FilledMapVisual`.
    conditional_formatting_options: []const FilledMapConditionalFormattingOption,

    pub const json_field_names = .{
        .conditional_formatting_options = "ConditionalFormattingOptions",
    };
};
