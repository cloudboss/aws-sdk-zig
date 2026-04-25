const UpdatedSkillDefinition = @import("updated_skill_definition.zig").UpdatedSkillDefinition;
const UpdatedSkillMdDefinition = @import("updated_skill_md_definition.zig").UpdatedSkillMdDefinition;

/// Individual agent skills descriptor fields that can be updated independently.
pub const UpdatedAgentSkillsDescriptorFields = struct {
    /// The updated skill definition.
    skill_definition: ?UpdatedSkillDefinition = null,

    /// The updated skill markdown definition.
    skill_md: ?UpdatedSkillMdDefinition = null,

    pub const json_field_names = .{
        .skill_definition = "skillDefinition",
        .skill_md = "skillMd",
    };
};
