/// A key-value pair that adds as a metadata to a resource used by Amazon
/// Comprehend. For
/// example, a tag with the key-value pair ‘Department’:’Sales’ might be added
/// to a resource to
/// indicate its use by a particular department.
pub const Tag = struct {
    /// The initial part of a key-value pair that forms a tag associated with a
    /// given resource.
    /// For instance, if you want to show which resources are used by which
    /// departments, you might use
    /// “Department” as the key portion of the pair, with multiple possible values
    /// such as “sales,”
    /// “legal,” and “administration.”
    key: []const u8,

    /// The second part of a key-value pair that forms a tag associated with a given
    /// resource.
    /// For instance, if you want to show which resources are used by which
    /// departments, you might use
    /// “Department” as the initial (key) portion of the pair, with a value of
    /// “sales” to indicate the
    /// sales department.
    value: ?[]const u8,

    pub const json_field_names = .{
        .key = "Key",
        .value = "Value",
    };
};
