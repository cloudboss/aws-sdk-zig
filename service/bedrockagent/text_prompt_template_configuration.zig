const CachePointBlock = @import("cache_point_block.zig").CachePointBlock;
const PromptInputVariable = @import("prompt_input_variable.zig").PromptInputVariable;

/// Contains configurations for a text prompt template. To include a variable,
/// enclose a word in double curly braces as in `{{variable}}`.
pub const TextPromptTemplateConfiguration = struct {
    /// A cache checkpoint within a template configuration.
    cache_point: ?CachePointBlock,

    /// An array of the variables in the prompt template.
    input_variables: ?[]const PromptInputVariable,

    /// The message for the prompt.
    text: []const u8,

    pub const json_field_names = .{
        .cache_point = "cachePoint",
        .input_variables = "inputVariables",
        .text = "text",
    };
};
