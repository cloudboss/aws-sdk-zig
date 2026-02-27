const Reaction = @import("reaction.zig").Reaction;

/// Information about recommendation feedback summaries.
pub const RecommendationFeedbackSummary = struct {
    /// List for storing reactions. Reactions are utf-8 text code for emojis.
    reactions: ?[]const Reaction,

    /// The recommendation ID that can be used to track the provided
    /// recommendations. Later on
    /// it can be used to collect the feedback.
    recommendation_id: ?[]const u8,

    /// The ID of the user that gave the feedback.
    ///
    /// The `UserId` is an IAM principal that can be specified as an Amazon Web
    /// Services account ID or an Amazon Resource Name (ARN). For
    /// more information, see [
    /// Specifying a
    /// Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_policies_elements_principal.html#Principal_specifying) in the *Amazon Web Services Identity and Access Management User Guide*.
    user_id: ?[]const u8,

    pub const json_field_names = .{
        .reactions = "Reactions",
        .recommendation_id = "RecommendationId",
        .user_id = "UserId",
    };
};
