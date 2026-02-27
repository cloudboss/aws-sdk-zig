const BotRecommendationResultStatistics = @import("bot_recommendation_result_statistics.zig").BotRecommendationResultStatistics;

/// The object representing the URL of the bot definition, the URL of
/// the associated transcript, and a statistical summary of the bot
/// recommendation results.
pub const BotRecommendationResults = struct {
    /// The presigned url link of the associated transcript.
    associated_transcripts_url: ?[]const u8,

    /// The presigned URL link of the recommended bot definition.
    bot_locale_export_url: ?[]const u8,

    /// The statistical summary of the bot recommendation results.
    statistics: ?BotRecommendationResultStatistics,

    pub const json_field_names = .{
        .associated_transcripts_url = "associatedTranscriptsUrl",
        .bot_locale_export_url = "botLocaleExportUrl",
        .statistics = "statistics",
    };
};
