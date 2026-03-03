const ContributionAnalysisDirection = @import("contribution_analysis_direction.zig").ContributionAnalysisDirection;
const ContributionAnalysisFactor = @import("contribution_analysis_factor.zig").ContributionAnalysisFactor;
const ContributionAnalysisSortType = @import("contribution_analysis_sort_type.zig").ContributionAnalysisSortType;
const ContributionAnalysisTimeRanges = @import("contribution_analysis_time_ranges.zig").ContributionAnalysisTimeRanges;

/// The definition for a `TopicIRContributionAnalysis`.
pub const TopicIRContributionAnalysis = struct {
    /// The direction for the `TopicIRContributionAnalysis`.
    direction: ?ContributionAnalysisDirection = null,

    /// The factors for a `TopicIRContributionAnalysis`.
    factors: ?[]const ContributionAnalysisFactor = null,

    /// The sort type for the `TopicIRContributionAnalysis`.
    sort_type: ?ContributionAnalysisSortType = null,

    /// The time ranges for the `TopicIRContributionAnalysis`.
    time_ranges: ?ContributionAnalysisTimeRanges = null,

    pub const json_field_names = .{
        .direction = "Direction",
        .factors = "Factors",
        .sort_type = "SortType",
        .time_ranges = "TimeRanges",
    };
};
