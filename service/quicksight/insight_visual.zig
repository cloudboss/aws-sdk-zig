const VisualCustomAction = @import("visual_custom_action.zig").VisualCustomAction;
const InsightConfiguration = @import("insight_configuration.zig").InsightConfiguration;
const VisualSubtitleLabelOptions = @import("visual_subtitle_label_options.zig").VisualSubtitleLabelOptions;
const VisualTitleLabelOptions = @import("visual_title_label_options.zig").VisualTitleLabelOptions;

/// An insight visual.
///
/// For more information, see [Working with
/// insights](https://docs.aws.amazon.com/quicksight/latest/user/computational-insights.html) in the *Amazon Quick Suite User Guide*.
pub const InsightVisual = struct {
    /// The list of custom actions that are configured for a visual.
    actions: ?[]const VisualCustomAction = null,

    /// The dataset that is used in the insight visual.
    data_set_identifier: []const u8,

    /// The configuration of an insight visual.
    insight_configuration: ?InsightConfiguration = null,

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
        .data_set_identifier = "DataSetIdentifier",
        .insight_configuration = "InsightConfiguration",
        .subtitle = "Subtitle",
        .title = "Title",
        .visual_content_alt_text = "VisualContentAltText",
        .visual_id = "VisualId",
    };
};
