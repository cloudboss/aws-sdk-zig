pub const HITReviewStatus = enum {
    not_reviewed,
    marked_for_review,
    reviewed_appropriate,
    reviewed_inappropriate,

    pub const json_field_names = .{
        .not_reviewed = "NotReviewed",
        .marked_for_review = "MarkedForReview",
        .reviewed_appropriate = "ReviewedAppropriate",
        .reviewed_inappropriate = "ReviewedInappropriate",
    };
};
