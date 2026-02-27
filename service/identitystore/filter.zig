/// A query filter used by `ListUsers` and `ListGroups`. This filter object
/// provides the attribute name and attribute value to search users or groups.
pub const Filter = struct {
    /// The attribute path that is used to specify which attribute name to search.
    /// Length limit is 255 characters. For example, `UserName` is a valid attribute
    /// path for the ` ListUsers` API, and `DisplayName` is a valid attribute path
    /// for the ` ListGroups` API.
    attribute_path: []const u8,

    /// Represents the data for an attribute. Each attribute value is described as a
    /// name-value pair.
    attribute_value: []const u8,

    pub const json_field_names = .{
        .attribute_path = "AttributePath",
        .attribute_value = "AttributeValue",
    };
};
