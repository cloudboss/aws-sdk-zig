const VisualCustomAction = @import("visual_custom_action.zig").VisualCustomAction;
const PivotTableConfiguration = @import("pivot_table_configuration.zig").PivotTableConfiguration;
const PivotTableConditionalFormatting = @import("pivot_table_conditional_formatting.zig").PivotTableConditionalFormatting;
const VisualSubtitleLabelOptions = @import("visual_subtitle_label_options.zig").VisualSubtitleLabelOptions;
const VisualTitleLabelOptions = @import("visual_title_label_options.zig").VisualTitleLabelOptions;

/// A pivot table.
///
/// For more information, see [Using pivot
/// tables](https://docs.aws.amazon.com/quicksight/latest/user/pivot-table.html)
/// in the *Amazon Quick Suite User Guide*.
pub const PivotTableVisual = struct {
    /// The list of custom actions that are configured for a visual.
    actions: ?[]const VisualCustomAction,

    /// The configuration settings of the visual.
    chart_configuration: ?PivotTableConfiguration,

    /// The conditional formatting for a `PivotTableVisual`.
    conditional_formatting: ?PivotTableConditionalFormatting,

    /// The subtitle that is displayed on the visual.
    subtitle: ?VisualSubtitleLabelOptions,

    /// The title that is displayed on the visual.
    title: ?VisualTitleLabelOptions,

    /// The alt text for the visual.
    visual_content_alt_text: ?[]const u8,

    /// The unique identifier of a visual. This identifier must be unique within the
    /// context of a dashboard, template, or analysis. Two dashboards, analyses, or
    /// templates can have visuals with the same identifiers..
    visual_id: []const u8,

    pub const json_field_names = .{
        .actions = "Actions",
        .chart_configuration = "ChartConfiguration",
        .conditional_formatting = "ConditionalFormatting",
        .subtitle = "Subtitle",
        .title = "Title",
        .visual_content_alt_text = "VisualContentAltText",
        .visual_id = "VisualId",
    };
};
