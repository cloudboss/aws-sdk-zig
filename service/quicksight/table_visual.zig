const VisualCustomAction = @import("visual_custom_action.zig").VisualCustomAction;
const TableConfiguration = @import("table_configuration.zig").TableConfiguration;
const TableConditionalFormatting = @import("table_conditional_formatting.zig").TableConditionalFormatting;
const VisualSubtitleLabelOptions = @import("visual_subtitle_label_options.zig").VisualSubtitleLabelOptions;
const VisualTitleLabelOptions = @import("visual_title_label_options.zig").VisualTitleLabelOptions;

/// A table visual.
///
/// For more information, see [Using tables as
/// visuals](https://docs.aws.amazon.com/quicksight/latest/user/tabular.html) in
/// the *Amazon Quick Suite User Guide*.
pub const TableVisual = struct {
    /// The list of custom actions that are configured for a visual.
    actions: ?[]const VisualCustomAction = null,

    /// The configuration settings of the visual.
    chart_configuration: ?TableConfiguration = null,

    /// The conditional formatting for a `PivotTableVisual`.
    conditional_formatting: ?TableConditionalFormatting = null,

    /// The subtitle that is displayed on the visual.
    subtitle: ?VisualSubtitleLabelOptions = null,

    /// The title that is displayed on the visual.
    title: ?VisualTitleLabelOptions = null,

    /// The alt text for the visual.
    visual_content_alt_text: ?[]const u8 = null,

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
