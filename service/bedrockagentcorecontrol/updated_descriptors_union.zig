const UpdatedA2aDescriptor = @import("updated_a2_a_descriptor.zig").UpdatedA2aDescriptor;
const UpdatedAgentSkillsDescriptor = @import("updated_agent_skills_descriptor.zig").UpdatedAgentSkillsDescriptor;
const UpdatedCustomDescriptor = @import("updated_custom_descriptor.zig").UpdatedCustomDescriptor;
const UpdatedMcpDescriptor = @import("updated_mcp_descriptor.zig").UpdatedMcpDescriptor;

/// Contains per-descriptor-type wrappers for updating descriptors. Each
/// descriptor type can be updated independently.
pub const UpdatedDescriptorsUnion = struct {
    /// The updated A2A descriptor.
    a_2_a: ?UpdatedA2aDescriptor = null,

    /// The updated agent skills descriptor.
    agent_skills: ?UpdatedAgentSkillsDescriptor = null,

    /// The updated custom descriptor.
    custom: ?UpdatedCustomDescriptor = null,

    /// The updated MCP descriptor.
    mcp: ?UpdatedMcpDescriptor = null,

    pub const json_field_names = .{
        .a_2_a = "a2a",
        .agent_skills = "agentSkills",
        .custom = "custom",
        .mcp = "mcp",
    };
};
