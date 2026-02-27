/// A key-value pair that adds as a metadata to a resource used by Amazon
/// Translate.
pub const Tag = struct {
    /// The initial part of a key-value pair that forms a tag associated with a
    /// given resource.
    key: []const u8,

    /// The second part of a key-value pair that forms a tag associated with a given
    /// resource.
    value: []const u8,

    pub const json_field_names = .{
        .key = "Key",
        .value = "Value",
    };
};
