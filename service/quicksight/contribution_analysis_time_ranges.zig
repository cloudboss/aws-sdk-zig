const TopicIRFilterOption = @import("topic_ir_filter_option.zig").TopicIRFilterOption;

/// The definition for the `ContributionAnalysisTimeRanges`.
pub const ContributionAnalysisTimeRanges = struct {
    /// The end range for the `ContributionAnalysisTimeRanges`.
    end_range: ?TopicIRFilterOption = null,

    /// The start range for the `ContributionAnalysisTimeRanges`.
    start_range: ?TopicIRFilterOption = null,

    pub const json_field_names = .{
        .end_range = "EndRange",
        .start_range = "StartRange",
    };
};
