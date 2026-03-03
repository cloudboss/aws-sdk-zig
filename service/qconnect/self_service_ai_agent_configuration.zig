const AssociationConfiguration = @import("association_configuration.zig").AssociationConfiguration;

/// The configuration for AI Agents of type SELF_SERVICE.
pub const SelfServiceAIAgentConfiguration = struct {
    /// The association configurations for overriding behavior on this AI Agent.
    association_configurations: ?[]const AssociationConfiguration = null,

    /// The AI Guardrail identifier used by the SELF_SERVICE AI Agent.
    self_service_ai_guardrail_id: ?[]const u8 = null,

    /// The AI Prompt identifier for the Self Service Answer Generation prompt used
    /// by the SELF_SERVICE AI Agent
    self_service_answer_generation_ai_prompt_id: ?[]const u8 = null,

    /// The AI Prompt identifier for the Self Service Pre-Processing prompt used by
    /// the SELF_SERVICE AI Agent
    self_service_pre_processing_ai_prompt_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .association_configurations = "associationConfigurations",
        .self_service_ai_guardrail_id = "selfServiceAIGuardrailId",
        .self_service_answer_generation_ai_prompt_id = "selfServiceAnswerGenerationAIPromptId",
        .self_service_pre_processing_ai_prompt_id = "selfServicePreProcessingAIPromptId",
    };
};
