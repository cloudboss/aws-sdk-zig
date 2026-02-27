/// A union type that specifies the data stored on the session.
pub const RuntimeSessionDataValue = union(enum) {
    /// The string value of the data stored on the session.
    string_value: ?[]const u8,

    pub const json_field_names = .{
        .string_value = "stringValue",
    };
};
