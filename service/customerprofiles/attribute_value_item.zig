/// List containing the values for the given attribute.
pub const AttributeValueItem = struct {
    /// An individual value belonging to the given attribute.
    value: ?[]const u8 = null,

    pub const json_field_names = .{
        .value = "Value",
    };
};
