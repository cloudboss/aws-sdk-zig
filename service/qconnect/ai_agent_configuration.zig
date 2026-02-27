const AnswerRecommendationAIAgentConfiguration = @import("answer_recommendation_ai_agent_configuration.zig").AnswerRecommendationAIAgentConfiguration;
const CaseSummarizationAIAgentConfiguration = @import("case_summarization_ai_agent_configuration.zig").CaseSummarizationAIAgentConfiguration;
const EmailGenerativeAnswerAIAgentConfiguration = @import("email_generative_answer_ai_agent_configuration.zig").EmailGenerativeAnswerAIAgentConfiguration;
const EmailOverviewAIAgentConfiguration = @import("email_overview_ai_agent_configuration.zig").EmailOverviewAIAgentConfiguration;
const EmailResponseAIAgentConfiguration = @import("email_response_ai_agent_configuration.zig").EmailResponseAIAgentConfiguration;
const ManualSearchAIAgentConfiguration = @import("manual_search_ai_agent_configuration.zig").ManualSearchAIAgentConfiguration;
const NoteTakingAIAgentConfiguration = @import("note_taking_ai_agent_configuration.zig").NoteTakingAIAgentConfiguration;
const OrchestrationAIAgentConfiguration = @import("orchestration_ai_agent_configuration.zig").OrchestrationAIAgentConfiguration;
const SelfServiceAIAgentConfiguration = @import("self_service_ai_agent_configuration.zig").SelfServiceAIAgentConfiguration;

/// A typed union that specifies the configuration based on the type of AI
/// Agent.
pub const AIAgentConfiguration = union(enum) {
    /// The configuration for AI Agents of type `ANSWER_RECOMMENDATION`.
    answer_recommendation_ai_agent_configuration: ?AnswerRecommendationAIAgentConfiguration,
    /// The configuration for AI Agents of type `CASE_SUMMARIZATION`.
    case_summarization_ai_agent_configuration: ?CaseSummarizationAIAgentConfiguration,
    /// Configuration for the EMAIL_GENERATIVE_ANSWER AI agent that provides
    /// comprehensive knowledge-based answers for customer queries.
    email_generative_answer_ai_agent_configuration: ?EmailGenerativeAnswerAIAgentConfiguration,
    /// Configuration for the EMAIL_OVERVIEW AI agent that generates structured
    /// overview of email conversations.
    email_overview_ai_agent_configuration: ?EmailOverviewAIAgentConfiguration,
    /// Configuration for the EMAIL_RESPONSE AI agent that generates professional
    /// email responses using knowledge base content.
    email_response_ai_agent_configuration: ?EmailResponseAIAgentConfiguration,
    /// The configuration for AI Agents of type `MANUAL_SEARCH`.
    manual_search_ai_agent_configuration: ?ManualSearchAIAgentConfiguration,
    /// The configuration for AI Agents of type `NOTE_TAKING`.
    note_taking_ai_agent_configuration: ?NoteTakingAIAgentConfiguration,
    /// The configuration for AI Agents of type `ORCHESTRATION`.
    orchestration_ai_agent_configuration: ?OrchestrationAIAgentConfiguration,
    /// The configuration for AI Agents of type SELF_SERVICE.
    self_service_ai_agent_configuration: ?SelfServiceAIAgentConfiguration,

    pub const json_field_names = .{
        .answer_recommendation_ai_agent_configuration = "answerRecommendationAIAgentConfiguration",
        .case_summarization_ai_agent_configuration = "caseSummarizationAIAgentConfiguration",
        .email_generative_answer_ai_agent_configuration = "emailGenerativeAnswerAIAgentConfiguration",
        .email_overview_ai_agent_configuration = "emailOverviewAIAgentConfiguration",
        .email_response_ai_agent_configuration = "emailResponseAIAgentConfiguration",
        .manual_search_ai_agent_configuration = "manualSearchAIAgentConfiguration",
        .note_taking_ai_agent_configuration = "noteTakingAIAgentConfiguration",
        .orchestration_ai_agent_configuration = "orchestrationAIAgentConfiguration",
        .self_service_ai_agent_configuration = "selfServiceAIAgentConfiguration",
    };
};
