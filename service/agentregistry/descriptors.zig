const A2aAgentCardDescriptor = @import("a2_a_agent_card_descriptor.zig").A2aAgentCardDescriptor;
const AgentSkillsDefinitionDescriptor = @import("agent_skills_definition_descriptor.zig").AgentSkillsDefinitionDescriptor;
const AgUiDescriptor = @import("ag_ui_descriptor.zig").AgUiDescriptor;
const CustomDescriptor = @import("custom_descriptor.zig").CustomDescriptor;
const HttpDescriptor = @import("http_descriptor.zig").HttpDescriptor;
const McpServerDescriptor = @import("mcp_server_descriptor.zig").McpServerDescriptor;

/// The protocol-specific descriptors that describe how to connect to and use
/// the registry record.
pub const Descriptors = struct {
    /// The A2A agent card descriptor, populated when the record type is AGENT.
    a_2_a_agent_card: ?A2aAgentCardDescriptor = null,

    /// The agent skills definition descriptor, populated when the record type is
    /// SKILL.
    agent_skills_definition: ?AgentSkillsDefinitionDescriptor = null,

    /// The AG-UI descriptor, populated when the record exposes an AG-UI protocol
    /// endpoint.
    agui: ?AgUiDescriptor = null,

    /// The custom descriptor, populated when the record type is CUSTOM.
    custom: ?CustomDescriptor = null,

    /// The HTTP descriptor, populated when the record exposes an HTTP endpoint.
    http: ?HttpDescriptor = null,

    /// The MCP server descriptor, populated when the record type is MCP.
    mcp_server: ?McpServerDescriptor = null,

    pub const json_field_names = .{
        .a_2_a_agent_card = "a2aAgentCard",
        .agent_skills_definition = "agentSkillsDefinition",
        .agui = "agui",
        .custom = "custom",
        .http = "http",
        .mcp_server = "mcpServer",
    };
};
