/// The structured skill definition with schema version and content.
pub const SkillDefinition = struct {
    /// The JSON content containing the structured skill definition.
    inline_content: ?[]const u8 = null,

    /// The version of the skill definition schema.
    schema_version: ?[]const u8 = null,

    pub const json_field_names = .{
        .inline_content = "inlineContent",
        .schema_version = "schemaVersion",
    };
};
