const WordCloudAggregatedFieldWells = @import("word_cloud_aggregated_field_wells.zig").WordCloudAggregatedFieldWells;

/// The field wells of a word cloud visual.
///
/// This is a union type structure. For this structure to be valid, only one of
/// the attributes can be defined.
pub const WordCloudFieldWells = struct {
    /// The aggregated field wells of a word cloud.
    word_cloud_aggregated_field_wells: ?WordCloudAggregatedFieldWells = null,

    pub const json_field_names = .{
        .word_cloud_aggregated_field_wells = "WordCloudAggregatedFieldWells",
    };
};
