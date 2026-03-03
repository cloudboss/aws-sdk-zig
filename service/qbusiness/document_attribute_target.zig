const AttributeValueOperator = @import("attribute_value_operator.zig").AttributeValueOperator;
const DocumentAttributeValue = @import("document_attribute_value.zig").DocumentAttributeValue;

/// The target document attribute or metadata field you want to alter when
/// ingesting documents into Amazon Q Business.
///
/// For example, you can delete all customer identification numbers associated
/// with the documents, stored in the document metadata field called
/// 'Customer_ID' by setting the target key as 'Customer_ID' and the deletion
/// flag to `TRUE`. This removes all customer ID values in the field
/// 'Customer_ID'. This would scrub personally identifiable information from
/// each document's metadata.
///
/// Amazon Q Business can't create a target field if it has not already been
/// created as an index field. After you create your index field, you can create
/// a document metadata field using [ `DocumentAttributeTarget`
/// ](https://docs.aws.amazon.com/amazonq/latest/api-reference/API_DocumentAttributeTarget.html). Amazon Q Business will then map your newly created document attribute to your index field.
///
/// You can also use this with [ `DocumentAttributeCondition`
/// ](https://docs.aws.amazon.com/amazonq/latest/api-reference/API_DocumentAttributeCondition.html).
pub const DocumentAttributeTarget = struct {
    /// `TRUE` to delete the existing target value for your specified target
    /// attribute key. You cannot create a target value and set this to `TRUE`.
    attribute_value_operator: ?AttributeValueOperator = null,

    /// The identifier of the target document attribute or metadata field. For
    /// example, 'Department' could be an identifier for the target attribute or
    /// metadata field that includes the department names associated with the
    /// documents.
    key: []const u8,

    value: ?DocumentAttributeValue = null,

    pub const json_field_names = .{
        .attribute_value_operator = "attributeValueOperator",
        .key = "key",
        .value = "value",
    };
};
