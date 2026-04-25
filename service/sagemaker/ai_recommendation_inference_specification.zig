const AIRecommendationInferenceFramework = @import("ai_recommendation_inference_framework.zig").AIRecommendationInferenceFramework;

/// The inference framework for an AI recommendation job.
pub const AIRecommendationInferenceSpecification = struct {
    /// The inference framework. Valid values are `LMI` and `VLLM`.
    framework: ?AIRecommendationInferenceFramework = null,

    pub const json_field_names = .{
        .framework = "Framework",
    };
};
