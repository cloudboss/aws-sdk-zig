/// Describes a button to use on a response card used to gather slot
/// values from a user.
pub const Button = struct {
    /// The text that appears on the button. Use this to tell the user what
    /// value is returned when they choose this button.
    text: []const u8,

    /// The value returned to Amazon Lex when the user chooses this button. This
    /// must be one of the slot values configured for the slot.
    value: []const u8,

    pub const json_field_names = .{
        .text = "text",
        .value = "value",
    };
};
