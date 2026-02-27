/// A primary attribute value filter.
pub const PrimaryAttributeValueFilter = struct {
    /// The filter's attribute name.
    attribute_name: []const u8,

    /// The filter's values.
    values: []const []const u8,

    pub const json_field_names = .{
        .attribute_name = "AttributeName",
        .values = "Values",
    };
};
