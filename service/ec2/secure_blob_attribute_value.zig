/// Describes a value for a resource attribute that is a Base64-encoded binary
/// data object.
pub const SecureBlobAttributeValue = struct {
    /// The attribute value.
    value: ?[]const u8 = null,
};
