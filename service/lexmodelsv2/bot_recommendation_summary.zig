const BotRecommendationStatus = @import("bot_recommendation_status.zig").BotRecommendationStatus;

/// A summary of the bot recommendation.
pub const BotRecommendationSummary = struct {
    /// The unique identifier of the bot recommendation to be
    /// updated.
    bot_recommendation_id: []const u8,

    /// The status of the bot recommendation.
    ///
    /// If the status is Failed, then the reasons for the failure are listed
    /// in the failureReasons field.
    bot_recommendation_status: BotRecommendationStatus,

    /// A timestamp of the date and time that the bot recommendation was
    /// created.
    creation_date_time: ?i64 = null,

    /// A timestamp of the date and time that the bot recommendation was
    /// last updated.
    last_updated_date_time: ?i64 = null,

    pub const json_field_names = .{
        .bot_recommendation_id = "botRecommendationId",
        .bot_recommendation_status = "botRecommendationStatus",
        .creation_date_time = "creationDateTime",
        .last_updated_date_time = "lastUpdatedDateTime",
    };
};
