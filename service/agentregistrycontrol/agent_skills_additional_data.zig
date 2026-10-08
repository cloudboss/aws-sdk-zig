const AgentSkillsMdDescriptor = @import("agent_skills_md_descriptor.zig").AgentSkillsMdDescriptor;

/// Additional data associated with an agent skills definition descriptor.
pub const AgentSkillsAdditionalData = struct {
    /// The markdown skill content associated with an agent skills definition.
    skill_md: ?AgentSkillsMdDescriptor = null,

    pub const json_field_names = .{
        .skill_md = "skillMd",
    };
};
