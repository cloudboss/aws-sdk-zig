const Reaction = @import("reaction.zig").Reaction;

/// Information about the recommendation feedback.
pub const RecommendationFeedback = struct {
    /// The Amazon Resource Name (ARN) of the
    /// [CodeReview](https://docs.aws.amazon.com/codeguru/latest/reviewer-api/API_CodeReview.html) object.
    code_review_arn: ?[]const u8,

    /// The time at which the feedback was created.
    created_time_stamp: ?i64,

    /// The time at which the feedback was last updated.
    last_updated_time_stamp: ?i64,

    /// List for storing reactions. Reactions are utf-8 text code for emojis. You
    /// can send an
    /// empty list to clear off all your feedback.
    reactions: ?[]const Reaction,

    /// The recommendation ID that can be used to track the provided
    /// recommendations. Later on
    /// it can be used to collect the feedback.
    recommendation_id: ?[]const u8,

    /// The ID of the user that made the API call.
    ///
    /// The `UserId` is an IAM principal that can be specified as an Amazon Web
    /// Services account ID or an Amazon Resource Name (ARN). For
    /// more information, see [
    /// Specifying a
    /// Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_policies_elements_principal.html#Principal_specifying) in the *Amazon Web Services Identity and Access Management User Guide*.
    user_id: ?[]const u8,

    pub const json_field_names = .{
        .code_review_arn = "CodeReviewArn",
        .created_time_stamp = "CreatedTimeStamp",
        .last_updated_time_stamp = "LastUpdatedTimeStamp",
        .reactions = "Reactions",
        .recommendation_id = "RecommendationId",
        .user_id = "UserId",
    };
};
