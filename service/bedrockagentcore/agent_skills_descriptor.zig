const SkillDefinition = @import("skill_definition.zig").SkillDefinition;
const SkillMdDefinition = @import("skill_md_definition.zig").SkillMdDefinition;

/// The agent skills descriptor configuration for a registry record.
pub const AgentSkillsDescriptor = struct {
    /// The structured skill definition with a schema version and content.
    skill_definition: ?SkillDefinition = null,

    /// The skill description in markdown format.
    skill_md: SkillMdDefinition,

    pub const json_field_names = .{
        .skill_definition = "skillDefinition",
        .skill_md = "skillMd",
    };
};
