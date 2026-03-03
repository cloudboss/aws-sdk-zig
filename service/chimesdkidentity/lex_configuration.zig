const InvokedBy = @import("invoked_by.zig").InvokedBy;
const RespondsTo = @import("responds_to.zig").RespondsTo;

/// The configuration for an Amazon Lex V2 bot.
pub const LexConfiguration = struct {
    /// Specifies the type of message that triggers a bot.
    invoked_by: ?InvokedBy = null,

    /// The ARN of the Amazon Lex V2 bot's alias. The ARN uses this format:
    /// `arn:aws:lex:REGION:ACCOUNT:bot-alias/MYBOTID/MYBOTALIAS`
    lex_bot_alias_arn: []const u8,

    /// Identifies the Amazon Lex V2 bot's language and locale. The string must
    /// match one of the
    /// supported locales in Amazon Lex V2. All of the intents, slot types, and
    /// slots used in the bot must have the same
    /// locale. For more information, see [Supported
    /// languages](https://docs.aws.amazon.com/lexv2/latest/dg/how-languages.html)
    /// in the *Amazon Lex V2 Developer Guide*.
    locale_id: []const u8,

    /// **Deprecated**. Use `InvokedBy` instead.
    ///
    /// Determines whether the Amazon Lex V2 bot responds to all standard messages.
    /// Control messages are not supported.
    responds_to: ?RespondsTo = null,

    /// The name of the welcome intent configured in the Amazon Lex V2 bot.
    welcome_intent: ?[]const u8 = null,

    pub const json_field_names = .{
        .invoked_by = "InvokedBy",
        .lex_bot_alias_arn = "LexBotAliasArn",
        .locale_id = "LocaleId",
        .responds_to = "RespondsTo",
        .welcome_intent = "WelcomeIntent",
    };
};
