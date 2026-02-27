/// Provides detailed information about the dimensions used for event
/// summarization and aggregation.
pub const SummarizationDimensionDetail = struct {
    /// The name of the SummarizationDimensionDetail.
    name: []const u8,

    /// Value of the property used to summarize aggregated events.
    value: []const u8,

    pub const json_field_names = .{
        .name = "name",
        .value = "value",
    };
};
