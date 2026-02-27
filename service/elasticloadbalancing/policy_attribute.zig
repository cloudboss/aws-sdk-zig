/// Information about a policy attribute.
pub const PolicyAttribute = struct {
    /// The name of the attribute.
    attribute_name: ?[]const u8,

    /// The value of the attribute.
    attribute_value: ?[]const u8,
};
