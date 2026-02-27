/// A list of message attribute values.
pub const MessageAttributeValue = struct {
    /// The strings in a message attribute value.
    string_values: ?[]const []const u8,

    pub const json_field_names = .{
        .string_values = "StringValues",
    };
};
