const DocumentAttributeValue = @import("document_attribute_value.zig").DocumentAttributeValue;
const ConditionOperator = @import("condition_operator.zig").ConditionOperator;

/// The condition used for the target document attribute or metadata field when
/// ingesting
/// documents into Amazon Kendra. You use this with [DocumentAttributeTarget to
/// apply the
/// condition](https://docs.aws.amazon.com/kendra/latest/dg/API_DocumentAttributeTarget.html).
///
/// For example, you can create the 'Department' target field and have it
/// prefill
/// department names associated with the documents based on information in the
/// 'Source_URI'
/// field. Set the condition that if the 'Source_URI' field contains 'financial'
/// in its URI
/// value, then prefill the target field 'Department' with the target value
/// 'Finance' for
/// the document.
///
/// Amazon Kendra cannot create a target field if it has not already been
/// created as
/// an index field. After you create your index field, you can create a document
/// metadata
/// field using `DocumentAttributeTarget`. Amazon Kendra then will map your
/// newly created metadata field to your index field.
pub const DocumentAttributeCondition = struct {
    /// The identifier of the document attribute used for the condition.
    ///
    /// For example, 'Source_URI' could be an identifier for the attribute or
    /// metadata field
    /// that contains source URIs associated with the documents.
    ///
    /// Amazon Kendra currently does not support `_document_body` as an
    /// attribute key used for the condition.
    condition_document_attribute_key: []const u8,

    /// The value used by the operator.
    ///
    /// For example, you can specify the value 'financial' for strings in the
    /// 'Source_URI'
    /// field that partially match or contain this value.
    condition_on_value: ?DocumentAttributeValue = null,

    /// The condition operator.
    ///
    /// For example, you can use 'Contains' to partially match a string.
    operator: ConditionOperator,

    pub const json_field_names = .{
        .condition_document_attribute_key = "ConditionDocumentAttributeKey",
        .condition_on_value = "ConditionOnValue",
        .operator = "Operator",
    };
};
