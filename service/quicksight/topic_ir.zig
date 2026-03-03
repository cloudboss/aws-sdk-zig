const TopicIRContributionAnalysis = @import("topic_ir_contribution_analysis.zig").TopicIRContributionAnalysis;
const TopicIRFilterOption = @import("topic_ir_filter_option.zig").TopicIRFilterOption;
const TopicIRGroupBy = @import("topic_ir_group_by.zig").TopicIRGroupBy;
const TopicIRMetric = @import("topic_ir_metric.zig").TopicIRMetric;
const TopicSortClause = @import("topic_sort_clause.zig").TopicSortClause;
const VisualOptions = @import("visual_options.zig").VisualOptions;

/// The definition for a `TopicIR`.
pub const TopicIR = struct {
    /// The contribution analysis for the `TopicIR`.
    contribution_analysis: ?TopicIRContributionAnalysis = null,

    /// The filters for the `TopicIR`.
    filters: ?[]const []const TopicIRFilterOption = null,

    /// The GroupBy list for the `TopicIR`.
    group_by_list: ?[]const TopicIRGroupBy = null,

    /// The metrics for the `TopicIR`.
    metrics: ?[]const TopicIRMetric = null,

    /// The sort for the `TopicIR`.
    sort: ?TopicSortClause = null,

    /// The visual for the `TopicIR`.
    visual: ?VisualOptions = null,

    pub const json_field_names = .{
        .contribution_analysis = "ContributionAnalysis",
        .filters = "Filters",
        .group_by_list = "GroupByList",
        .metrics = "Metrics",
        .sort = "Sort",
        .visual = "Visual",
    };
};
