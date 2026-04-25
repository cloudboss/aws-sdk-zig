const HarnessAgentCoreBrowserConfig = @import("harness_agent_core_browser_config.zig").HarnessAgentCoreBrowserConfig;
const HarnessAgentCoreCodeInterpreterConfig = @import("harness_agent_core_code_interpreter_config.zig").HarnessAgentCoreCodeInterpreterConfig;
const HarnessAgentCoreGatewayConfig = @import("harness_agent_core_gateway_config.zig").HarnessAgentCoreGatewayConfig;
const HarnessInlineFunctionConfig = @import("harness_inline_function_config.zig").HarnessInlineFunctionConfig;
const HarnessRemoteMcpConfig = @import("harness_remote_mcp_config.zig").HarnessRemoteMcpConfig;

/// Configuration union for different tool types.
pub const HarnessToolConfiguration = union(enum) {
    /// Configuration for AgentCore Browser.
    agent_core_browser: ?HarnessAgentCoreBrowserConfig,
    /// Configuration for AgentCore Code Interpreter.
    agent_core_code_interpreter: ?HarnessAgentCoreCodeInterpreterConfig,
    /// Configuration for AgentCore Gateway.
    agent_core_gateway: ?HarnessAgentCoreGatewayConfig,
    /// Configuration for an inline function tool.
    inline_function: ?HarnessInlineFunctionConfig,
    /// Configuration for remote MCP server.
    remote_mcp: ?HarnessRemoteMcpConfig,

    pub const json_field_names = .{
        .agent_core_browser = "agentCoreBrowser",
        .agent_core_code_interpreter = "agentCoreCodeInterpreter",
        .agent_core_gateway = "agentCoreGateway",
        .inline_function = "inlineFunction",
        .remote_mcp = "remoteMcp",
    };
};
