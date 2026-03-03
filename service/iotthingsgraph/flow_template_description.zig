const DefinitionDocument = @import("definition_document.zig").DefinitionDocument;
const FlowTemplateSummary = @import("flow_template_summary.zig").FlowTemplateSummary;

/// An object that contains a workflow's definition and summary information.
pub const FlowTemplateDescription = struct {
    /// A workflow's definition document.
    definition: ?DefinitionDocument = null,

    /// An object that contains summary information about a workflow.
    summary: ?FlowTemplateSummary = null,

    /// The version of the user's namespace against which the workflow was
    /// validated. Use this value in your system instance.
    validated_namespace_version: ?i64 = null,

    pub const json_field_names = .{
        .definition = "definition",
        .summary = "summary",
        .validated_namespace_version = "validatedNamespaceVersion",
    };
};
