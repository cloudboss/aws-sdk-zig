const AttributeItem = @import("attribute_item.zig").AttributeItem;

/// Mathematical expression and a list of attribute items specified in that
/// expression.
pub const AttributeDetails = struct {
    /// A list of attribute items specified in the mathematical expression.
    attributes: []const AttributeItem,

    /// Mathematical expression that is performed on attribute items provided in the
    /// attribute
    /// list. Each element in the expression should follow the structure of
    /// \"{ObjectTypeName.AttributeName}\".
    expression: []const u8,

    pub const json_field_names = .{
        .attributes = "Attributes",
        .expression = "Expression",
    };
};
