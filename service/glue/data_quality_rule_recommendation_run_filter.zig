const DataSource = @import("data_source.zig").DataSource;

/// A filter for listing data quality recommendation runs.
pub const DataQualityRuleRecommendationRunFilter = struct {
    /// Filter based on a specified data source (Glue table).
    data_source: DataSource,

    /// Filter based on time for results started after provided time.
    started_after: ?i64 = null,

    /// Filter based on time for results started before provided time.
    started_before: ?i64 = null,

    pub const json_field_names = .{
        .data_source = "DataSource",
        .started_after = "StartedAfter",
        .started_before = "StartedBefore",
    };
};
