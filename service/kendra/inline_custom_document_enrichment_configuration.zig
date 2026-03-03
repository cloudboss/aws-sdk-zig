const DocumentAttributeCondition = @import("document_attribute_condition.zig").DocumentAttributeCondition;
const DocumentAttributeTarget = @import("document_attribute_target.zig").DocumentAttributeTarget;

/// Provides the configuration information for applying basic logic to alter
/// document
/// metadata and content when ingesting documents into Amazon Kendra. To apply
/// advanced
/// logic, to go beyond what you can do with basic logic, see
/// [HookConfiguration](https://docs.aws.amazon.com/kendra/latest/dg/API_HookConfiguration.html).
///
/// For more information, see [Customizing document metadata
/// during the ingestion
/// process](https://docs.aws.amazon.com/kendra/latest/dg/custom-document-enrichment.html).
pub const InlineCustomDocumentEnrichmentConfiguration = struct {
    /// Configuration of the condition used for the target document attribute or
    /// metadata
    /// field when ingesting documents into Amazon Kendra.
    condition: ?DocumentAttributeCondition = null,

    /// `TRUE` to delete content if the condition used for the target attribute is
    /// met.
    document_content_deletion: bool = false,

    /// Configuration of the target document attribute or metadata field when
    /// ingesting
    /// documents into Amazon Kendra. You can also include a value.
    target: ?DocumentAttributeTarget = null,

    pub const json_field_names = .{
        .condition = "Condition",
        .document_content_deletion = "DocumentContentDeletion",
        .target = "Target",
    };
};
