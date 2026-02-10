/// Describes a value for a resource attribute that is a String.
pub const AttributeValue = struct {
    /// The attribute value. The value is case-sensitive.
    value: ?[]const u8,
};
