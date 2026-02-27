const AIAgentType = @import("ai_agent_type.zig").AIAgentType;
const SpanMessage = @import("span_message.zig").SpanMessage;
const AIPromptType = @import("ai_prompt_type.zig").AIPromptType;
const SpanMessageValue = @import("span_message_value.zig").SpanMessageValue;

/// Contextual attributes capturing operation details, LLM configuration, usage
/// metrics, and conversation data
pub const SpanAttributes = struct {
    /// Amazon Connect agent ID
    agent_id: ?[]const u8,

    /// AI agent ARN
    ai_agent_arn: ?[]const u8,

    /// AI agent identifier
    ai_agent_id: ?[]const u8,

    /// Entity that invoked the AI agent
    ai_agent_invoker: ?[]const u8,

    /// AI agent name
    ai_agent_name: ?[]const u8,

    /// AI agent orchestrator use case
    ai_agent_orchestrator_use_case: ?[]const u8,

    /// AI agent type
    ai_agent_type: ?AIAgentType,

    /// AI agent version number
    ai_agent_version: ?i32,

    /// Number of input tokens that were retrieved from cache
    cache_read_input_tokens: ?i32,

    /// Number of input tokens that were written to cache in this request
    cache_write_input_tokens: ?i32,

    /// Amazon Connect contact identifier
    contact_id: ?[]const u8,

    /// Error classification if span failed (e.g., throttle, timeout)
    error_type: ?[]const u8,

    /// Amazon Connect contact identifier
    initial_contact_id: ?[]const u8,

    /// Input message collection sent to LLM
    input_messages: ?[]const SpanMessage,

    /// Amazon Connect instance ARN
    instance_arn: ?[]const u8,

    /// Action being performed
    operation_name: ?[]const u8,

    /// Output message collection received from LLM
    output_messages: ?[]const SpanMessage,

    /// AI prompt ARN
    prompt_arn: ?[]const u8,

    /// AI prompt identifier
    prompt_id: ?[]const u8,

    /// AI prompt name
    prompt_name: ?[]const u8,

    /// AI prompt type
    prompt_type: ?AIPromptType,

    /// AI prompt version number
    prompt_version: ?i32,

    /// Model provider identifier (e.g., aws.bedrock)
    provider_name: ?[]const u8,

    /// Maximum tokens configured for generation
    request_max_tokens: ?i32,

    /// LLM model ID for request (e.g., anthropic.claude-3-sonnet)
    request_model: ?[]const u8,

    /// Generation termination reasons (e.g., stop, max_tokens)
    response_finish_reasons: ?[]const []const u8,

    /// Actual model used for response (usually matches requestModel)
    response_model: ?[]const u8,

    /// Session name
    session_name: ?[]const u8,

    /// System prompt instructions
    system_instructions: ?[]const SpanMessageValue,

    /// Sampling temperature for generation
    temperature: ?f32,

    /// Top-p sampling parameter for generation
    top_p: ?f32,

    /// Number of input tokens in prompt
    usage_input_tokens: ?i32,

    /// Number of output tokens in response
    usage_output_tokens: ?i32,

    /// Total tokens consumed (input + output)
    usage_total_tokens: ?i32,

    pub const json_field_names = .{
        .agent_id = "agentId",
        .ai_agent_arn = "aiAgentArn",
        .ai_agent_id = "aiAgentId",
        .ai_agent_invoker = "aiAgentInvoker",
        .ai_agent_name = "aiAgentName",
        .ai_agent_orchestrator_use_case = "aiAgentOrchestratorUseCase",
        .ai_agent_type = "aiAgentType",
        .ai_agent_version = "aiAgentVersion",
        .cache_read_input_tokens = "cacheReadInputTokens",
        .cache_write_input_tokens = "cacheWriteInputTokens",
        .contact_id = "contactId",
        .error_type = "errorType",
        .initial_contact_id = "initialContactId",
        .input_messages = "inputMessages",
        .instance_arn = "instanceArn",
        .operation_name = "operationName",
        .output_messages = "outputMessages",
        .prompt_arn = "promptArn",
        .prompt_id = "promptId",
        .prompt_name = "promptName",
        .prompt_type = "promptType",
        .prompt_version = "promptVersion",
        .provider_name = "providerName",
        .request_max_tokens = "requestMaxTokens",
        .request_model = "requestModel",
        .response_finish_reasons = "responseFinishReasons",
        .response_model = "responseModel",
        .session_name = "sessionName",
        .system_instructions = "systemInstructions",
        .temperature = "temperature",
        .top_p = "topP",
        .usage_input_tokens = "usageInputTokens",
        .usage_output_tokens = "usageOutputTokens",
        .usage_total_tokens = "usageTotalTokens",
    };
};
