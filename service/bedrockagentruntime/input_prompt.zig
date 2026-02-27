const TextPrompt = @import("text_prompt.zig").TextPrompt;

/// Contains information about the prompt to optimize.
pub const InputPrompt = union(enum) {
    /// Contains information about the text prompt to optimize.
    text_prompt: ?TextPrompt,

    pub const json_field_names = .{
        .text_prompt = "textPrompt",
    };
};
