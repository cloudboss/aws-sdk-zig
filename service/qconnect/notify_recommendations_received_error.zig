/// An error occurred when creating a recommendation.
pub const NotifyRecommendationsReceivedError = struct {
    /// A recommendation is causing an error.
    message: ?[]const u8 = null,

    /// The identifier of the recommendation that is in error.
    recommendation_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .message = "message",
        .recommendation_id = "recommendationId",
    };
};
