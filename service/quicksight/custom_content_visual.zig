const VisualCustomAction = @import("visual_custom_action.zig").VisualCustomAction;
const CustomContentConfiguration = @import("custom_content_configuration.zig").CustomContentConfiguration;
const VisualSubtitleLabelOptions = @import("visual_subtitle_label_options.zig").VisualSubtitleLabelOptions;
const VisualTitleLabelOptions = @import("visual_title_label_options.zig").VisualTitleLabelOptions;

/// A visual that contains custom content.
///
/// For more information, see [Using custom visual
/// content](https://docs.aws.amazon.com/quicksight/latest/user/custom-visual-content.html) in the *Amazon Quick Suite User Guide*.
pub const CustomContentVisual = struct {
    /// The list of custom actions that are configured for a visual.
    actions: ?[]const VisualCustomAction,

    /// The configuration of a `CustomContentVisual`.
    chart_configuration: ?CustomContentConfiguration,

    /// The dataset that is used to create the custom content visual. You can't
    /// create a visual without a dataset.
    data_set_identifier: []const u8,

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
        .data_set_identifier = "DataSetIdentifier",
        .subtitle = "Subtitle",
        .title = "Title",
        .visual_content_alt_text = "VisualContentAltText",
        .visual_id = "VisualId",
    };
};
