const DocumentAttribute = @import("document_attribute.zig").DocumentAttribute;

/// Filters the search results based on document attributes or fields.
///
/// You can filter results using attributes for your particular documents. The
/// attributes
/// must exist in your index. For example, if your documents include the custom
/// attribute
/// "Department", you can filter documents that belong to the "HR" department.
/// You would use
/// the `EqualsTo` operation to filter results or documents with "Department"
/// equals
/// to "HR".
///
/// You can use `AndAllFilters` and `OrAllFilters` in combination with
/// each other or with other operations such as `EqualsTo`. For example:
///
/// `AndAllFilters`
///
/// * `EqualsTo`: "Department", "HR"
///
/// * `OrAllFilters`
///
/// * `ContainsAny`: "Project Name", ["new hires", "new hiring"]
///
/// This example filters results or documents that belong to the HR department
/// `AND` belong to projects that contain "new hires"
/// `OR` "new hiring" in the project name (must use
/// `ContainAny` with `StringListValue`). This example is filtering
/// with a depth of 2.
///
/// You cannot filter more than a depth of 2, otherwise you receive a
/// `ValidationException` exception with the message "AttributeFilter cannot
/// have
/// a depth of more than 2." Also, if you use more than 10 attribute filters in
/// a given list
/// for `AndAllFilters` or `OrAllFilters`, you receive a
/// `ValidationException` with the message "AttributeFilter cannot have a length
/// of more than 10".
///
/// For examples of using `AttributeFilter`, see [Using document attributes to
/// filter search
/// results](https://docs.aws.amazon.com/kendra/latest/dg/filtering.html#search-filtering).
pub const AttributeFilter = struct {
    /// Performs a logical `AND` operation on all filters that you specify.
    and_all_filters: ?[]const AttributeFilter,

    /// Returns true when a document contains all of the specified document
    /// attributes/fields.
    /// This filter is only applicable to
    /// [StringListValue](https://docs.aws.amazon.com/kendra/latest/APIReference/API_DocumentAttributeValue.html).
    contains_all: ?DocumentAttribute,

    /// Returns true when a document contains any of the specified document
    /// attributes/fields.
    /// This filter is only applicable to
    /// [StringListValue](https://docs.aws.amazon.com/kendra/latest/APIReference/API_DocumentAttributeValue.html).
    contains_any: ?DocumentAttribute,

    /// Performs an equals operation on document attributes/fields and their values.
    equals_to: ?DocumentAttribute,

    /// Performs a greater than operation on document attributes/fields and their
    /// values. Use
    /// with the [document attribute
    /// type](https://docs.aws.amazon.com/kendra/latest/APIReference/API_DocumentAttributeValue.html)
    /// `Date` or `Long`.
    greater_than: ?DocumentAttribute,

    /// Performs a greater or equals than operation on document attributes/fields
    /// and their
    /// values. Use with the [document attribute
    /// type](https://docs.aws.amazon.com/kendra/latest/APIReference/API_DocumentAttributeValue.html)
    /// `Date` or `Long`.
    greater_than_or_equals: ?DocumentAttribute,

    /// Performs a less than operation on document attributes/fields and their
    /// values. Use with
    /// the [document attribute
    /// type](https://docs.aws.amazon.com/kendra/latest/APIReference/API_DocumentAttributeValue.html)
    /// `Date` or `Long`.
    less_than: ?DocumentAttribute,

    /// Performs a less than or equals operation on document attributes/fields and
    /// their values.
    /// Use with the [document attribute
    /// type](https://docs.aws.amazon.com/kendra/latest/APIReference/API_DocumentAttributeValue.html)
    /// `Date` or `Long`.
    less_than_or_equals: ?DocumentAttribute,

    /// Performs a logical `NOT` operation on all filters that you specify.
    not_filter: ?*AttributeFilter = null,

    /// Performs a logical `OR` operation on all filters that you specify.
    or_all_filters: ?[]const AttributeFilter,

    pub const json_field_names = .{
        .and_all_filters = "AndAllFilters",
        .contains_all = "ContainsAll",
        .contains_any = "ContainsAny",
        .equals_to = "EqualsTo",
        .greater_than = "GreaterThan",
        .greater_than_or_equals = "GreaterThanOrEquals",
        .less_than = "LessThan",
        .less_than_or_equals = "LessThanOrEquals",
        .not_filter = "NotFilter",
        .or_all_filters = "OrAllFilters",
    };
};
