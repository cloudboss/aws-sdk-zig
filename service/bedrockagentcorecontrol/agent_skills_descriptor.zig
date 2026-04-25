const SkillDefinition = @import("skill_definition.zig").SkillDefinition;
const SkillMdDefinition = @import("skill_md_definition.zig").SkillMdDefinition;

/// The agent skills descriptor for a registry record. Contains an optional
/// skill markdown definition in human-readable format and an optional
/// structured skill definition.
pub const AgentSkillsDescriptor = struct {
    /// The structured skill definition with schema version and content.
    skill_definition: ?SkillDefinition = null,

    /// The optional skill markdown definition describing the agent's skills in a
    /// human-readable format.
    skill_md: ?SkillMdDefinition = null,

    pub const json_field_names = .{
        .skill_definition = "skillDefinition",
        .skill_md = "skillMd",
    };
};
