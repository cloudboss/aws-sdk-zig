/// Text delta containing a text fragment
pub const SendMessageTextDelta = struct {
    /// The text fragment
    text: ?[]const u8 = null,

    pub const json_field_names = .{
        .text = "text",
    };
};
