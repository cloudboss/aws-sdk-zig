const SystemPromptRecommendationResult = @import("system_prompt_recommendation_result.zig").SystemPromptRecommendationResult;
const ToolDescriptionRecommendationResult = @import("tool_description_recommendation_result.zig").ToolDescriptionRecommendationResult;

/// The result of a recommendation, containing the optimized output.
pub const RecommendationResult = union(enum) {
    /// The result of a system prompt recommendation.
    system_prompt_recommendation_result: ?SystemPromptRecommendationResult,
    /// The result of a tool description recommendation.
    tool_description_recommendation_result: ?ToolDescriptionRecommendationResult,

    pub const json_field_names = .{
        .system_prompt_recommendation_result = "systemPromptRecommendationResult",
        .tool_description_recommendation_result = "toolDescriptionRecommendationResult",
    };
};
