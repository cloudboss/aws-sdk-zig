const TemplateSourceAnalysis = @import("template_source_analysis.zig").TemplateSourceAnalysis;
const TemplateSourceTemplate = @import("template_source_template.zig").TemplateSourceTemplate;

/// The source entity of the template.
pub const TemplateSourceEntity = struct {
    /// The source analysis, if it is based on an analysis.
    source_analysis: ?TemplateSourceAnalysis,

    /// The source template, if it is based on an template.
    source_template: ?TemplateSourceTemplate,

    pub const json_field_names = .{
        .source_analysis = "SourceAnalysis",
        .source_template = "SourceTemplate",
    };
};
