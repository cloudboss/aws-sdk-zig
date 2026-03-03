const GenerationStatus = @import("generation_status.zig").GenerationStatus;

/// The summary of the Savings Plans recommendation generation.
pub const GenerationSummary = struct {
    /// Indicates the estimated time for when the recommendation generation will
    /// complete.
    estimated_completion_time: ?[]const u8 = null,

    /// Indicates the completion time of the recommendation generation.
    generation_completion_time: ?[]const u8 = null,

    /// Indicates the start time of the recommendation generation.
    generation_started_time: ?[]const u8 = null,

    /// Indicates whether the recommendation generation succeeded, is processing, or
    /// failed.
    generation_status: ?GenerationStatus = null,

    /// Indicates the ID for this specific recommendation.
    recommendation_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .estimated_completion_time = "EstimatedCompletionTime",
        .generation_completion_time = "GenerationCompletionTime",
        .generation_started_time = "GenerationStartedTime",
        .generation_status = "GenerationStatus",
        .recommendation_id = "RecommendationId",
    };
};
