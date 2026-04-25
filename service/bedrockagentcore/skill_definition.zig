/// The structured skill definition with a schema version and inline content.
pub const SkillDefinition = struct {
    /// The inline content of the skill definition.
    inline_content: ?[]const u8 = null,

    /// The schema version of the skill definition. If you don't specify a version,
    /// the service detects it automatically.
    schema_version: ?[]const u8 = null,

    pub const json_field_names = .{
        .inline_content = "inlineContent",
        .schema_version = "schemaVersion",
    };
};
