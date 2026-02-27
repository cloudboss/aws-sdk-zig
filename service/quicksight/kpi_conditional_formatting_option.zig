const KPIActualValueConditionalFormatting = @import("kpi_actual_value_conditional_formatting.zig").KPIActualValueConditionalFormatting;
const KPIComparisonValueConditionalFormatting = @import("kpi_comparison_value_conditional_formatting.zig").KPIComparisonValueConditionalFormatting;
const KPIPrimaryValueConditionalFormatting = @import("kpi_primary_value_conditional_formatting.zig").KPIPrimaryValueConditionalFormatting;
const KPIProgressBarConditionalFormatting = @import("kpi_progress_bar_conditional_formatting.zig").KPIProgressBarConditionalFormatting;

/// The conditional formatting options of a KPI visual.
pub const KPIConditionalFormattingOption = struct {
    /// The conditional formatting for the actual value of a KPI visual.
    actual_value: ?KPIActualValueConditionalFormatting,

    /// The conditional formatting for the comparison value of a KPI visual.
    comparison_value: ?KPIComparisonValueConditionalFormatting,

    /// The conditional formatting for the primary value of a KPI visual.
    primary_value: ?KPIPrimaryValueConditionalFormatting,

    /// The conditional formatting for the progress bar of a KPI visual.
    progress_bar: ?KPIProgressBarConditionalFormatting,

    pub const json_field_names = .{
        .actual_value = "ActualValue",
        .comparison_value = "ComparisonValue",
        .primary_value = "PrimaryValue",
        .progress_bar = "ProgressBar",
    };
};
