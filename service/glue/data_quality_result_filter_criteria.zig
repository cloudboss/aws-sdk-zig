const DataSource = @import("data_source.zig").DataSource;

/// Criteria used to return data quality results.
pub const DataQualityResultFilterCriteria = struct {
    /// Filter results by the specified data source. For example, retrieving all
    /// results for an Glue table.
    data_source: ?DataSource = null,

    /// Filter results by the specified job name.
    job_name: ?[]const u8 = null,

    /// Filter results by the specified job run ID.
    job_run_id: ?[]const u8 = null,

    /// Filter results by runs that started after this time.
    started_after: ?i64 = null,

    /// Filter results by runs that started before this time.
    started_before: ?i64 = null,

    pub const json_field_names = .{
        .data_source = "DataSource",
        .job_name = "JobName",
        .job_run_id = "JobRunId",
        .started_after = "StartedAfter",
        .started_before = "StartedBefore",
    };
};
