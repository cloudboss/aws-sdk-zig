/// Configuration information of an Amazon Lex V2 bot.
pub const LexV2Bot = struct {
    /// The Amazon Resource Name (ARN) of the Amazon Lex V2 bot.
    alias_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .alias_arn = "AliasArn",
    };
};
