const AgentTracesConfig = @import("agent_traces_config.zig").AgentTracesConfig;
const ToolDescriptionSource = @import("tool_description_source.zig").ToolDescriptionSource;

/// Configuration for generating tool description optimization recommendations.
pub const ToolDescriptionRecommendationConfig = struct {
    /// The agent traces to analyze for generating tool description recommendations.
    agent_traces: AgentTracesConfig,

    /// The current tool descriptions to optimize.
    tool_description: ToolDescriptionSource,

    pub const json_field_names = .{
        .agent_traces = "agentTraces",
        .tool_description = "toolDescription",
    };
};
