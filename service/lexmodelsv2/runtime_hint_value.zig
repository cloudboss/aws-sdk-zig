/// Provides the phrase that Amazon Lex should look for in the user's input
/// to the bot.
pub const RuntimeHintValue = struct {
    /// The phrase that Amazon Lex should look for in the user's input to the
    /// bot.
    phrase: []const u8,

    pub const json_field_names = .{
        .phrase = "phrase",
    };
};
