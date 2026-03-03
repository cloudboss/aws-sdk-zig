/// Provides an overview of how data is summarized across different dimensions.
pub const SummarizationDimensionOverview = struct {
    /// Total number of occurrences for this dimension.
    count: i32,

    /// Name of the summarization dimension.
    name: []const u8,

    /// Indicates the sample values found within the dimension.
    sample_values: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .count = "count",
        .name = "name",
        .sample_values = "sampleValues",
    };
};
