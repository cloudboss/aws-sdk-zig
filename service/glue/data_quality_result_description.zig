const DataSource = @import("data_source.zig").DataSource;

/// Describes a data quality result.
pub const DataQualityResultDescription = struct {
    /// The table name associated with the data quality result.
    data_source: ?DataSource = null,

    /// The job name associated with the data quality result.
    job_name: ?[]const u8 = null,

    /// The job run ID associated with the data quality result.
    job_run_id: ?[]const u8 = null,

    /// The unique result ID for this data quality result.
    result_id: ?[]const u8 = null,

    /// The time that the run started for this data quality result.
    started_on: ?i64 = null,

    pub const json_field_names = .{
        .data_source = "DataSource",
        .job_name = "JobName",
        .job_run_id = "JobRunId",
        .result_id = "ResultId",
        .started_on = "StartedOn",
    };
};
