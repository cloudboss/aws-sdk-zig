const SummarizationDimensionDetail = @import("summarization_dimension_detail.zig").SummarizationDimensionDetail;

/// Provides detailed information about the dimensions used for aggregation.
pub const AggregationDetail = struct {
    /// Properties used to summarize aggregated events.
    summarization_dimensions: ?[]const SummarizationDimensionDetail,

    pub const json_field_names = .{
        .summarization_dimensions = "summarizationDimensions",
    };
};
