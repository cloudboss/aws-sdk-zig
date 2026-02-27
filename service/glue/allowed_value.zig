/// An object representing a value allowed for a property.
pub const AllowedValue = struct {
    /// A description of the allowed value.
    description: ?[]const u8,

    /// The value allowed for the property.
    value: []const u8,

    pub const json_field_names = .{
        .description = "Description",
        .value = "Value",
    };
};
