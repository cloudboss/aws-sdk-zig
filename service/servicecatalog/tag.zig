/// Information about a tag. A tag is a key-value pair. Tags are propagated
/// to the resources created when provisioning a product.
pub const Tag = struct {
    /// The tag key.
    key: []const u8,

    /// The value for this key.
    value: []const u8,

    pub const json_field_names = .{
        .key = "Key",
        .value = "Value",
    };
};
