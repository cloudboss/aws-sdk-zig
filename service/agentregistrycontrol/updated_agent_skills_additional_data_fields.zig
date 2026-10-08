const UpdatedAgentSkillsMdDescriptor = @import("updated_agent_skills_md_descriptor.zig").UpdatedAgentSkillsMdDescriptor;

/// The set of agent skills additional-data fields that can be individually
/// updated.
pub const UpdatedAgentSkillsAdditionalDataFields = struct {
    /// The patch for the agent skills markdown descriptor field.
    skill_md: ?UpdatedAgentSkillsMdDescriptor = null,

    pub const json_field_names = .{
        .skill_md = "skillMd",
    };
};
