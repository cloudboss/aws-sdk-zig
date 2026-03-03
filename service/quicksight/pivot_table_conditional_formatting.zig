const PivotTableConditionalFormattingOption = @import("pivot_table_conditional_formatting_option.zig").PivotTableConditionalFormattingOption;

/// The conditional formatting for a `PivotTableVisual`.
pub const PivotTableConditionalFormatting = struct {
    /// Conditional formatting options for a `PivotTableVisual`.
    conditional_formatting_options: ?[]const PivotTableConditionalFormattingOption = null,

    pub const json_field_names = .{
        .conditional_formatting_options = "ConditionalFormattingOptions",
    };
};
