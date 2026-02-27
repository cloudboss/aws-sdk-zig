/// Information about the text to search for.
pub const QueryTextInputData = struct {
    /// The text to search for.
    text: []const u8,

    pub const json_field_names = .{
        .text = "text",
    };
};
