/// Information about a recommendation, such as the timestamp for when Amazon
/// Web Services
/// made a specific recommendation.
pub const ReservationPurchaseRecommendationMetadata = struct {
    /// Additional metadata that might be applicable to the recommendation.
    additional_metadata: ?[]const u8,

    /// The timestamp for when Amazon Web Services made the recommendation.
    generation_timestamp: ?[]const u8,

    /// The ID for the recommendation.
    recommendation_id: ?[]const u8,

    pub const json_field_names = .{
        .additional_metadata = "AdditionalMetadata",
        .generation_timestamp = "GenerationTimestamp",
        .recommendation_id = "RecommendationId",
    };
};
