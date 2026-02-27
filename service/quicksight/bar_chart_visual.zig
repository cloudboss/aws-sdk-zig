const VisualCustomAction = @import("visual_custom_action.zig").VisualCustomAction;
const BarChartConfiguration = @import("bar_chart_configuration.zig").BarChartConfiguration;
const ColumnHierarchy = @import("column_hierarchy.zig").ColumnHierarchy;
const VisualSubtitleLabelOptions = @import("visual_subtitle_label_options.zig").VisualSubtitleLabelOptions;
const VisualTitleLabelOptions = @import("visual_title_label_options.zig").VisualTitleLabelOptions;

/// A bar chart.
///
/// The `BarChartVisual` structure describes a visual that is a member of the
/// bar chart family. The following charts can be described using this
/// structure:
///
/// * Horizontal bar chart
///
/// * Vertical bar chart
///
/// * Horizontal stacked bar chart
///
/// * Vertical stacked bar chart
///
/// * Horizontal stacked 100% bar chart
///
/// * Vertical stacked 100% bar chart
///
/// For more information, see [Using bar
/// charts](https://docs.aws.amazon.com/quicksight/latest/user/bar-charts.html)
/// in the *Amazon Quick Suite User Guide*.
pub const BarChartVisual = struct {
    /// The list of custom actions that are configured for a visual.
    actions: ?[]const VisualCustomAction,

    /// The configuration settings of the visual.
    chart_configuration: ?BarChartConfiguration,

    /// The column hierarchy that is used during drill-downs and drill-ups.
    column_hierarchies: ?[]const ColumnHierarchy,

    /// The subtitle that is displayed on the visual.
    subtitle: ?VisualSubtitleLabelOptions,

    /// The title that is displayed on the visual.
    title: ?VisualTitleLabelOptions,

    /// The alt text for the visual.
    visual_content_alt_text: ?[]const u8,

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
