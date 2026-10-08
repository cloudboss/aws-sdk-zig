const ReviewSourceSummary = @import("review_source_summary.zig").ReviewSourceSummary;

/// A summary of customer reviews available for a listing, aggregated by review
/// source.
pub const ReviewSummary = struct {
    /// Review summaries from different sources, such as AWS Marketplace.
    review_source_summaries: []const ReviewSourceSummary,

    pub const json_field_names = .{
        .review_source_summaries = "reviewSourceSummaries",
    };
};
