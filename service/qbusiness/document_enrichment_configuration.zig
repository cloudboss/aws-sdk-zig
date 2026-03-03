const InlineDocumentEnrichmentConfiguration = @import("inline_document_enrichment_configuration.zig").InlineDocumentEnrichmentConfiguration;
const HookConfiguration = @import("hook_configuration.zig").HookConfiguration;

/// Provides the configuration information for altering document metadata and
/// content during the document ingestion process.
///
/// For more information, see [Custom document
/// enrichment](https://docs.aws.amazon.com/amazonq/latest/business-use-dg/custom-document-enrichment.html).
pub const DocumentEnrichmentConfiguration = struct {
    /// Configuration information to alter document attributes or metadata fields
    /// and content when ingesting documents into Amazon Q Business.
    inline_configurations: ?[]const InlineDocumentEnrichmentConfiguration = null,

    post_extraction_hook_configuration: ?HookConfiguration = null,

    pre_extraction_hook_configuration: ?HookConfiguration = null,

    pub const json_field_names = .{
        .inline_configurations = "inlineConfigurations",
        .post_extraction_hook_configuration = "postExtractionHookConfiguration",
        .pre_extraction_hook_configuration = "preExtractionHookConfiguration",
    };
};
