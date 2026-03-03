const VisualCustomAction = @import("visual_custom_action.zig").VisualCustomAction;
const WaterfallChartConfiguration = @import("waterfall_chart_configuration.zig").WaterfallChartConfiguration;
const ColumnHierarchy = @import("column_hierarchy.zig").ColumnHierarchy;
const VisualSubtitleLabelOptions = @import("visual_subtitle_label_options.zig").VisualSubtitleLabelOptions;
const VisualTitleLabelOptions = @import("visual_title_label_options.zig").VisualTitleLabelOptions;

/// A waterfall chart.
///
/// For more information, see [Using waterfall
/// charts](https://docs.aws.amazon.com/quicksight/latest/user/waterfall-chart.html) in the *Amazon Quick Suite User Guide*.
pub const WaterfallVisual = struct {
    /// The list of custom actions that are configured for a visual.
    actions: ?[]const VisualCustomAction = null,

    /// The configuration for a waterfall visual.
    chart_configuration: ?WaterfallChartConfiguration = null,

    /// The column hierarchy that is used during drill-downs and drill-ups.
    column_hierarchies: ?[]const ColumnHierarchy = null,

    /// The subtitle that is displayed on the visual.
    subtitle: ?VisualSubtitleLabelOptions = null,

    /// The title that is displayed on the visual.
    title: ?VisualTitleLabelOptions = null,

    /// The alt text for the visual.
    visual_content_alt_text: ?[]const u8 = null,

    /// The unique identifier of a visual. This identifier must be unique within the
    /// context of a dashboard, template, or analysis. Two dashboards, analyses, or
    /// templates can have visuals with the same identifiers.
    visual_id: []const u8,

    pub const json_field_names = .{
        .actions = "Actions",
        .chart_configuration = "ChartConfiguration",
        .column_hierarchies = "ColumnHierarchies",
        .subtitle = "Subtitle",
        .title = "Title",
        .visual_content_alt_text = "VisualContentAltText",
        .visual_id = "VisualId",
    };
};
