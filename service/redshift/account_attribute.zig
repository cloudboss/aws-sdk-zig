const AttributeValueTarget = @import("attribute_value_target.zig").AttributeValueTarget;

/// A name value pair that describes an aspect of an account.
pub const AccountAttribute = struct {
    /// The name of the attribute.
    attribute_name: ?[]const u8,

    /// A list of attribute values.
    attribute_values: ?[]const AttributeValueTarget,
};
