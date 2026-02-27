const DocumentAttribute = @import("document_attribute.zig").DocumentAttribute;

/// Enables filtering of responses based on document attributes or metadata
/// fields.
pub const AttributeFilter = struct {
    /// Performs a logical `AND` operation on all supplied filters.
    and_all_filters: ?[]const AttributeFilter,

    /// Returns `true` when a document contains all the specified document
    /// attributes or metadata fields. Supported for the following [document
    /// attribute value
    /// types](https://docs.aws.amazon.com/amazonq/latest/api-reference/API_DocumentAttributeValue.html): `stringListValue`.
    contains_all: ?DocumentAttribute,

    /// Returns `true` when a document contains any of the specified document
    /// attributes or metadata fields. Supported for the following [document
    /// attribute value
    /// types](https://docs.aws.amazon.com/amazonq/latest/api-reference/API_DocumentAttributeValue.html): `stringListValue`.
    contains_any: ?DocumentAttribute,

    /// Performs an equals operation on two document attributes or metadata fields.
    /// Supported for the following [document attribute value
    /// types](https://docs.aws.amazon.com/amazonq/latest/api-reference/API_DocumentAttributeValue.html): `dateValue`, `longValue`, `stringListValue` and `stringValue`.
    equals_to: ?DocumentAttribute,

    /// Performs a greater than operation on two document attributes or metadata
    /// fields. Supported for the following [document attribute value
    /// types](https://docs.aws.amazon.com/amazonq/latest/api-reference/API_DocumentAttributeValue.html): `dateValue` and `longValue`.
    greater_than: ?DocumentAttribute,

    /// Performs a greater or equals than operation on two document attributes or
    /// metadata fields. Supported for the following [document attribute value
    /// types](https://docs.aws.amazon.com/amazonq/latest/api-reference/API_DocumentAttributeValue.html): `dateValue` and `longValue`.
    greater_than_or_equals: ?DocumentAttribute,

    /// Performs a less than operation on two document attributes or metadata
    /// fields. Supported for the following [document attribute value
    /// types](https://docs.aws.amazon.com/amazonq/latest/api-reference/API_DocumentAttributeValue.html): `dateValue` and `longValue`.
    less_than: ?DocumentAttribute,

    /// Performs a less than or equals operation on two document attributes or
    /// metadata fields.Supported for the following [document attribute value
    /// type](https://docs.aws.amazon.com/amazonq/latest/api-reference/API_DocumentAttributeValue.html): `dateValue` and `longValue`.
    less_than_or_equals: ?DocumentAttribute,

    /// Performs a logical `NOT` operation on all supplied filters.
    not_filter: ?*AttributeFilter = null,

    /// Performs a logical `OR` operation on all supplied filters.
    or_all_filters: ?[]const AttributeFilter,

    pub const json_field_names = .{
        .and_all_filters = "andAllFilters",
        .contains_all = "containsAll",
        .contains_any = "containsAny",
        .equals_to = "equalsTo",
        .greater_than = "greaterThan",
        .greater_than_or_equals = "greaterThanOrEquals",
        .less_than = "lessThan",
        .less_than_or_equals = "lessThanOrEquals",
        .not_filter = "notFilter",
        .or_all_filters = "orAllFilters",
    };
};
