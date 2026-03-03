const HistogramAggregatedFieldWells = @import("histogram_aggregated_field_wells.zig").HistogramAggregatedFieldWells;

/// The field well configuration of a histogram.
pub const HistogramFieldWells = struct {
    /// The field well configuration of a histogram.
    histogram_aggregated_field_wells: ?HistogramAggregatedFieldWells = null,

    pub const json_field_names = .{
        .histogram_aggregated_field_wells = "HistogramAggregatedFieldWells",
    };
};
