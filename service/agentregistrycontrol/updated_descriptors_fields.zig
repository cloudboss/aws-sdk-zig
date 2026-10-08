const UpdatedA2aAgentCardDescriptor = @import("updated_a2_a_agent_card_descriptor.zig").UpdatedA2aAgentCardDescriptor;
const UpdatedAgentSkillsDefinitionDescriptor = @import("updated_agent_skills_definition_descriptor.zig").UpdatedAgentSkillsDefinitionDescriptor;
const UpdatedAgUiDescriptor = @import("updated_ag_ui_descriptor.zig").UpdatedAgUiDescriptor;
const UpdatedCustomDescriptor = @import("updated_custom_descriptor.zig").UpdatedCustomDescriptor;
const UpdatedHttpDescriptor = @import("updated_http_descriptor.zig").UpdatedHttpDescriptor;
const UpdatedMcpServerDescriptor = @import("updated_mcp_server_descriptor.zig").UpdatedMcpServerDescriptor;

/// The patchable descriptor fields applied during an UpdateRegistryRecord call.
/// Each field is independently patchable.
pub const UpdatedDescriptorsFields = struct {
    /// The patch for the A2A agent card descriptor.
    a_2_a_agent_card: ?UpdatedA2aAgentCardDescriptor = null,

    /// The patch for the agent skills definition descriptor.
    agent_skills_definition: ?UpdatedAgentSkillsDefinitionDescriptor = null,

    /// The patch for the AG-UI descriptor.
    agui: ?UpdatedAgUiDescriptor = null,

    /// The patch for the custom descriptor.
    custom: ?UpdatedCustomDescriptor = null,

    /// The patch for the HTTP descriptor.
    http: ?UpdatedHttpDescriptor = null,

    /// The patch for the MCP server descriptor.
    mcp_server: ?UpdatedMcpServerDescriptor = null,

    pub const json_field_names = .{
        .a_2_a_agent_card = "a2aAgentCard",
        .agent_skills_definition = "agentSkillsDefinition",
        .agui = "agui",
        .custom = "custom",
        .http = "http",
        .mcp_server = "mcpServer",
    };
};
