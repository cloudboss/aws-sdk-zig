const ToolConfiguration = @import("tool_configuration.zig").ToolConfiguration;

/// The configuration for AI Agents of type `ORCHESTRATION`.
pub const OrchestrationAIAgentConfiguration = struct {
    /// The Amazon Resource Name (ARN) of the Amazon Connect instance used by the
    /// Orchestration AI Agent.
    connect_instance_arn: ?[]const u8,

    /// The locale setting for the Orchestration AI Agent.
    locale: ?[]const u8,

    /// The AI Guardrail identifier used by the Orchestration AI Agent.
    orchestration_ai_guardrail_id: ?[]const u8,

    /// The AI Prompt identifier used by the Orchestration AI Agent.
    orchestration_ai_prompt_id: []const u8,

    /// The tool configurations used by the Orchestration AI Agent.
    tool_configurations: ?[]const ToolConfiguration,

    pub const json_field_names = .{
        .connect_instance_arn = "connectInstanceArn",
        .locale = "locale",
        .orchestration_ai_guardrail_id = "orchestrationAIGuardrailId",
        .orchestration_ai_prompt_id = "orchestrationAIPromptId",
        .tool_configurations = "toolConfigurations",
    };
};
