const RecommendationSettings = @import("recommendation_settings.zig").RecommendationSettings;

/// Provides information about the source database to analyze and provide target
/// recommendations according to the specified requirements.
pub const StartRecommendationsRequestEntry = struct {
    /// The identifier of the source database.
    database_id: []const u8,

    /// The required target engine settings.
    settings: RecommendationSettings,

    pub const json_field_names = .{
        .database_id = "DatabaseId",
        .settings = "Settings",
    };
};
