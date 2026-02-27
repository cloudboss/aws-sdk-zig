/// Represents an option to be shown on the client platform (Facebook,
/// Slack, etc.)
pub const Button = struct {
    /// Text that is visible to the user on the button.
    text: []const u8,

    /// The value sent to Amazon Lex when a user chooses the button. For
    /// example, consider button text "NYC." When the user chooses the button, the
    /// value sent can be "New York City."
    value: []const u8,

    pub const json_field_names = .{
        .text = "text",
        .value = "value",
    };
};
