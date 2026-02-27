const Prompt = @import("prompt.zig").Prompt;
const Statement = @import("statement.zig").Statement;

/// A prompt for additional activity after an intent is fulfilled. For
/// example, after the `OrderPizza` intent is fulfilled, you might
/// prompt the user to find out whether the user wants to order
/// drinks.
pub const FollowUpPrompt = struct {
    /// Prompts for information from the user.
    prompt: Prompt,

    /// If the user answers "no" to the question defined in the
    /// `prompt` field, Amazon Lex responds with this statement to
    /// acknowledge that the intent was canceled.
    rejection_statement: Statement,

    pub const json_field_names = .{
        .prompt = "prompt",
        .rejection_statement = "rejectionStatement",
    };
};
