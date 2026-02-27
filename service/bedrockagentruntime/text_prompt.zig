/// Contains information about the text prompt to optimize.
pub const TextPrompt = struct {
    /// The text in the text prompt to optimize.
    text: []const u8,

    pub const json_field_names = .{
        .text = "text",
    };
};
