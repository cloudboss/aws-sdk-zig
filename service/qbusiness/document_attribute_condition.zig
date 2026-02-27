const DocumentEnrichmentConditionOperator = @import("document_enrichment_condition_operator.zig").DocumentEnrichmentConditionOperator;
const DocumentAttributeValue = @import("document_attribute_value.zig").DocumentAttributeValue;

/// The condition used for the target document attribute or metadata field when
/// ingesting documents into Amazon Q Business. You use this with [
/// `DocumentAttributeTarget`
/// ](https://docs.aws.amazon.com/amazonq/latest/api-reference/API_DocumentAttributeTarget.html) to apply the condition.
///
/// For example, you can create the 'Department' target field and have it
/// prefill department names associated with the documents based on information
/// in the 'Source_URI' field. Set the condition that if the 'Source_URI' field
/// contains 'financial' in its URI value, then prefill the target field
/// 'Department' with the target value 'Finance' for the document.
///
/// Amazon Q Business can't create a target field if it has not already been
/// created as an index field. After you create your index field, you can create
/// a document metadata field using `DocumentAttributeTarget`. Amazon Q Business
/// then will map your newly created metadata field to your index field.
pub const DocumentAttributeCondition = struct {
    /// The identifier of the document attribute used for the condition.
    ///
    /// For example, 'Source_URI' could be an identifier for the attribute or
    /// metadata field that contains source URIs associated with the documents.
    ///
    /// Amazon Q Business currently doesn't support `_document_body` as an attribute
    /// key used for the condition.
    key: []const u8,

    /// The identifier of the document attribute used for the condition.
    ///
    /// For example, 'Source_URI' could be an identifier for the attribute or
    /// metadata field that contains source URIs associated with the documents.
    ///
    /// Amazon Q Business currently does not support `_document_body` as an
    /// attribute key used for the condition.
    operator: DocumentEnrichmentConditionOperator,

    value: ?DocumentAttributeValue,

    pub const json_field_names = .{
        .key = "key",
        .operator = "operator",
        .value = "value",
    };
};
