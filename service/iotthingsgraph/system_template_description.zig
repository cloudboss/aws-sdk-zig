const DefinitionDocument = @import("definition_document.zig").DefinitionDocument;
const SystemTemplateSummary = @import("system_template_summary.zig").SystemTemplateSummary;

/// An object that contains a system's definition document and summary
/// information.
pub const SystemTemplateDescription = struct {
    /// The definition document of a system.
    definition: ?DefinitionDocument = null,

    /// An object that contains summary information about a system.
    summary: ?SystemTemplateSummary = null,

    /// The namespace version against which the system was validated. Use this value
    /// in your system instance.
    validated_namespace_version: ?i64 = null,

    pub const json_field_names = .{
        .definition = "definition",
        .summary = "summary",
        .validated_namespace_version = "validatedNamespaceVersion",
    };
};
