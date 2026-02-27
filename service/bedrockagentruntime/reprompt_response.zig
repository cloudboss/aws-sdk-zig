const Source = @import("source.zig").Source;

/// Contains details about the agent's response to reprompt the input.
pub const RepromptResponse = struct {
    /// Specifies what output is prompting the agent to reprompt the input.
    source: ?Source,

    /// The text reprompting the input.
    text: ?[]const u8,

    pub const json_field_names = .{
        .source = "source",
        .text = "text",
    };
};
