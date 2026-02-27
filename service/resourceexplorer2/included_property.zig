/// Information about an additional property that describes a resource, that you
/// can optionally include in the view. This lets you view that property in
/// search results, and filter your search results based on the value of the
/// property.
pub const IncludedProperty = struct {
    /// The name of the property that is included in this view.
    ///
    /// You can specify the following property names for this field:
    ///
    /// * `tags`
    name: []const u8,

    pub const json_field_names = .{
        .name = "Name",
    };
};
