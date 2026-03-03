const LexBot = @import("lex_bot.zig").LexBot;
const LexV2Bot = @import("lex_v2_bot.zig").LexV2Bot;

/// Configuration information of an Amazon Lex or Amazon Lex V2 bot.
pub const LexBotConfig = struct {
    lex_bot: ?LexBot = null,

    /// Configuration information of an Amazon Lex V2 bot.
    lex_v2_bot: ?LexV2Bot = null,

    pub const json_field_names = .{
        .lex_bot = "LexBot",
        .lex_v2_bot = "LexV2Bot",
    };
};
