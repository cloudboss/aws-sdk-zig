const ReviewSourceId = @import("review_source_id.zig").ReviewSourceId;

/// A review summary from a specific source, including the average rating and
/// total review count.
pub const ReviewSourceSummary = struct {
    /// The average rating across all reviews from this source.
    average_rating: []const u8,

    /// The machine-readable identifier of the review source.
    source_id: ReviewSourceId,

    /// The name of the review source, such as AWS Marketplace.
    source_name: []const u8,

    /// The URL where the reviews can be accessed at the source.
    source_url: ?[]const u8 = null,

    /// The total number of reviews available from this source.
    total_reviews: i64,

    pub const json_field_names = .{
        .average_rating = "averageRating",
        .source_id = "sourceId",
        .source_name = "sourceName",
        .source_url = "sourceUrl",
        .total_reviews = "totalReviews",
    };
};
