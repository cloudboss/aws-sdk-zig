/// Information about potential recommendations that might be created from the
/// analysis of profiling data.
pub const FindingsReportSummary = struct {
    /// The universally unique identifier (UUID) of the recommendation report.
    id: ?[]const u8,

    /// The end time of the period during which the metric is flagged as anomalous.
    /// This is specified
    /// using the ISO 8601 format. For example, 2020-06-01T13:15:02.001Z represents
    /// 1
    /// millisecond past June 1, 2020 1:15:02 PM UTC.
    profile_end_time: ?i64,

    /// The start time of the profile the analysis data is about.
    /// This is specified
    /// using the ISO 8601 format. For example, 2020-06-01T13:15:02.001Z represents
    /// 1
    /// millisecond past June 1, 2020 1:15:02 PM UTC.
    profile_start_time: ?i64,

    /// The name of the profiling group that is associated with the analysis data.
    profiling_group_name: ?[]const u8,

    /// The total number of different recommendations that were found by the
    /// analysis.
    total_number_of_findings: ?i32,

    pub const json_field_names = .{
        .id = "id",
        .profile_end_time = "profileEndTime",
        .profile_start_time = "profileStartTime",
        .profiling_group_name = "profilingGroupName",
        .total_number_of_findings = "totalNumberOfFindings",
    };
};
