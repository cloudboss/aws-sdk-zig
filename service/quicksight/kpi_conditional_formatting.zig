const KPIConditionalFormattingOption = @import("kpi_conditional_formatting_option.zig").KPIConditionalFormattingOption;

/// The conditional formatting of a KPI visual.
pub const KPIConditionalFormatting = struct {
    /// The conditional formatting options of a KPI visual.
    conditional_formatting_options: ?[]const KPIConditionalFormattingOption,

    pub const json_field_names = .{
        .conditional_formatting_options = "ConditionalFormattingOptions",
    };
};
