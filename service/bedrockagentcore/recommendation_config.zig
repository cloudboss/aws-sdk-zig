const SystemPromptRecommendationConfig = @import("system_prompt_recommendation_config.zig").SystemPromptRecommendationConfig;
const ToolDescriptionRecommendationConfig = @import("tool_description_recommendation_config.zig").ToolDescriptionRecommendationConfig;

/// The configuration for a recommendation, varying by recommendation type.
pub const RecommendationConfig = union(enum) {
    /// The configuration for a system prompt recommendation.
    system_prompt_recommendation_config: ?SystemPromptRecommendationConfig,
    /// The configuration for a tool description recommendation.
    tool_description_recommendation_config: ?ToolDescriptionRecommendationConfig,

    pub const json_field_names = .{
        .system_prompt_recommendation_config = "systemPromptRecommendationConfig",
        .tool_description_recommendation_config = "toolDescriptionRecommendationConfig",
    };
};
