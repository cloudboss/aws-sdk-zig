/// The skill markdown definition for an agent skills descriptor.
pub const SkillMdDefinition = struct {
    /// The markdown content describing the agent's skills in a human-readable
    /// format.
    inline_content: ?[]const u8 = null,

    pub const json_field_names = .{
        .inline_content = "inlineContent",
    };
};
