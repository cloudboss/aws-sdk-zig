/// A button that appears on a response card show to the user.
pub const Button = struct {
    /// The text that is displayed on the button.
    text: []const u8,

    /// The value returned to Amazon Lex V2 when a user chooses the button.
    value: []const u8,

    pub const json_field_names = .{
        .text = "text",
        .value = "value",
    };
};
