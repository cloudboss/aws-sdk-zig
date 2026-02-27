/// A ProfileObjectTypeTemplate in a list of ProfileObjectTypeTemplates.
pub const ListProfileObjectTypeTemplateItem = struct {
    /// The name of the source of the object template.
    source_name: ?[]const u8,

    /// The source of the object template.
    source_object: ?[]const u8,

    /// A unique identifier for the object template.
    template_id: ?[]const u8,

    pub const json_field_names = .{
        .source_name = "SourceName",
        .source_object = "SourceObject",
        .template_id = "TemplateId",
    };
};
