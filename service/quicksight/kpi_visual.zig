const VisualCustomAction = @import("visual_custom_action.zig").VisualCustomAction;
const KPIConfiguration = @import("kpi_configuration.zig").KPIConfiguration;
const ColumnHierarchy = @import("column_hierarchy.zig").ColumnHierarchy;
const KPIConditionalFormatting = @import("kpi_conditional_formatting.zig").KPIConditionalFormatting;
const VisualSubtitleLabelOptions = @import("visual_subtitle_label_options.zig").VisualSubtitleLabelOptions;
const VisualTitleLabelOptions = @import("visual_title_label_options.zig").VisualTitleLabelOptions;

/// A key performance indicator (KPI).
///
/// For more information, see [Using
/// KPIs](https://docs.aws.amazon.com/quicksight/latest/user/kpi.html) in the
/// *Amazon Quick Suite User Guide*.
pub const KPIVisual = struct {
    /// The list of custom actions that are configured for a visual.
    actions: ?[]const VisualCustomAction,

    /// The configuration of a KPI visual.
    chart_configuration: ?KPIConfiguration,

    /// The column hierarchy that is used during drill-downs and drill-ups.
    column_hierarchies: ?[]const ColumnHierarchy,

    /// The conditional formatting of a KPI visual.
    conditional_formatting: ?KPIConditionalFormatting,

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
        .conditional_formatting = "ConditionalFormatting",
        .subtitle = "Subtitle",
        .title = "Title",
        .visual_content_alt_text = "VisualContentAltText",
        .visual_id = "VisualId",
    };
};
