const DataSource = @import("data_source.zig").DataSource;

/// The filter criteria.
pub const DataQualityRulesetEvaluationRunFilter = struct {
    /// Filter based on a data source (an Glue table) associated with the run.
    data_source: DataSource,

    /// Filter results by runs that started after this time.
    started_after: ?i64 = null,

    /// Filter results by runs that started before this time.
    started_before: ?i64 = null,

    pub const json_field_names = .{
        .data_source = "DataSource",
        .started_after = "StartedAfter",
        .started_before = "StartedBefore",
    };
};
