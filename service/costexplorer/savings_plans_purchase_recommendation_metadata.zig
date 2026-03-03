/// Metadata about your Savings Plans Purchase Recommendations.
pub const SavingsPlansPurchaseRecommendationMetadata = struct {
    /// Additional metadata that might be applicable to the recommendation.
    additional_metadata: ?[]const u8 = null,

    /// The timestamp that shows when the recommendations were generated.
    generation_timestamp: ?[]const u8 = null,

    /// The unique identifier for the recommendation set.
    recommendation_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .additional_metadata = "AdditionalMetadata",
        .generation_timestamp = "GenerationTimestamp",
        .recommendation_id = "RecommendationId",
    };
};
