const A2aDescriptor = @import("a2_a_descriptor.zig").A2aDescriptor;
const AgentSkillsDescriptor = @import("agent_skills_descriptor.zig").AgentSkillsDescriptor;
const CustomDescriptor = @import("custom_descriptor.zig").CustomDescriptor;
const McpDescriptor = @import("mcp_descriptor.zig").McpDescriptor;

/// Contains the descriptor configuration for a registry record. Only the field
/// that matches the record's `descriptorType` is populated.
pub const Descriptors = struct {
    /// The A2A (Agent-to-Agent) descriptor configuration. Populated when the
    /// record's `descriptorType` is `A2A`.
    a_2_a: ?A2aDescriptor = null,

    /// The agent skills descriptor configuration. Populated when the record's
    /// `descriptorType` is `AGENT_SKILLS`.
    agent_skills: ?AgentSkillsDescriptor = null,

    /// The custom descriptor configuration. Populated when the record's
    /// `descriptorType` is `CUSTOM`.
    custom: ?CustomDescriptor = null,

    /// The MCP (Model Context Protocol) descriptor configuration. Populated when
    /// the record's `descriptorType` is `MCP`.
    mcp: ?McpDescriptor = null,

    pub const json_field_names = .{
        .a_2_a = "a2a",
        .agent_skills = "agentSkills",
        .custom = "custom",
        .mcp = "mcp",
    };
};
