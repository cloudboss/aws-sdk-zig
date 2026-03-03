const VisualCustomAction = @import("visual_custom_action.zig").VisualCustomAction;
const PluginVisualConfiguration = @import("plugin_visual_configuration.zig").PluginVisualConfiguration;
const VisualSubtitleLabelOptions = @import("visual_subtitle_label_options.zig").VisualSubtitleLabelOptions;
const VisualTitleLabelOptions = @import("visual_title_label_options.zig").VisualTitleLabelOptions;

/// A flexible visualization type that allows engineers
/// to create new custom charts in Quick Sight.
pub const PluginVisual = struct {
    /// The list of custom actions that are configured for a visual.
    actions: ?[]const VisualCustomAction = null,

    /// A description of the plugin field wells and their persisted properties.
    chart_configuration: ?PluginVisualConfiguration = null,

    /// The Amazon Resource Name (ARN) that reflects the plugin and version.
    plugin_arn: []const u8,

    subtitle: ?VisualSubtitleLabelOptions = null,

    title: ?VisualTitleLabelOptions = null,

    /// The alt text for the visual.
    visual_content_alt_text: ?[]const u8 = null,

    /// The ID of the visual that you want to use.
    visual_id: []const u8,

    pub const json_field_names = .{
        .actions = "Actions",
        .chart_configuration = "ChartConfiguration",
        .plugin_arn = "PluginArn",
        .subtitle = "Subtitle",
        .title = "Title",
        .visual_content_alt_text = "VisualContentAltText",
        .visual_id = "VisualId",
    };
};
