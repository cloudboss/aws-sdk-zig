const DocumentAttributeCondition = @import("document_attribute_condition.zig").DocumentAttributeCondition;
const DocumentContentOperator = @import("document_content_operator.zig").DocumentContentOperator;
const DocumentAttributeTarget = @import("document_attribute_target.zig").DocumentAttributeTarget;

/// Provides the configuration information for applying basic logic to alter
/// document metadata and content when ingesting documents into Amazon Q
/// Business.
///
/// To apply advanced logic, to go beyond what you can do with basic logic, see
/// [ `HookConfiguration`
/// ](https://docs.aws.amazon.com/amazonq/latest/api-reference/API_HookConfiguration.html).
///
/// For more information, see [Custom document
/// enrichment](https://docs.aws.amazon.com/amazonq/latest/business-use-dg/custom-document-enrichment.html).
pub const InlineDocumentEnrichmentConfiguration = struct {
    condition: ?DocumentAttributeCondition = null,

    /// `TRUE` to delete content if the condition used for the target attribute is
    /// met.
    document_content_operator: ?DocumentContentOperator = null,

    target: ?DocumentAttributeTarget = null,

    pub const json_field_names = .{
        .condition = "condition",
        .document_content_operator = "documentContentOperator",
        .target = "target",
    };
};
