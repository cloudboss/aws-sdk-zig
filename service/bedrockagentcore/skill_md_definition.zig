/// The skill markdown definition for agent skills descriptors.
pub const SkillMdDefinition = struct {
    /// The inline markdown content of the skill definition.
    inline_content: ?[]const u8 = null,

    pub const json_field_names = .{
        .inline_content = "inlineContent",
    };
};
