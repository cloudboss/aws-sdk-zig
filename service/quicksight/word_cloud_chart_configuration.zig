const ChartAxisLabelOptions = @import("chart_axis_label_options.zig").ChartAxisLabelOptions;
const WordCloudFieldWells = @import("word_cloud_field_wells.zig").WordCloudFieldWells;
const VisualInteractionOptions = @import("visual_interaction_options.zig").VisualInteractionOptions;
const WordCloudSortConfiguration = @import("word_cloud_sort_configuration.zig").WordCloudSortConfiguration;
const WordCloudOptions = @import("word_cloud_options.zig").WordCloudOptions;

/// The configuration of a word cloud visual.
pub const WordCloudChartConfiguration = struct {
    /// The label options (label text, label visibility, and sort icon visibility)
    /// for the word cloud category.
    category_label_options: ?ChartAxisLabelOptions = null,

    /// The field wells of the visual.
    field_wells: ?WordCloudFieldWells = null,

    /// The general visual interactions setup for a visual.
    interactions: ?VisualInteractionOptions = null,

    /// The sort configuration of a word cloud visual.
    sort_configuration: ?WordCloudSortConfiguration = null,

    /// The options for a word cloud visual.
    word_cloud_options: ?WordCloudOptions = null,

    pub const json_field_names = .{
        .category_label_options = "CategoryLabelOptions",
        .field_wells = "FieldWells",
        .interactions = "Interactions",
        .sort_configuration = "SortConfiguration",
        .word_cloud_options = "WordCloudOptions",
    };
};
