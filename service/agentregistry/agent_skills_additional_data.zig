const AgentSkillsMdDescriptor = @import("agent_skills_md_descriptor.zig").AgentSkillsMdDescriptor;

/// Additional data for an agent skills definition descriptor.
pub const AgentSkillsAdditionalData = struct {
    /// The agent skills markdown descriptor associated with the agent skills
    /// definition.
    skill_md: ?AgentSkillsMdDescriptor = null,

    pub const json_field_names = .{
        .skill_md = "skillMd",
    };
};
