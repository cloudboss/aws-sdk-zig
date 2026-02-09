/// Specifies an item and related attribute values to retrieve in a
/// `TransactGetItem` object.
pub const Get = struct {
    /// One or more substitution tokens for attribute names in the
    /// ProjectionExpression
    /// parameter.
    expression_attribute_names: ?[]const u8,

    /// A map of attribute names to `AttributeValue` objects that specifies the
    /// primary key of the item to retrieve.
    key: []const u8,

    /// A string that identifies one or more attributes of the specified item to
    /// retrieve from
    /// the table. The attributes in the expression must be separated by commas. If
    /// no attribute
    /// names are specified, then all attributes of the specified item are returned.
    /// If any of
    /// the requested attributes are not found, they do not appear in the result.
    projection_expression: ?[]const u8,

    /// The name of the table from which to retrieve the specified item. You can
    /// also provide
    /// the Amazon Resource Name (ARN) of the table in this parameter.
    table_name: []const u8,
};
