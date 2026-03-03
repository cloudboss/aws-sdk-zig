/// A primary value response.
pub const PrimaryValueResponse = struct {
    /// The value's attribute ID.
    attribute_id: ?[]const u8 = null,

    /// The value's attribute name.
    attribute_name: ?[]const u8 = null,

    /// The value's value.
    value: ?[]const u8 = null,

    pub const json_field_names = .{
        .attribute_id = "AttributeId",
        .attribute_name = "AttributeName",
        .value = "Value",
    };
};
