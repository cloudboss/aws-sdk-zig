/// Arguments for a key type action.
pub const KeyTypeArguments = struct {
    /// The text string to type. Maximum length: 10,000 characters.
    text: []const u8,

    pub const json_field_names = .{
        .text = "text",
    };
};
