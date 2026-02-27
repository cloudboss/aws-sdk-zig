const SummarizationDimensionOverview = @import("summarization_dimension_overview.zig").SummarizationDimensionOverview;
const AggregationKey = @import("aggregation_key.zig").AggregationKey;

/// Provides additional information about the aggregation key.
pub const AggregationSummary = struct {
    /// List of additional dimensions used to group and summarize data.
    additional_summarization_dimensions: ?[]const SummarizationDimensionOverview,

    /// Indicates the Amazon Web Services accounts in the aggregation key.
    aggregated_accounts: SummarizationDimensionOverview,

    /// Indicates the criteria or rules by which notifications have been grouped
    /// together.
    aggregated_by: []const AggregationKey,

    /// Indicates the collection of organizational units that are involved in the
    /// aggregation key.
    aggregated_organizational_units: ?SummarizationDimensionOverview,

    /// Indicates the Amazon Web Services Regions in the aggregation key.
    aggregated_regions: SummarizationDimensionOverview,

    /// Indicates the number of events associated with the aggregation key.
    event_count: i32,

    pub const json_field_names = .{
        .additional_summarization_dimensions = "additionalSummarizationDimensions",
        .aggregated_accounts = "aggregatedAccounts",
        .aggregated_by = "aggregatedBy",
        .aggregated_organizational_units = "aggregatedOrganizationalUnits",
        .aggregated_regions = "aggregatedRegions",
        .event_count = "eventCount",
    };
};
