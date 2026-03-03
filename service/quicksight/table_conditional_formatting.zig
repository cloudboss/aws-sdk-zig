const TableConditionalFormattingOption = @import("table_conditional_formatting_option.zig").TableConditionalFormattingOption;

/// The conditional formatting for a `PivotTableVisual`.
pub const TableConditionalFormatting = struct {
    /// Conditional formatting options for a `PivotTableVisual`.
    conditional_formatting_options: ?[]const TableConditionalFormattingOption = null,

    pub const json_field_names = .{
        .conditional_formatting_options = "ConditionalFormattingOptions",
    };
};
