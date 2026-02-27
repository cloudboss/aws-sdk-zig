const TextPrompt = @import("text_prompt.zig").TextPrompt;

/// Contains information about the optimized prompt.
pub const OptimizedPrompt = union(enum) {
    /// Contains information about the text in the prompt that was optimized.
    text_prompt: ?TextPrompt,

    pub const json_field_names = .{
        .text_prompt = "textPrompt",
    };
};
