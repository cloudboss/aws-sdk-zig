const LookbackPeriodInDays = @import("lookback_period_in_days.zig").LookbackPeriodInDays;

/// Metadata for a recommendation set.
pub const RightsizingRecommendationMetadata = struct {
    /// Additional metadata that might be applicable to the recommendation.
    additional_metadata: ?[]const u8,

    /// The timestamp for when Amazon Web Services made the recommendation.
    generation_timestamp: ?[]const u8,

    /// The number of days of previous usage that Amazon Web Services considers when
    /// making the
    /// recommendation.
    lookback_period_in_days: ?LookbackPeriodInDays,

    /// The ID for the recommendation.
    recommendation_id: ?[]const u8,

    pub const json_field_names = .{
        .additional_metadata = "AdditionalMetadata",
        .generation_timestamp = "GenerationTimestamp",
        .lookback_period_in_days = "LookbackPeriodInDays",
        .recommendation_id = "RecommendationId",
    };
};
