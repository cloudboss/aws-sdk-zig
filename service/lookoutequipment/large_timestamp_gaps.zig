const StatisticalIssueStatus = @import("statistical_issue_status.zig").StatisticalIssueStatus;

/// Entity that comprises information on large gaps between consecutive
/// timestamps in data.
pub const LargeTimestampGaps = struct {
    /// Indicates the size of the largest timestamp gap, in days.
    max_timestamp_gap_in_days: ?i32 = null,

    /// Indicates the number of large timestamp gaps, if there are any.
    number_of_large_timestamp_gaps: ?i32 = null,

    /// Indicates whether there is a potential data issue related to large gaps in
    /// timestamps.
    status: StatisticalIssueStatus,

    pub const json_field_names = .{
        .max_timestamp_gap_in_days = "MaxTimestampGapInDays",
        .number_of_large_timestamp_gaps = "NumberOfLargeTimestampGaps",
        .status = "Status",
    };
};
