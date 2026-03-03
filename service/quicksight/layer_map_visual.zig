const GeospatialLayerMapConfiguration = @import("geospatial_layer_map_configuration.zig").GeospatialLayerMapConfiguration;
const VisualSubtitleLabelOptions = @import("visual_subtitle_label_options.zig").VisualSubtitleLabelOptions;
const VisualTitleLabelOptions = @import("visual_title_label_options.zig").VisualTitleLabelOptions;

/// A layer map visual.
pub const LayerMapVisual = struct {
    /// The configuration settings of the visual.
    chart_configuration: ?GeospatialLayerMapConfiguration = null,

    /// The dataset that is used to create the layer map visual. You can't create a
    /// visual without a dataset.
    data_set_identifier: []const u8,

    subtitle: ?VisualSubtitleLabelOptions = null,

    title: ?VisualTitleLabelOptions = null,

    /// The alt text for the visual.
    visual_content_alt_text: ?[]const u8 = null,

    /// The ID of the visual.
    visual_id: []const u8,

    pub const json_field_names = .{
        .chart_configuration = "ChartConfiguration",
        .data_set_identifier = "DataSetIdentifier",
        .subtitle = "Subtitle",
        .title = "Title",
        .visual_content_alt_text = "VisualContentAltText",
        .visual_id = "VisualId",
    };
};
