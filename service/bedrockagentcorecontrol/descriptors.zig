const A2aDescriptor = @import("a2_a_descriptor.zig").A2aDescriptor;
const AgentSkillsDescriptor = @import("agent_skills_descriptor.zig").AgentSkillsDescriptor;
const CustomDescriptor = @import("custom_descriptor.zig").CustomDescriptor;
const McpDescriptor = @import("mcp_descriptor.zig").McpDescriptor;

/// Contains descriptor-type-specific configurations for a registry record. Only
/// the descriptor matching the record's `descriptorType` should be populated.
pub const Descriptors = struct {
    /// The Agent-to-Agent (A2A) protocol descriptor configuration. Use this when
    /// the `descriptorType` is `A2A`.
    a_2_a: ?A2aDescriptor = null,

    /// The agent skills descriptor configuration. Use this when the
    /// `descriptorType` is `AGENT_SKILLS`.
    agent_skills: ?AgentSkillsDescriptor = null,

    /// The custom descriptor configuration. Use this when the `descriptorType` is
    /// `CUSTOM`.
    custom: ?CustomDescriptor = null,

    /// The Model Context Protocol (MCP) descriptor configuration. Use this when the
    /// `descriptorType` is `MCP`.
    mcp: ?McpDescriptor = null,

    pub const json_field_names = .{
        .a_2_a = "a2a",
        .agent_skills = "agentSkills",
        .custom = "custom",
        .mcp = "mcp",
    };
};
