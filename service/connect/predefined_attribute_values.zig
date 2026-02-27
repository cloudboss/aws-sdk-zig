/// Information about values of a predefined attribute.
pub const PredefinedAttributeValues = union(enum) {
    /// Predefined attribute values of type string list.
    string_list: ?[]const []const u8,

    pub const json_field_names = .{
        .string_list = "StringList",
    };
};
