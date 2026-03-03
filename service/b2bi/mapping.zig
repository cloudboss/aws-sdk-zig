const MappingTemplateLanguage = @import("mapping_template_language.zig").MappingTemplateLanguage;

/// Specifies the mapping template for the transformer. This template is used to
/// map the parsed EDI file using JSONata or XSLT.
pub const Mapping = struct {
    /// A string that represents the mapping template, in the transformation
    /// language specified in `templateLanguage`.
    template: ?[]const u8 = null,

    /// The transformation language for the template, either XSLT or JSONATA.
    template_language: MappingTemplateLanguage,

    pub const json_field_names = .{
        .template = "template",
        .template_language = "templateLanguage",
    };
};
