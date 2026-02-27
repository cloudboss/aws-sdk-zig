const OptimizedPrompt = @import("optimized_prompt.zig").OptimizedPrompt;

/// An event in which the prompt was optimized.
pub const OptimizedPromptEvent = struct {
    /// Contains information about the optimized prompt.
    optimized_prompt: ?OptimizedPrompt,

    pub const json_field_names = .{
        .optimized_prompt = "optimizedPrompt",
    };
};
