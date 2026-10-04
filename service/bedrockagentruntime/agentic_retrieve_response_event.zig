/// A chunk of the generated answer text.
pub const AgenticRetrieveResponseEvent = struct {
    /// The generated text chunk.
    text: []const u8,

    pub const json_field_names = .{
        .text = "text",
    };
};
